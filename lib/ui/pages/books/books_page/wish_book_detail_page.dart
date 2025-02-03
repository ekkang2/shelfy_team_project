import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelfy_team_project/ui/widgets/custom_appbar.dart';

import '../../../../_core/constants/theme.dart';
import '../../../../data/model/book_record_wish.dart';
import '../../../widgets/custom_record_label.dart';
import '../../../widgets/custom_star_rating.dart';

class WishBookDetailPage extends StatefulWidget {
  final BookRecordWish book;

  const WishBookDetailPage({required this.book, super.key});

  @override
  _WishBookDetailPageState createState() => _WishBookDetailPageState();
}

class _WishBookDetailPageState extends State<WishBookDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  // 날짜 포맷 함수
  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BooksAppBar(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(3),
                  bottomRight: Radius.circular(10),
                ),
                child: Image.network(
                  '${widget.book.book.book_image}',
                  fit: BoxFit.fill,
                  width: 150,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
                width: double.infinity,
                child: customStarRating(widget.book.rating, 0, 25)),
            const SizedBox(height: 10),
            Text(
              '${widget.book.book.book_title}',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 10),
            Text(
              '${widget.book.book.book_author} · ${widget.book.book.book_publisher}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 10),
            customRecordLabel(3),
            const SizedBox(height: 20),

            // ListView를 스크롤 가능하도록 수정
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    Visibility(
                      visible: widget.book.comment != null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.penClip,
                                  size: 15, color: Color(0xFF4D77B2)),
                              const SizedBox(width: 5),
                              Text('기대평'),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              '\"${widget.book.comment}\"',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          Text(
                            '${formatDate(widget.book.startDate)}', // 날짜 포맷 적용
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.penClip,
                                  size: 15, color: Color(0xFF4D77B2)),
                              const SizedBox(width: 5),
                              Text('책 정보'),
                            ],
                          ),
                          SizedBox(height: 13),
                          Text(
                            '${widget.book.book.book_page.toString()}쪽',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          SizedBox(height: 14),
                          Text(
                            widget.book.book.book_desc,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          SizedBox(height: 14),
                          Text(
                            '${widget.book.book.book_author} · ${widget.book.book.book_publisher}',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          SizedBox(height: 14),
                          Text(
                            'ISBN : ${widget.book.book.book_isbn}',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
