import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shelfy_team_project/data/model/record_model/record_response_model.dart';
import 'shef_view_list.dart';

class ShelfView extends StatefulWidget {
  final String selectedYear;
  final String selectedMonth;
  final List<RecordResponseModel> done;

  const ShelfView({
    required this.done,
    super.key,
    required this.selectedYear,
    required this.selectedMonth,
  });

  @override
  State<ShelfView> createState() => _ShelfViewState();
}

class _ShelfViewState extends State<ShelfView> {
  @override
  Widget build(BuildContext context) {
    // 종료일 기준으로 데이터 필터링
    final filteredBooks = widget.done.where((record) {
      final endDate = record.endDate;
      if (endDate == null) return false;

      final yearMatch = endDate.year.toString() == widget.selectedYear;
      final monthMatch = widget.selectedMonth == '전체보기' ||
          endDate.month.toString().padLeft(2, '0') == widget.selectedMonth;

      return yearMatch && monthMatch;
    }).toList();

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        // 배경 이미지
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Shelfy_appSize3.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // 블러 효과
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 20.0),
          child: Container(
            color: isDarkMode
                ? Colors.black.withOpacity(0.4)
                : Colors.black.withOpacity(0.0),
          ),
        ),
        // 책 리스트 또는 기록 없음 표시
        filteredBooks.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    (filteredBooks.length / 3).ceil(),
                    (index) {
                      final startIndex = index * 3;
                      final endIndex = startIndex + 3;
                      final items = filteredBooks.sublist(
                        startIndex,
                        endIndex > filteredBooks.length
                            ? filteredBooks.length
                            : endIndex,
                      );

                      final isLastRow = items.length < 3;

                      List<Widget> bookWidgets = items.map((record) {
                        return Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: ShefViewList(book: record),
                          ),
                        );
                      }).toList();

                      if (isLastRow && items.length == 2) {
                        bookWidgets.add(const Expanded(child: SizedBox()));
                      } else if (isLastRow && items.length == 1) {
                        bookWidgets.addAll([
                          const Expanded(child: SizedBox()),
                          const Expanded(child: SizedBox())
                        ]);
                      }

                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: bookWidgets,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 11.0, right: 11.0),
                            child: Container(
                              margin: const EdgeInsets.only(top: 10.0),
                              height: 8.0,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/Wood.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black45,
                                    spreadRadius: 1.0,
                                    blurRadius: 4.0,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      );
                    },
                  ),
                ),
              )
            : Center(
                child: Text(
                  '기록이 없어요!',
                  style: TextStyle(
                      color: !isDarkMode ? Colors.white : Colors.grey[300],
                      fontSize: 16),
                ),
              ),
      ],
    );
  }
}
