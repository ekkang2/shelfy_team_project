import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/data/gvm/record_view_model/record_view_model.dart';
import 'package:shelfy_team_project/ui/widgets/custom_elevated_button.dart';

import '../../../data/model/book_model/book.dart';
import '../../pages/books/widget/read_period.dart';
import '../custom_interactive_star_rating.dart';

class StopRecordStateTab extends ConsumerStatefulWidget {
  // final Book book;
  String bookId;
  int bookPage;
  StopRecordStateTab({required this.bookId, required this.bookPage, super.key});

  @override
  _StopRecordStateTabState createState() => _StopRecordStateTabState();
}

class _StopRecordStateTabState extends ConsumerState<StopRecordStateTab> {
  int _progress = 0; // 📌 멈춘 페이지 저장
  double _rating = 0.0; // ⭐ 별점 저장
  DateTime _startDate = DateTime.now(); // 📆 시작 날짜
  DateTime? _endDate; // 📆 종료 날짜
  final TextEditingController _pageController =
      TextEditingController(); // 페이지 입력 필드
  final TextEditingController _commentController =
      TextEditingController(); // 📝 한줄평 저장
  final ScrollController _scrollController = ScrollController(); // 스크롤 컨트롤러

  @override
  void dispose() {
    _pageController.dispose();
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _updateProgress(String value) {
    int? newValue = int.tryParse(value);
    if (newValue != null && newValue >= 0 && newValue <= widget.bookPage!) {
      setState(() {
        _progress = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final vm = ref.read(recordViewModelProvider.notifier);

    return ListView(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                '멈춘 페이지도 하나의 기록',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'JUA',
                  color:
                      !isDarkMode ? const Color(0xFF4D77B2) : Colors.grey[350],
                ),
              ),
              Text(
                '이유를 남겨두면 돌아올 때 도움이 될 거예요',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),

        // ⭐ 별점 입력
        InteractiveStarRating(
          type: 1,
          size: 25,
          onRatingChanged: (newRating) {
            setState(() {
              _rating = newRating;
            });
          },
        ),

        const SizedBox(height: 20),

        // 📌 멈춘 페이지 입력
        Row(
          children: [
            Flexible(
              flex: 1,
              child: TextField(
                controller: _pageController,
                keyboardType: TextInputType.number, // ✅ 숫자 입력 전용
                decoration: InputDecoration(
                  hintText: '00',
                  hintStyle: Theme.of(context).textTheme.labelMedium,
                ),
                onChanged: _updateProgress, // ✅ 페이지 변경 시 상태 업데이트
              ),
            ),
            const SizedBox(width: 8),
            Flexible(flex: 9, child: Text('페이지에서 쉬고 있어요')),
          ],
        ),

        const SizedBox(height: 20),

        Text('독서기간', style: Theme.of(context).textTheme.titleMedium),
        ReadPeriod(
          startDate: _startDate,
          endDate: _endDate,
          recordState: 0,
          isDarkMode: isDarkMode,
          onDateChanged: (start, end) {
            setState(() {
              _startDate = start;
              _endDate = end;
            });
          },
        ),

        const SizedBox(height: 15),

        // 📌 한줄평 입력
        Text('한줄평', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(
          height: 50,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: !isDarkMode ? Colors.grey[100] : Colors.grey[900],
            ),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: '이번 여정은 어떠셨나요?',
                hintStyle: Theme.of(context).textTheme.labelMedium,
                border: InputBorder.none,
              ),
              maxLines: null,
            ),
          ),
        ),

        const SizedBox(height: 15),

        // 📌 저장 버튼
        customElevatedButton(
          isDarkMode: isDarkMode,
          text: '저장',
          onPressed: () {
            vm.createRecord(
              bookId: widget.bookId!,
              stateType: 4, // ✅ "읽다가 멈춘 책" 상태
              startDate: _startDate,
              endDate: _endDate,
              progress: _progress, // ✅ 멈춘 페이지
              rating: _rating, // ✅ 별점
              comment: _commentController.text, // ✅ 한줄평
            );
          },
        ),
      ],
    );
  }
}
