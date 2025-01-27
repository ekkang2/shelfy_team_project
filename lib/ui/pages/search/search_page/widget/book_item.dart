import 'package:flutter/material.dart';
import 'package:shelfy_team_project/ui/pages/search/search_page/widget/book_detail.dart';

import '../../../../../data/model/book.dart';
import '../../../../../theme.dart';

class BookItem extends StatefulWidget {
  final Book book;

  const BookItem({required this.book, super.key});

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 컨테이너 클릭 시 상세 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetail(book: widget.book),
          ),
        );
      },
      child: Container(
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
                        widget.book.book_image,
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
                      widget.book.book_title,
                      style: textTheme().titleLarge,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '${widget.book.book_author}',
                          style: textTheme().labelMedium,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          ' ${widget.book.book_published_at}',
                          style: textTheme().labelMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Text(
                      softWrap: true,
                      '${widget.book.book_desc}',
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
      ),
    );
  }
}
