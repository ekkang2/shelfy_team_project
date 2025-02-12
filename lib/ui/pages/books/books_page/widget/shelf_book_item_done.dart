import 'package:flutter/material.dart';
import 'package:shelfy_team_project/data/model/book_record_done.dart';
import 'package:shelfy_team_project/data/model/record_model/record_response_model.dart';
import 'package:shelfy_team_project/ui/pages/books/book_detail_page/done_detail_page.dart';

import '../../../../widgets/custom_star_rating.dart';

class ShelfBookItemDone extends StatelessWidget {
  final RecordResponseModel done;

  const ShelfBookItemDone({required this.done, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => DoneDetailPage(book: done.bookId)),
        // );
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
                      done.bookImage!,
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
                    done.bookTitle!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text('${done.bookAuthor} · ',
                          style: Theme.of(context).textTheme.labelMedium),
                      Text('${done.bookPublisher}',
                          style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 270,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customStarRating(done.rating!, 1, 18),
                        Visibility(
                          visible: done.comment != null,
                          child: Icon(
                            Icons.comment,
                            size: 18,
                            color: Colors.grey[350],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 270,
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '${done.startDate} ~'
                      ' ${done.endDate}',
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
