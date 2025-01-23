import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shelfy_team_project/theme.dart';

import '../../../models/book_record_doing.dart';

class DoingBookItem extends StatelessWidget {
  final BookRecordDoing doing;

  const DoingBookItem({required this.doing, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
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
                      doing.book_image,
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
                    doing.book_title,
                    style: textTheme().titleLarge,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('${doing.startDate.year} 에 읽기 시작했어요',
                          style: textTheme().labelMedium),
                      // Text(
                      //   '${doing.book_author}',
                      //   style: textTheme().labelMedium,
                      // ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        height: 5,
                        width: 50,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('21%', style: textTheme().labelSmall),
                      Text('${doing.currentPage}/${doing.totalPage} page',
                          style: textTheme().labelSmall)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
