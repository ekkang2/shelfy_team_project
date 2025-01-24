import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shelfy_team_project/data/model/book.dart';
import 'package:shelfy_team_project/pages/search/components/book_item.dart';

import 'shef_view_list.dart';

class ShelfView extends StatefulWidget {
  const ShelfView({super.key});

  @override
  State<ShelfView> createState() => _ShelfViewState();
}

class _ShelfViewState extends State<ShelfView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 배경 이미지
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Shelfy_appSize3.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // 블러 효과
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
          child: Container(
            color: Colors.black.withOpacity(0.1),
          ),
        ),

        // 내용 위젯
        ListView.builder(
          itemCount: (bookList.length / 3).ceil(), // 3개씩 묶은 줄 수 계산
          itemBuilder: (context, index) {
            // 3개씩 묶어서 한 줄에 표시
            final startIndex = index * 3;
            final endIndex = startIndex + 3;
            // sublist는 start index를 포함하고 end를 포함하지 않는 범위 요소들의 리스트를 리턴
            final items = bookList.sublist(
              startIndex,
              endIndex > bookList.length ? bookList.length : endIndex,
            );
            return Column(
              children: [
                SizedBox(height: 55),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: items
                        .map((book) => Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ShefViewList(book: book),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                // 아래에 BoxDecoration 추가
                Padding(
                  padding: const EdgeInsets.only(left: 11.0, right: 11.0),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          spreadRadius: 1.0,
                          blurRadius: 4.0,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            );
          },
        ),
      ],
    );
  }
}
