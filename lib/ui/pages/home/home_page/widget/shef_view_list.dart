import 'package:flutter/material.dart';
import 'package:shelfy_team_project/data/model/record_model/record_response_model.dart';
import '../../../../widgets/custom_star_rating.dart';

class ShefViewList extends StatefulWidget {
  final RecordResponseModel book;

  const ShefViewList({required this.book, super.key});

  @override
  State<ShefViewList> createState() => _ShefViewListState();
}

class _ShefViewListState extends State<ShefViewList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            customStarRating(widget.book.rating!, 1, 15),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3), // 그림자 색상
                    spreadRadius: 1, // 그림자 확산 범위
                    blurRadius: 8, // 흐림 정도
                    offset: const Offset(2, 4), // 그림자 위치 (x, y)
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3.0),
                child: !widget.book.isMyBook!
                    ? Image.network(
                        widget.book.bookImage!,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/${widget.book.bookImage}',
                        height: 100,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
