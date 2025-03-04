import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shelfy_team_project/_core/utils/size.dart';
import 'package:shelfy_team_project/data/model/record_model/record_response_model.dart';
import '../../book_detail_page/wish_detail_page.dart';
import '../../../../widgets/custom_star_rating.dart';

class ShelfBookItemWish extends StatelessWidget {
  final RecordResponseModel wish;

  const ShelfBookItemWish({required this.wish, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WishDetailPage(book: wish)),
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
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Image.network(
                    height: 105,
                    wish.bookImage!,
                  ),
                ),
              ),
              const SizedBox(width: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 6),
                  SizedBox(
                    width: getDrawerWidth(context),
                    child: Text(
                      wish.bookTitle!,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text('${wish.bookAuthor} · ',
                          style: Theme.of(context).textTheme.labelMedium),
                      Text('${wish.bookPublisher}',
                          style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 270,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customStarRating(wish.rating!, 2, 18),
                        Visibility(
                          visible:
                              wish.comment != null && !wish.comment!.isEmpty,
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
                        '${DateFormat('yyyy-MM-dd').format(wish.startDate!)}',
                        style: Theme.of(context).textTheme.labelMedium),
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
