import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shelfy_team_project/data/model/record_model/record_response_model.dart';

import '../../../books/book_detail_page/done_detail_page.dart';

class StackView extends StatefulWidget {
  final String selectedYear;
  final String selectedMonth;
  final List<RecordResponseModel> done;

  const StackView(
      {required this.done,
      super.key,
      required this.selectedYear,
      required this.selectedMonth});

  @override
  State<StackView> createState() => _StackViewState();
}

class _StackViewState extends State<StackView> {
  List<double> xOffsets = [];
  bool showPages = true; // cm ↔ pg 전환 상태

  @override
  void initState() {
    super.initState();
    final Random random = Random();
    if (widget.done.isNotEmpty) {
      xOffsets = List.generate(
          widget.done.length, (_) => random.nextDouble() * 60 - 30);
    } else {
      xOffsets = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredBooks = widget.done.where((record) {
      final endDate = record.endDate;
      if (endDate == null) return false;

      final yearMatch = endDate.year.toString() == widget.selectedYear;
      final monthMatch = widget.selectedMonth == '전체보기' ||
          endDate.month.toString().padLeft(2, '0') == widget.selectedMonth;

      return yearMatch && monthMatch;
    }).toList();

    final totalPages =
        filteredBooks.fold<int>(0, (sum, record) => sum + record.bookPage!);
    final totalCm = (totalPages * 0.01).toStringAsFixed(1);

    String formattedTotalPages = NumberFormat("#,##0").format(totalPages);
    String formattedTotalCm = totalCm.endsWith('.0')
        ? totalCm.substring(0, totalCm.length - 2)
        : totalCm;

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Shelfy_appSize3.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 20.0),
          child: Container(
            color: !isDarkMode
                ? Colors.black.withOpacity(0.0)
                : Colors.black.withOpacity(0.4),
          ),
        ),
        Positioned.fill(
          child: filteredBooks.isNotEmpty
              ? ListView(
                  children: [
                    const SizedBox(height: 5),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showPages = !showPages; // 클릭 시 상태 변경
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            showPages
                                ? "$formattedTotalCm cm 쌓았어요"
                                : "전체 $formattedTotalPages 페이지",
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Pretendard-Bold',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      reverse: true,
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: filteredBooks.asMap().entries.map((entry) {
                          final index = entry.key;
                          final record = entry.value;
                          final bookHeight = record.bookPage! * 0.2;

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 70.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Transform.translate(
                                offset: Offset(xOffsets[index], 0),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 1),
                                  height: bookHeight,
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.grey[300],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DoneDetailPage(book: record)),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Transform.translate(
                                            offset: const Offset(-10, 10),
                                            child: Transform.rotate(
                                              alignment: Alignment.center,
                                              angle:
                                                  90 * 3.1415926535897932 / 180,
                                              child: SizedBox.expand(
                                                child: FittedBox(
                                                  fit: BoxFit.cover,
                                                  child: ColorFiltered(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Colors
                                                                .black
                                                                .withOpacity(
                                                                    0.2),
                                                            BlendMode.darken),
                                                    child: record.isMyBook!
                                                        ? Image.asset(
                                                            'assets/images/${record.bookImage}')
                                                        : Image.network(
                                                            record.bookImage!),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Text(
                                              record.bookTitle!,
                                              style: TextStyle(
                                                fontFamily:
                                                    'Pretendard-SemiBold',
                                                color: Colors.white,
                                                fontSize: 14,
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black
                                                        .withOpacity(0.9),
                                                    offset: Offset(1, 1),
                                                    blurRadius: 7,
                                                  ),
                                                ],
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )),
                  ],
                )
              : Center(
                  child: Text(
                    "기록이 없어요!",
                    style: TextStyle(
                        color: !isDarkMode ? Colors.white : Colors.grey[300],
                        fontSize: 16),
                  ),
                ),
        ),
      ],
    );
  }
}
