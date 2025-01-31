import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shelfy_team_project/data/model/book_record_done.dart';
import 'shef_view_list.dart';

class ShelfView extends StatefulWidget {
  final String selectedYear;
  final String selectedMonth;

  const ShelfView(
      {super.key, required this.selectedYear, required this.selectedMonth});

  @override
  State<ShelfView> createState() => _ShelfViewState();
}

class _ShelfViewState extends State<ShelfView> {
  @override
  Widget build(BuildContext context) {
    // 종료일 기준으로 데이터 필터링
    final filteredBooks = doneBookList.where((record) {
      final endDate = record.endDate;
      final yearMatch = endDate.year.toString() == widget.selectedYear;
      final monthMatch = widget.selectedMonth == '전체보기' ||
          endDate.month.toString().padLeft(2, '0') == widget.selectedMonth;

      return yearMatch && monthMatch;
    }).toList();

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
          itemCount: (filteredBooks.length / 3).ceil(), // 필터링된 데이터를 기준으로 묶음 계산
          itemBuilder: (context, index) {
            // 3개씩 묶어서 한 줄에 표시
            final startIndex = index * 3;
            final endIndex = startIndex + 3;
            // sublist는 start index를 포함하고 end를 포함하지 않는 범위 요소들의 리스트를 리턴
            final items = filteredBooks.sublist(
              startIndex,
              endIndex > filteredBooks.length ? filteredBooks.length : endIndex,
            );
            return Column(
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: items
                        .map((record) => Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ShefViewList(book: record),
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
