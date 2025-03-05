import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelfy_team_project/data/gvm/record_view_model/record_view_model.dart';
import 'package:shelfy_team_project/data/model/record_model/record_response_model.dart';
import 'package:shelfy_team_project/ui/pages/books/widget/read_period.dart';
import 'package:shelfy_team_project/ui/widgets/custom_appbar.dart';
import 'package:shelfy_team_project/ui/widgets/custom_star_rating.dart';
import '../../../widgets/custom_record_label.dart';
import '../../../widgets/delete_button.dart';

class StopDetailPage extends ConsumerStatefulWidget {
  final RecordResponseModel book;

  const StopDetailPage({required this.book, super.key});

  @override
  ConsumerState<StopDetailPage> createState() => _StopDetailPageState();
}

class _StopDetailPageState extends ConsumerState<StopDetailPage> {
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();
    startDate = widget.book.startDate ?? DateTime.now(); // 초기 시작일 설정
    endDate = widget.book.endDate ?? DateTime.now(); // 초기 종료일 설정 (null이면 오늘 날짜)
  }

  @override
  Widget build(BuildContext context) {
    RecordViewModel vm = ref.watch(recordViewModelProvider.notifier);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        appBar: BooksDetailAppBar(context, widget.book, 1),
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
            Container(
                width: double.infinity,
                child: customStarRating(widget.book.rating!, 1, 25)),
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
            customRecordLabel(4, isDarkMode),
            const SizedBox(height: 20),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            // ListView를 스크롤 가능하도록 수정
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.bookmark_fill,
                          color: !isDarkMode
                              ? const Color(0xFF4D77B2)
                              : Colors.grey[500],
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text('${widget.book.bookPage} 페이지에서 쉬고 있어요'),
                      ],
                    ),
                    const SizedBox(height: 25),
                    ReadPeriod(
                      recordState: 4,
                      isDarkMode: isDarkMode,
                      onDateChanged: (startDate, endDate) {},
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: widget.book.comment != null,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.penClip,
                                  size: 15,
                                  color: !isDarkMode
                                      ? const Color(0xFF4D77B2)
                                      : Colors.grey[500]),
                              const SizedBox(width: 5),
                              Text('나의 한 줄'),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: !isDarkMode
                                  ? Colors.grey[100]
                                  : Colors.grey[800],
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              '\"${widget.book.comment}\"',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: deleteButton(
            context,
            () => vm.deleteRecord(stateId: widget.book.stateId!),
          ),
        ),
      ),
    );
  }

  int dateCalculation(DateTime startDate, DateTime endDate) {
    int period = endDate.difference(startDate).inDays;
    return period;
  }

  // 날짜 포맷 함수
  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Widget readPeriod() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}
