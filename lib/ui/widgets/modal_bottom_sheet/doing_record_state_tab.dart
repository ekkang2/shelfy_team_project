import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shelfy_team_project/_core/utils/size.dart';
import 'package:shelfy_team_project/data/gvm/record_view_model/record_view_model.dart';
import 'package:shelfy_team_project/ui/widgets/custom_elevated_button.dart';

import '../../pages/books/widget/book_detail_progress_bar.dart';

class DoingRecordStateTab extends ConsumerStatefulWidget {
  String bookId;
  String bookTitle;
  int bookPage;
  int? progress;
  DateTime? startDate;

  DoingRecordStateTab({
    required this.bookId,
    required this.bookTitle,
    required this.bookPage,
    this.progress,
    this.startDate,
    super.key,
  });

  @override
  _DoingRecordStateTabState createState() => _DoingRecordStateTabState();
}

class _DoingRecordStateTabState extends ConsumerState<DoingRecordStateTab> {
  int _progress = 0; //  읽은 페이지 수 저장
  final ScrollController _scrollController = ScrollController(); // 스크롤 컨트롤러

  DateTime _startDate = DateTime.now(); //  시작 날짜

  @override
  void initState() {
    _progress = widget.progress ?? 0;
    _startDate = widget.startDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final vm = ref.read(recordViewModelProvider.notifier);

    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: _scrollController,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  '${widget.bookTitle} 를 읽고 있어요',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'JUA',
                    color: !isDarkMode
                        ? const Color(0xFF4D77B2)
                        : Colors.grey[350],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '현재 페이지를 기록해 볼까요?',
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),

              // 페이지 기록 바
              AdjustableProgressBar(
                iconVisible: false,
                totalPage: widget.bookPage!,
                currentPage: _progress,
                onProgressChanged: (newProgress) {
                  if (mounted) {
                    setState(() {
                      _progress = newProgress; // 최신 페이지 수 반영
                    });
                  }
                },
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 시작 날짜 선택
                    Text(
                      '시작일',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                        color:
                            !isDarkMode ? Colors.grey[200] : Colors.grey[800],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _startDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null && pickedDate != _startDate) {
                            setState(() {
                              _startDate = pickedDate;
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.date_range,
                                color: !isDarkMode
                                    ? Colors.grey[500]
                                    : Colors.grey[300]),
                            Text(
                              '${_startDate.year}.${_startDate.month}.${_startDate.day}',
                              style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.grey[300]
                                      : Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(' 이 책을 다 읽으면'),
                        Text(
                          ' ${(widget.bookPage * 0.01).toStringAsFixed(1)} cm',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Text(' 높아져요!'),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

        // 하단 저장 버튼
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: SizedBox(
            width: double.infinity,
            child: customElevatedButton(
              isDarkMode: isDarkMode,
              text: '저장',
              onPressed: () {
                vm.createRecord(
                  bookId: widget.bookId,
                  stateType: 2,
                  startDate: _startDate,
                  progress: _progress,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
