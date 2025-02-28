import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shelfy_team_project/_core/utils/size.dart';
import 'package:shelfy_team_project/data/model/record_model/record_response_model.dart';
import '../../book_detail_page/doing_detail_page.dart';

class ShelfBookItemDoing extends StatelessWidget {
  final RecordResponseModel doing;

  const ShelfBookItemDoing({required this.doing, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DoingDetailPage(book: doing)),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 100,
              alignment: Alignment.center,
              // decoration: BoxDecoration(
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.black.withOpacity(0.2),
              //       blurRadius: 6,
              //       offset: Offset(2, 4),
              //     ),
              //   ],
              // ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.network(
                  height: 105,
                  doing.bookImage!,
                ),
              ),
            ),
            const SizedBox(width: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: getDrawerWidth(context),
                  child: Text(
                    doing.bookTitle!,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${DateFormat('yyyy년 MM월 dd일').format(doing.startDate!)}에 읽기 시작했어요',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 16),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      height: 5,
                      width: getDrawerWidth(context),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF6A9BE0),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      height: 5,
                      width: doing.progress! /
                          doing.bookPage! *
                          getDrawerWidth(context),
                    ),
                  ],
                ),
                Container(
                  width: getDrawerWidth(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${(doing.progress! / doing.bookPage! * 100).toStringAsFixed(1)}%',
                          style: Theme.of(context).textTheme.labelSmall),
                      Text('${doing.progress}/${doing.bookPage} page',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
