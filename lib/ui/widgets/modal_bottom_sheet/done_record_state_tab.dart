import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/ui/widgets/custom_elevated_button.dart';

import '../../../data/gvm/record_view_model/record_view_model.dart';
import '../../../data/model/book_model/book.dart';
import '../../pages/books/widget/read_period.dart';
import '../custom_interactive_star_rating.dart';

class DoneRecordStateTab extends ConsumerStatefulWidget {
  final Book book;
  const DoneRecordStateTab({required this.book, super.key});

  @override
  _DoneRecordStateTabState createState() => _DoneRecordStateTabState();
}

class _DoneRecordStateTabState extends ConsumerState<DoneRecordStateTab> {
  double _rating = 0.0; // ⭐ 별점 상태 저장
  DateTime _startDate = DateTime.now(); // 📆 시작일 저장
  DateTime? _endDate; // 📆 종료일 저장
  TextEditingController _commentController =
      TextEditingController(); // 📝 한줄평 저장

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
                '여정을 완료하셨네요!',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'JUA',
                    color: !isDarkMode
                        ? const Color(0xFF4D77B2)
                        : Colors.grey[350]),
              ),
              Text(
                '남은 여운을 별점으로 기록해 볼까요?',
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
        ),
        const SizedBox(height: 15),

        // ⭐ 별점 입력 (별점이 변경되면 상태 업데이트)
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
        Text(
          '독서기간',
          style: Theme.of(context).textTheme.titleMedium,
        ),

        // 📆 독서 기간 선택
        ReadPeriod(
          startDate: _startDate,
          endDate: _endDate,
          isDarkMode: isDarkMode,
          onDateChanged: (start, end) {
            setState(() {
              _startDate = start;
              _endDate = end;
            });
          },
        ),

        const SizedBox(height: 15),
        Text(
          '한줄평',
          style: Theme.of(context).textTheme.titleMedium,
        ),

        SizedBox(
          height: 50,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: !isDarkMode ? Colors.grey[100] : Colors.grey[900],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: '이번 여정은 어떠셨나요?',
                hintStyle: Theme.of(context).textTheme.labelMedium,
                border: InputBorder.none,
              ),
              maxLines: null,
              controller: _commentController,
            ),
          ),
        ),

        const SizedBox(height: 10),

        // 📌 저장 버튼
        customElevatedButton(
            isDarkMode: isDarkMode,
            text: '저장',
            onPressed: () {
              vm.createRecord(
                bookId: widget.book.bookId!,
                stateType: 1,
                startDate: _startDate,
                endDate: _endDate,
                comment: _commentController.text,
                rating: _rating,
              );
            }),
      ],
    );
  }
}
