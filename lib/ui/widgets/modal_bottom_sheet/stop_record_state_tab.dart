import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/data/gvm/record_view_model/record_view_model.dart';
import 'package:shelfy_team_project/ui/widgets/custom_elevated_button.dart';

import '../../../data/model/book_model/book.dart';
import '../../pages/books/widget/read_period.dart';
import '../custom_interactive_star_rating.dart';

class StopRecordStateTab extends ConsumerStatefulWidget {
  String bookId;
  int bookPage;
  StopRecordStateTab({required this.bookId, required this.bookPage, super.key});

  @override
  _StopRecordStateTabState createState() => _StopRecordStateTabState();
}

class _StopRecordStateTabState extends ConsumerState<StopRecordStateTab> {
  int _progress = 0; // 멈춘 페이지 저장
  double _rating = 0.0; // 별점 저장
  DateTime _startDate = DateTime.now(); // 시작 날짜
  DateTime? _endDate; // 종료 날짜
  final TextEditingController _pageController =
      TextEditingController(); // 페이지 입력 필드
  final TextEditingController _commentController =
      TextEditingController(); // 한줄평 저장

  @override
  void dispose() {
    _pageController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _updateProgress(String value) {
    int? newValue = int.tryParse(value);
    if (newValue != null && newValue >= 0 && newValue <= widget.bookPage) {
      setState(() {
        _progress = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final vm = ref.read(recordViewModelProvider.notifier);

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              const SizedBox(height: 10),
              Center(
                child: Column(
                  children: [
                    Text(
                      '멈춘 페이지도 하나의 기록',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'JUA',
                        color: !isDarkMode
                            ? const Color(0xFF4D77B2)
                            : Colors.grey[350],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '이유를 남겨두면 돌아올 때 도움이 될 거예요',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // 별점 입력
              InteractiveStarRating(
                type: 1,
                size: 25,
                onRatingChanged: (newRating) {
                  setState(() {
                    _rating = newRating;
                  });
                },
              ),
              const SizedBox(height: 10),

              // 독서 기간
              Text('독서기간', style: Theme.of(context).textTheme.titleMedium),
              ReadPeriod(
                startDate: _startDate,
                endDate: _endDate,
                recordState: 0,
                onDateChanged: (start, end) {
                  setState(() {
                    _startDate = start;
                    _endDate = end;
                  });
                },
              ),

              // 멈춘 페이지 입력
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 1,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _pageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '00',
                        hintStyle: Theme.of(context).textTheme.labelMedium,
                      ),
                      onChanged: _updateProgress,
                    ),
                  ),
                  Flexible(flex: 9, child: Text('페이지에서 쉬고 있어요')),
                ],
              ),
              // 한줄평 입력
              Text('한줄평', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: !isDarkMode ? Colors.grey[100] : Colors.grey[900],
                ),
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: '잠시 쉬어가는 이유가 있나요?',
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),

        // 저장 버튼
        SizedBox(
          width: double.infinity,
          child: customElevatedButton(
            isDarkMode: isDarkMode,
            text: '저장',
            onPressed: () {
              vm.createRecord(
                bookId: widget.bookId,
                stateType: 4,
                startDate: _startDate,
                endDate: _endDate,
                progress: _progress,
                rating: _rating,
                comment: _commentController.text,
              );
            },
          ),
        ),
      ],
    );
  }
}
