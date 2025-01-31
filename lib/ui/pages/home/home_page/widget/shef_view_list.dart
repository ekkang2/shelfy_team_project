import 'package:flutter/material.dart';
import 'package:shelfy_team_project/data/model/book_record_done.dart';

import '../../../../../data/model/book.dart';
import '../../../../widgets/custom_star_rating.dart';

class ShefViewList extends StatefulWidget {
  final BookRecordDone book;

  const ShefViewList({required this.book, super.key});

  @override
  State<ShefViewList> createState() => _ShefViewListState();
}

class _ShefViewListState extends State<ShefViewList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              customStarRating(widget.book.rating, 1, 15),
              SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(3.0),
                child: Align(
                  widthFactor: 0.97,
                  heightFactor: 0.97,
                  child: Image.network(
                    width: 90,
                    widget.book.book.book_image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
