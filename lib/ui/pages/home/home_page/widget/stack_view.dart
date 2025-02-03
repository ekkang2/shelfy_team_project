import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../data/model/book.dart';
import '../../../../../data/model/book_record_done.dart';

class StackView extends StatefulWidget {
  final String selectedYear;
  final String selectedMonth;

  const StackView(
      {super.key, required this.selectedYear, required this.selectedMonth});

  @override
  State<StackView> createState() => _StackViewState();
}

class _StackViewState extends State<StackView> {
  List<double> xOffsets = []; // x축 오프셋을 저장할 리스트

  @override
  void initState() {
    super.initState();
    // 랜덤 오프셋 생성
    final Random random = Random();
    // List.generate를 이용해서 주어진 크기만큼 리스트를 생성
    xOffsets = List.generate(doneBookList.length,
        (_) => random.nextDouble() * 60 - 30); // -30px ~ 30px 랜덤한 값을 생성
  }

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

    // 전체 페이지와 cm 계산
    final totalPages = filteredBooks.fold<int>(
        0, (sum, record) => sum + record.book.book_page); // 전체 페이지 합산
    final totalCm = (totalPages * 0.2).toStringAsFixed(1); // 전체 두께(cm)
    // totalPages 값을 천 단위로 포맷팅
    String formattedTotalPages = NumberFormat("#,##0").format(totalPages);
    // totalCm 소수점 첫째자리가 0이면 소수점을 제외하고, 0이 아니면 그대로 표시
    String formattedTotalCm = totalCm.endsWith('.0')
        ? totalCm.substring(0, totalCm.length - 2)
        : totalCm;

    // 다크모드 설정
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 20.0),
          child: Container(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        // 책 정보와 목록
        Positioned.fill(
          child: Column(
            children: [
              // 맨 위에 전체 cm와 페이지 수 표시
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "$formattedTotalCm cm / $formattedTotalPages pg",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              // 스크롤 가능한 책 목록
              Expanded(
                child: SingleChildScrollView(
                  reverse: true, // 아래에서 위로 쌓이는 방향
                  padding: const EdgeInsets.only(bottom: 20), // 하단 여백
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: filteredBooks.asMap().entries.map((entry) {
                      final index = entry.key;
                      final record = entry.value;
                      final book = record.book;

                      // 책 두께 계산
                      final bookHeight = book.book_page * 0.2; // 1페이지 = 0.2cm

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Transform.translate(
                            offset: Offset(
                              xOffsets[index], // 저장된 X축 오프셋 사용
                              0, // Y축은 그대로 둠
                            ),
                            child: Container(
                              margin:
                                  const EdgeInsets.only(bottom: 2), // 책 간 간격
                              height: bookHeight,
                              width: MediaQuery.of(context).size.width *
                                  0.6, // 책 폭
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
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(4), // 둥근 모서리 적용
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // 이미지 이동 및 회전
                                    Transform.translate(
                                      offset:
                                          const Offset(-10, 10), // 이미지 위치 조정
                                      child: Transform.rotate(
                                        alignment: Alignment.center,
                                        angle: 90 *
                                            3.1415926535897932 /
                                            180, // 이미지를 90도 회전
                                        child: SizedBox.expand(
                                          child: SizedBox.expand(
                                            child: FittedBox(
                                              fit: BoxFit.cover, // 컨테이너를 완전히 채움
                                              // 단순히 투명해지는 것이 아니라 어두운 효과를 원할 때
                                              child: ColorFiltered(
                                                colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.2),
                                                    BlendMode.darken),
                                                child: Image.network(
                                                    book.book_image),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // 이미지 위에 텍스트 추가
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        book.book_title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black,
                                              blurRadius: 6,
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
