import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shelfy_team_project/data/model/book_record_done.dart';
import 'package:shelfy_team_project/pages/books/done_book_detail_page.dart';
import 'package:shelfy_team_project/theme.dart';

class ShelfBookItemDone extends StatelessWidget {
  final Widget widget;
  final BookRecordDone done;

  const ShelfBookItemDone(
      {required this.done, required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DoneBookDetailPage(book: done)),
        );
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // 그림자 색상 및 투명도
                      blurRadius: 6, // 그림자의 흐림 정도
                      offset: Offset(2, 4), // 그림자의 위치 (x, y 축 이동)
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Align(
                    widthFactor: 0.97,
                    heightFactor: 0.97,
                    child: Image.network(
                      height: 105,
                      done.book.book_image,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 6),
                  Text(
                    done.book.book_title,
                    style: textTheme().titleLarge,
                  ),
                  SizedBox(height: 4),
                  widget,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
