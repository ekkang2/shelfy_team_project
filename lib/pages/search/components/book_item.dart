import 'package:flutter/material.dart';

import '../../../models/book.dart';
import '../../../theme.dart';

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem({required this.book, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: Container(
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
                      book.book_image,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3),
                  Text(
                    book.book_title,
                    style: textTheme().titleLarge,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        '${book.book_author}',
                        style: textTheme().labelMedium,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        ' ${book.book_published_at}',
                        style: textTheme().labelMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Text(
                    softWrap: true,
                    '${book.book_desc}',
                    style: textTheme().labelSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.bookmark_add_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
