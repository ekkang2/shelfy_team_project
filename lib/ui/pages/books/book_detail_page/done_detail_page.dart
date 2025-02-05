import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelfy_team_project/ui/widgets/custom_appbar.dart';
import 'package:shelfy_team_project/ui/widgets/custom_star_rating.dart';
import 'package:shelfy_team_project/data/model/book_record_done.dart';

import '../../../widgets/custom_record_label.dart';

class DoneDetailPage extends StatefulWidget {
  final BookRecordDone book;

  const DoneDetailPage({required this.book, super.key});

  @override
  _DoneDetailPageState createState() => _DoneDetailPageState();
}

class _DoneDetailPageState extends State<DoneDetailPage> {
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();
    startDate = widget.book.startDate; // 초기 시작일 설정
    endDate = widget.book.endDate ?? DateTime.now(); // 초기 종료일 설정 (null이면 오늘 날짜)
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BooksAppBar(context),
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
                child: Image.network(
                  '${widget.book.book.book_image}',
                  fit: BoxFit.fill,
                  width: 150,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${widget.book.book.book_title}',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 10),
            Text(
              '${widget.book.book.book_author} · ${widget.book.book.book_publisher}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 10),
            customRecordLabel(1),
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
                    const SizedBox(height: 20),
                    Container(
                        width: double.infinity,
                        child: customStarRating(widget.book.rating, 1, 25)),
                    const SizedBox(height: 30),
                    readPeriod(),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: widget.book.comment != null,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.penClip,
                                  size: 15, color: const Color(0xFF4D77B2)),
                              const SizedBox(width: 5),
                              Text('나의 한 줄'),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
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
        children: [
          Row(
            children: [
              Icon(
                FontAwesomeIcons.thumbtack,
                color: Color(0xFF4D77B2),
                size: 20,
              ),
              const SizedBox(width: 4),
              Text('${dateCalculation(startDate, endDate)}일 동안 읽었어요.'),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(3),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // 시작일 선택
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('시작일'),
                    TextButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          initialDate: startDate,
                        );
                        if (pickedDate != null) {
                          setState(() {
                            startDate = pickedDate;
                          });
                        }
                      },
                      child: Text(
                        '${formatDate(startDate)}', // 날짜 포맷 적용
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
                // 종료일 선택
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('종료일'),
                    TextButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: startDate, // 종료일은 시작일 이후만 가능
                          lastDate: DateTime(2100),
                          initialDate: endDate,
                        );
                        if (pickedDate != null) {
                          setState(() {
                            endDate = pickedDate;
                          });
                        }
                      },
                      child: Text(
                        '${formatDate(endDate)}', // 날짜 포맷 적용
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
