import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/data/model/book_record_done.dart';
import 'package:shelfy_team_project/theme.dart';

import '../../../data/model/book_record_doing.dart';

class ShelfBookItem extends StatelessWidget {
  final Widget widget;
  final BookRecordDoing doing;

  const ShelfBookItem({required this.doing, required this.widget, super.key});

  List<String> dataTypeResult({doing, done}) {
    List<String> result = [];
    if (doing != null) {
      result.add(doing.book.book_image);
      result.add(doing.book.book_title);
    } else if (done != null) {
      result.add(done.book.book_image);
      result.add(done.book.book_title);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // dataTypeResult(doing: doing, done: done);
    //
    // if (doing != null) {
    //   result.add(doing.book.book_image);
    //   result.add(doing.book.book_title);
    // } else if (done != null) {
    //   result.add(done.book.book_image);
    //   result.add(done.book.book_title);
    // }
    //

    return Container(
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
                    doing.book.book_image,
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
                  doing.book.book_title,
                  style: textTheme().titleLarge,
                ),
                SizedBox(height: 4),
                widget,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
