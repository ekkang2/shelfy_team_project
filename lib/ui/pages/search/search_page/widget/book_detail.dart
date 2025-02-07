import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelfy_team_project/data/gvm/book_view_model/book_detail_view_model.dart';
import 'package:shelfy_team_project/data/gvm/book_view_model/book_view_model.dart';
import 'package:shelfy_team_project/data/model/book_model/book.dart';

import '../../../../widgets/book_record_state.dart';

class BookDetail extends ConsumerWidget {
  final Book book;

  const BookDetail({required this.book, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final book = ref.watch(bookDetailProvider);

    final List<Map<String, dynamic>> iconButtons = [
      {"title": "다 읽었어요", "icon": FontAwesomeIcons.book},
      {"title": "읽고 있어요", "icon": Icons.bookmark},
      {"title": "읽고 싶어요", "icon": CupertinoIcons.heart_fill},
      {"title": "중단했어요", "icon": FontAwesomeIcons.solidCirclePause},
    ];

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
            // actions: [
            //   TextButton(
            //     onPressed: () {
            //       showModalBottomSheet(
            //         context: context,
            //         isScrollControlled: true, // 모달 크기 조정 가능하게 설정
            //         shape: RoundedRectangleBorder(
            //           borderRadius:
            //               BorderRadius.vertical(top: Radius.circular(16)),
            //         ),
            //         builder: (context) {
            //           return Container(
            //             height: MediaQuery.of(context).size.height *
            //                 0.51, // 50% 크기로 설정
            //             child: BookRecordState(
            //               book: widget.book,
            //               index: 1,
            //             ),
            //           );
            //         },
            //       );
            //     }, // 저장 버튼 클릭 이벤트
            //     child: Text(
            //       "저장",
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontFamily: 'JUA',
            //         fontSize: 20,
            //       ),
            //     ),
            //   ),
            // ],
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
                        book.bookImage!,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        book.bookTitle!,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${book.bookAuthor!} · ${book.bookPublisher!}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(iconButtons.length, (index) {
                          final data = iconButtons[index];
                          return InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled:
                                    true, // ✅ 키보드가 올라오면 높이 조정 가능
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                ),
                                builder: (context) {
                                  return StatefulBuilder(
                                    // ✅ 모달 내부 상태 업데이트를 위해 추가
                                    builder: (context, setState) {
                                      double keyboardHeight =
                                          MediaQuery.of(context)
                                              .viewInsets
                                              .bottom; // 키보드 높이 감지

                                      return AnimatedPadding(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeOut,
                                        padding: EdgeInsets.only(
                                            bottom: keyboardHeight),
                                        // ✅ 키보드 크기만큼 모달을 위로 이동
                                        child: FractionallySizedBox(
                                          heightFactor:
                                              0.51, // ✅ 기본 모달 높이 (화면의 90%)
                                          child: Container(
                                            child: BookRecordState(
                                              book: book,
                                              index: index,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }, // 클릭 이벤트
                            child: Container(
                              width: 70,
                              height: 70,
                              alignment: Alignment.center, // 내용물 중앙 정렬
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center, // 세로 방향 중앙 정렬
                                children: [
                                  Icon(data["icon"],
                                      color: !isDarkMode
                                          ? const Color(0xFF4D77B2)
                                          : Colors.grey),
                                  const SizedBox(height: 5), // 아이콘과 텍스트 간격
                                  Text(
                                    data["title"],
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: !isDarkMode
                                            ? Colors.black54
                                            : Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                      width: double.infinity, // 최대 너비를 사용
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 책 소개가 비어있지 않은 경우에만 표시
                            if (book.bookDesc != null &&
                                book.bookDesc!.isNotEmpty) ...[
                              Text(
                                '책 소개',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(height: 13),
                              Text(
                                book.bookDesc!,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              SizedBox(height: 14),
                            ],
                            Text(
                              '지은이',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(height: 13),
                            Text(
                              book.bookAuthor!,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            SizedBox(height: 14),
                            Text(
                              '출판사',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(height: 13),
                            Text(
                              book.bookPublisher!,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            SizedBox(height: 14),
                            Text(
                              'ISBN',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(height: 13),
                            Text(
                              book.bookIsbn!,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            SizedBox(height: 14),
                            Text(
                              '페이지',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(height: 13),
                            Text(
                              book.bookPage!.toString(),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            SizedBox(height: 14),
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
