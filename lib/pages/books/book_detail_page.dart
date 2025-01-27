import 'package:flutter/material.dart';
import 'package:shelfy_team_project/components/custom_appbar.dart';
import 'package:shelfy_team_project/components/custom_record_label.dart';
import 'package:shelfy_team_project/data/model/book_record_doing.dart';
import 'package:shelfy_team_project/pages/books/components/book_detail_progress_bar.dart';
import 'package:shelfy_team_project/theme.dart';

class BookDetailPage extends StatelessWidget {
  final BookRecordDoing book;
  const BookDetailPage({required this.book, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BooksAppBar(context),
        body: Container(
          width: double.infinity,
          child: Column(
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
                    '${book.book.book_image}',
                    fit: BoxFit.fill,
                    width: 150,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${book.book.book_title}',
                style: textTheme().headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                '${book.book.book_author} · ${book.book.book_publisher}',
                style: textTheme().labelLarge,
              ),
              const SizedBox(height: 10),
              customRecordLabel(2),
              const SizedBox(height: 20),
              AdjustableProgressBar(bookRecord: book),
              Text('${dateCalculation(book.startDate)}일째 읽고 있어요!'),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  '여정이 끝났어요!',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF4D77B2)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)))),
              )
            ],
          ),
        ),
      ),
    );
  }

  int dateCalculation(DateTime startDate) {
    int period =
        int.parse(DateTime.now().difference(startDate).inDays.toString());
    return period;
  }
}
