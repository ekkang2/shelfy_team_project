import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelfy_team_project/components/custom_appbar.dart';
import 'package:shelfy_team_project/components/custom_interactive_star_rating.dart';
import 'package:shelfy_team_project/components/custom_record_label.dart';
import 'package:shelfy_team_project/components/custom_star_rating.dart';
import 'package:shelfy_team_project/data/model/book_record_doing.dart';
import 'package:shelfy_team_project/pages/books/components/book_detail_progress_bar.dart';
import 'package:shelfy_team_project/theme.dart';

class BookDetailPage extends StatefulWidget {
  final BookRecordDoing book;
  const BookDetailPage({required this.book, super.key});

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late DateTime startDate;

  @override
  void initState() {
    super.initState();
    startDate = widget.book.startDate;
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
            InteractiveStarRating(type: 1, size: 25, onRatingChanged: (newRating){}),
            const SizedBox(height: 15),
            Text(
              '${widget.book.book.book_title}',
              style: textTheme().headlineLarge,
            ),
            const SizedBox(height: 10),
            Text(
              '${widget.book.book.book_author} · ${widget.book.book.book_publisher}',
              style: textTheme().labelLarge,
            ),
            const SizedBox(height: 10),
            customRecordLabel(2),
            const SizedBox(height: 20),

            // ListView를 스크롤 가능하도록 수정
            Expanded(
              child: ListView(
                children: [
                  AdjustableProgressBar(bookRecord: widget.book),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: readPeriod(),
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        print('여정 종료: 시작일 $startDate');
                      },
                      child: Text(
                        '여정이 끝났어요!',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF4D77B2)),
                        fixedSize: MaterialStatePropertyAll(Size(300, 50)),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
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
              Text('${dateCalculation(startDate)}일 동안 읽었어요.'),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(3)),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
                        '${widget.book.formatSingleDate(startDate)}',
                        style: textTheme().bodyLarge,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('종료일'),
                    Text('-'),
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
