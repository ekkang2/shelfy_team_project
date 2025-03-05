import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shelfy_team_project/_core/utils/size.dart';
import 'package:shelfy_team_project/data/model/record_model/record_response_model.dart';
import 'package:shelfy_team_project/ui/widgets/custom_appbar.dart';
import 'package:shelfy_team_project/ui/pages/books/widget/book_detail_progress_bar.dart';
import 'package:shelfy_team_project/ui/widgets/modal_bottom_sheet/edit_book_record_state.dart';

import '../../../widgets/custom_record_label.dart';
import '../../../widgets/custom_star_rating.dart';
import '../../../widgets/modal_bottom_sheet/book_record_state.dart';
import '../widget/read_period.dart';

class DoingDetailPage extends StatefulWidget {
  final RecordResponseModel book;

  const DoingDetailPage({required this.book, super.key});

  @override
  _DoingDetailPageState createState() => _DoingDetailPageState();
}

class _DoingDetailPageState extends State<DoingDetailPage> {
  late DateTime startDate;

  @override
  void initState() {
    super.initState();
    startDate = widget.book.startDate!;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: BooksDetailAppBar(context, widget.book, 0),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(3),
                  bottomRight: Radius.circular(10),
                ),
                child: !widget.book.isMyBook!
                    ? Image.network(
                        height: 180,
                        fit: BoxFit.fill,
                        widget.book.bookImage!,
                      )
                    : Image.asset(
                        'assets/images/${widget.book.bookImage}',
                        fit: BoxFit.fill,
                        height: 180,
                      ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '${widget.book.bookTitle}',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${widget.book.bookAuthor} · ${widget.book.bookPublisher}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 10),
            customRecordLabel(2, isDarkMode),
            const SizedBox(height: 20),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            // ListView를 스크롤 가능하도록 수정
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  const SizedBox(height: 4),
                  AdjustableProgressBar(
                    iconVisible: true,
                    totalPage: widget.book.bookPage!,
                    currentPage: widget.book.progress,
                    onProgressChanged: (int) {},
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ReadPeriod(
                      startDate: widget.book.startDate,
                      isDarkMode: isDarkMode,
                      recordState: 2,
                      onDateChanged: (startDate, endDate) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('예상 별점'),
                  const SizedBox(width: 10),
                  customStarRating(3.5, 2, 18),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, //  키보드가 올라오면 높이 조정 가능
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) {
                      return StatefulBuilder(
                        //  모달 내부 상태 업데이트를 위해 추가
                        builder: (context, setState) {
                          double keyboardHeight = MediaQuery.of(context)
                              .viewInsets
                              .bottom; // 키보드 높이 감지

                          return AnimatedPadding(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                            padding: EdgeInsets.only(bottom: keyboardHeight),
                            //  키보드 크기만큼 모달을 위로 이동
                            child: FractionallySizedBox(
                              heightFactor: 0.51, //  기본 모달 높이 (화면의 90%)
                              child: Container(
                                child: EditBookRecordState(
                                  record: widget.book,
                                  index: 0,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Text(
                  '여정이 끝났어요!',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      !isDarkMode ? const Color(0xFF4D77B2) : Colors.grey[800]),
                  fixedSize:
                      WidgetStatePropertyAll(Size(getScreenWidth(context), 50)),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int dateCalculation(DateTime startDate) {
    int period = DateTime.now().difference(startDate).inDays;
    return period;
  }
}
