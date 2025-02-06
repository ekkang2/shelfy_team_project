import 'package:flutter/material.dart';
import 'package:shelfy_team_project/data/model/book_model/book.dart';
import 'package:shelfy_team_project/ui/pages/search/search_page/widget/book_detail.dart';

class BookItem extends StatelessWidget {
  final Book book;
  const BookItem({super.key, required this.book}); // book 매개변수 추가

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 컨테이너 클릭 시 상세 페이지로 이동
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => BookDetail(book: book),
        //   ),
        // );
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
                        book.bookImage!, // null 체크 필요
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 3),
                    Text(
                      book.bookTitle!,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1, // 한 줄로 제한
                      overflow: TextOverflow.ellipsis, // 넘칠 경우 "..." 표시
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            '${book.bookAuthor!}',
                            style: Theme.of(context).textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis, // 말줄임표(...) 적용
                            softWrap: false,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            '${book.bookPublishedAt!}',
                            style: Theme.of(context).textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Text(
                      softWrap: true,
                      '${book.bookDesc!}',
                      style: Theme.of(context).textTheme.labelSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Flexible(
              //   flex: 1,
              //   child: IconButton(
              //     onPressed: () {},
              //     icon: Icon(
              //       Icons.bookmark_add_outlined,
              //       color: Colors.grey,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
