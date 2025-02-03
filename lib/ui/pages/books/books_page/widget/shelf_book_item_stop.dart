import 'package:flutter/material.dart';
import 'package:shelfy_team_project/data/gvm/stop_view_model.dart';
import 'package:shelfy_team_project/data/model/book_record_stop.dart';

import '../../../../widgets/custom_star_rating.dart';
import '../stop_book_detail_page.dart';

class ShelfBookItemStop extends StatelessWidget {
  final BookRecordStop book;
  final StopViewModel noti;

  const ShelfBookItemStop({required this.book, required this.noti, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StopBookDetailPage(book: book)),
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
                      book.book.book_image,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.book.book_title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 4),
                  customStarRating(book.rating, 1, 18),
                  const SizedBox(height: 10),
                  book.comment != null
                      ? Container(
                          width: 270,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            '${book.comment}',
                            style: TextStyle(
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              // fontFamily: 'Book-Light',
                            ),
                          ),
                        )
                      : Container(height: 25),
                  Container(
                    width: 270,
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '${noti.formatSingleDate(book.endDate)}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
