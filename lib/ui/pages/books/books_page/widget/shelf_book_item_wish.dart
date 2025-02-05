import 'package:flutter/material.dart';
import 'package:shelfy_team_project/data/gvm/wish_view_model.dart';
import 'package:shelfy_team_project/data/model/book_record_wish.dart';

import '../../../../widgets/custom_star_rating.dart';
import '../../book_detail_page/wish_detail_page.dart';

class ShelfBookItemWish extends StatelessWidget {
  final BookRecordWish book;
  final WishViewModel noti;

  const ShelfBookItemWish({required this.book, required this.noti, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WishDetailPage(wish: book)),
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
              const SizedBox(width: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 6),
                  Text(
                    book.book.book_title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text('${book.book.book_author} · ',
                          style: Theme.of(context).textTheme.labelMedium),
                      Text('${book.book.book_publisher}',
                          style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                  const SizedBox(height: 10),
                  customStarRating(book.rating, 2, 18),
                  Container(
                    width: 270,
                    alignment: Alignment.bottomRight,
                    child: Text('${noti.formatSingleDate(book.startDate)}',
                        style: Theme.of(context).textTheme.labelMedium),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
