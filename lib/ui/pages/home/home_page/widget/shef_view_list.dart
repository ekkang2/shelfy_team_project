import 'package:flutter/material.dart';

import '../../../../../data/model/book.dart';

class ShefViewList extends StatefulWidget {
  final Book book;

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
            borderRadius: BorderRadius.circular(3.0),
            child: Align(
              widthFactor: 0.97,
              heightFactor: 0.97,
              child: Image.network(
                width: 90,
                widget.book.book_image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
