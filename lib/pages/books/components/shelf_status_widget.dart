import 'package:flutter/material.dart';

import '../../../data/gvm/doing_view_model.dart';
import '../../../data/gvm/done_view_model.dart';
import '../../../data/model/book_record_doing.dart';
import '../../../data/model/book_record_done.dart';
import '../../../theme.dart';

Widget doingWidget(BookRecordDoing doing, DoingViewModel notifier) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text('${notifier.formatSingleDate(doing)}에 읽기 시작했어요',
              style: textTheme().labelMedium),
          // Text(
          //   '${doing.book_author}',
          //   style: textTheme().labelMedium,
          // ),
        ],
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
            width: 270,
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF6A9BE0),
              borderRadius: BorderRadius.circular(4),
            ),
            height: 5,
            width: notifier.progressPages(doing) * 2.7,
          ),
        ],
      ),
      Container(
        width: 270,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${notifier.ceilProgressPages(doing)}%',
                style: textTheme().labelSmall),
            Text('${doing.currentPage}/${doing.book.book_page} page',
                style: textTheme().labelSmall),
          ],
        ),
      ),
    ],
  );
}

Widget DoneWidget(BookRecordDone book, DoneViewModel notifier) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text('${book.book.book_author} · ', style: textTheme().labelMedium),
          Text('${book.book.book_publisher}', style: textTheme().labelMedium),
        ],
      ),
      const SizedBox(height: 16),
      Container(
          width: 270,
          alignment: Alignment.bottomRight,
          child: Text('${book.startDate} ~ ${book.endDate}')),
    ],
  );
}
