import 'package:flutter/material.dart';
import 'package:shelfy_team_project/ui/pages/books/book_detail_page/doing_detail_page.dart';

import '../../../../../data/model/book_record_doing.dart';
/*
 TODO
 프로그래스 바 애니메이션 효과
 */

class ShelfBookItemDoing extends StatelessWidget {
  final BookRecordDoing doing;

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
          // child: Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Container(
          //         decoration: BoxDecoration(
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.black.withOpacity(0.2), // 그림자 색상 및 투명도
          //               blurRadius: 6, // 그림자의 흐림 정도
          //               offset: Offset(2, 4), // 그림자의 위치 (x, y 축 이동)
          //             ),
          //           ],
          //         ),
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.circular(3),
          //           child: Align(
          //             widthFactor: 0.97,
          //             heightFactor: 0.97,
          //             child: Image.network(
          //               height: 105,
          //               doing.book.book_image,
          //             ),
          //           ),
          //         ),
          //       ),
          //       const SizedBox(width: 25),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           const SizedBox(height: 6),
          //           Text(
          //             doing.book.book_title,
          //             style: Theme.of(context).textTheme.titleLarge,
          //           ),
          //           SizedBox(height: 4),
          //           Row(
          //             children: [
          //               Text(
          //                   '${doing.formatSingleDateByKor(doing.startDate)}에 읽기 시작했어요',
          //                   style: Theme.of(context).textTheme.labelMedium),
          //             ],
          //           ),
          //           const SizedBox(height: 16),
          //           Stack(
          //             children: [
          //               Container(
          //                 decoration: BoxDecoration(
          //                   color: Colors.grey[300],
          //                   borderRadius: BorderRadius.circular(4),
          //                 ),
          //                 height: 5,
          //                 width: 270,
          //               ),
          //               Container(
          //                 decoration: BoxDecoration(
          //                   color: Color(0xFF6A9BE0),
          //                   borderRadius: BorderRadius.circular(4),
          //                 ),
          //                 height: 5,
          //                 width: doing.progressPages() * 2.7,
          //               ),
          //             ],
          //           ),
          //           Container(
          //             width: 270,
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text('${doing.ceilProgressPages()}%',
          //                     style: Theme.of(context).textTheme.labelSmall),
          //                 Text(
          //                     '${doing.currentPage}/${doing.book.book_page} page',
          //                     style: Theme.of(context).textTheme.labelSmall),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}
