import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shelfy_team_project/components/custom_star_rating.dart';
import 'package:shelfy_team_project/data/gvm/wish_view_model.dart';
import 'package:shelfy_team_project/data/model/book_record_wish.dart';
import 'package:shelfy_team_project/theme.dart';

class ShelfBookItemWish extends StatelessWidget {
  final BookRecordWish book;
  final WishViewModel noti;

  const ShelfBookItemWish({required this.book, required this.noti, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            const SizedBox(width: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 6),
                Text(
                  book.book.book_title,
                  style: textTheme().titleLarge,
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text('${book.book.book_author} · ',
                        style: textTheme().labelMedium),
                    Text('${book.book.book_publisher}',
                        style: textTheme().labelMedium),
                  ],
                ),
                const SizedBox(height: 10),
                customStarRating(book.rating, 2, 18),
                Container(
                  width: 270,
                  alignment: Alignment.bottomRight,
                  child: Text('${noti.formatSingleDate(book.startDate)}',
                      style: textTheme().labelMedium),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
