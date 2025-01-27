import 'package:flutter/material.dart';
import 'package:shelfy_team_project/theme.dart';

import '../../../../../data/model/book.dart';

class BookDetail extends StatefulWidget {
  final Book book;

  const BookDetail({required this.book, super.key});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            // 타이틀 위치
            titleSpacing: 3,
            // backgroundColor: const Color(0xFF4D77B2),
            scrolledUnderElevation: 0,
            title: Row(
              children: [
                Text(
                  '상세보기',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'JUA',
                  ),
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {}, // 저장 버튼 클릭 이벤트
                child: Text(
                  "저장",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'JUA',
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          body: ListView(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 17),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(3),
                        bottomRight: Radius.circular(10),
                      ),
                      child: Image.network(
                        height: 230,
                        widget.book.book_image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      widget.book.book_title,
                      style: textTheme().headlineLarge,
                    ),
                    SizedBox(height: 7),
                    Text(
                      '${widget.book.book_author} · ${widget.book.book_publisher}',
                      style: textTheme().labelLarge,
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: Container(
                        height: 1.0,
                        width: 500.0,
                        color: Colors.black26,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '책 소개',
                              style: textTheme().titleLarge,
                            ),
                            SizedBox(height: 13),
                            Text(
                              widget.book.book_desc,
                              style: textTheme().labelLarge,
                            ),
                            SizedBox(height: 14),
                            Text(
                              '지은이',
                              style: textTheme().titleLarge,
                            ),
                            SizedBox(height: 13),
                            Text(
                              widget.book.book_publisher,
                              style: textTheme().labelLarge,
                            ),
                            SizedBox(height: 14),
                            Text(
                              '출판사',
                              style: textTheme().titleLarge,
                            ),
                            SizedBox(height: 13),
                            Text(
                              widget.book.book_publisher,
                              style: textTheme().labelLarge,
                            ),
                            SizedBox(height: 14),
                            Text(
                              'ISBN',
                              style: textTheme().titleLarge,
                            ),
                            SizedBox(height: 13),
                            Text(
                              widget.book.book_isbn,
                              style: textTheme().labelLarge,
                            ),
                            SizedBox(height: 14),
                            Text(
                              '페이지',
                              style: textTheme().titleLarge,
                            ),
                            SizedBox(height: 13),
                            Text(
                              widget.book.book_page.toString(),
                              style: textTheme().labelLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
