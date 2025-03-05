import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/ui/widgets/custom_elevated_button.dart';

import '../../../data/gvm/record_view_model/record_view_model.dart';
import '../../pages/books/widget/read_period.dart';
import '../custom_interactive_star_rating.dart';

class DoneRecordStateTab extends ConsumerStatefulWidget {
  final String bookId;
  DateTime? startDate;
  DateTime? endDate;
  double? rating;
  String? comment;

  DoneRecordStateTab({
    required this.bookId,
    this.startDate,
    this.endDate,
    this.rating,
    this.comment,
    super.key,
  });

  @override
  _DoneRecordStateTabState createState() => _DoneRecordStateTabState();
}

class _DoneRecordStateTabState extends ConsumerState<DoneRecordStateTab> {
  double _rating = 0.0; //  별점 상태 저장
  DateTime _startDate = DateTime.now(); // 시작일 저장
  DateTime? _endDate = DateTime.now(); //  종료일 저장
  TextEditingController _commentController = TextEditingController(); //  한줄평 저장

  @override
  void initState() {
    _startDate = widget.startDate ?? DateTime.now();
    _endDate = widget.endDate ?? DateTime.now();
    _rating = widget.rating ?? 0.0;
    if (widget.comment != null) {
      _commentController.text = widget.comment!;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final vm = ref.read(recordViewModelProvider.notifier);

    return Column(
      children: [
        // 스크롤 가능한 영역
        Expanded(
          child: ListView(
            children: [
              const SizedBox(height: 10),
              Center(
                child: Column(
                  children: [
                    Text(
                      '여정을 완료하셨네요!',
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
                      '남은 여운을 별점으로 기록해 볼까요?',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              //  별점
              InteractiveStarRating(
                type: 1,
                size: 25,
                rating: widget.rating,
                onRatingChanged: (newRating) {
                  setState(() {
                    _rating = newRating;
                  });
                },
              ),
              const SizedBox(height: 15),

              //  독서기간
              Text('독서기간', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
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
              const SizedBox(height: 10),

              //  한줄평
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '한줄평',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _commentController,
                    builder: (context, value, child) {
                      return Text(
                        '(${value.text.length}/100)',
                        style: Theme.of(context).textTheme.labelMedium,
                      );
                    },
                  ),
                ],
              ),
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
                  maxLines: null,
                  maxLength: 100,
                  decoration: InputDecoration(
                    hintText: '이번 여정은 어떠셨나요?',
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    border: InputBorder.none,
                    counterText: '', // 기본 카운터 숨김
                  ),
                ),
              ),
            ],
          ),
        ),

        //  하단 고정 저장 버튼
        SizedBox(
          width: double.infinity,
          child: customElevatedButton(
            isDarkMode: isDarkMode,
            text: '저장',
            onPressed: () {
              vm.createRecord(
                bookId: widget.bookId,
                stateType: 1,
                startDate: _startDate,
                endDate: _endDate,
                comment: _commentController.text,
                rating: _rating,
              );
            },
          ),
        ),
      ],
    );
  }
}
