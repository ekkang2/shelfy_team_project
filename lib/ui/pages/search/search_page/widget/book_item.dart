import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/data/gvm/book_view_model/book_detail_view_model.dart';
import 'package:shelfy_team_project/data/model/book_model/book.dart';
import 'package:shelfy_team_project/ui/pages/search/search_page/widget/book_detail.dart';

class BookItem extends ConsumerWidget {
  final Book book;
  const BookItem({super.key, required this.book}); // book 매개변수 추가

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            print("selectBookDetail 실행 전: ${book.bookIsbn}");
            final bookDetailVM = ref.read(bookDetailProvider.notifier);
            // 상세보기 진입 후 해당 책의 isbn으로 page 수 update를 위한 뷰 모델
            await bookDetailVM.selectBookDetail(book.bookIsbn!);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetail(book: book),
              ),
            );
          },
          child: Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.2), // 그림자 색상 및 투명도
                            blurRadius: 6, // 그림자의 흐림 정도
                            offset: Offset(0, 4), // 그림자의 위치 (x, y 축 이동)
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: SizedBox(
                          width: 100, // 원하는 너비 지정
                          height: 120, // 원하는 높이 지정
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image.network(
                              book.bookImage!, // null 체크 필요
                            ),
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
                          '${book.bookDesc}',
                          style: Theme.of(context).textTheme.labelSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
