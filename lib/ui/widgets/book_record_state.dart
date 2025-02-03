import 'package:flutter/material.dart';
import 'package:shelfy_team_project/data/model/book_record_doing.dart';
import 'package:shelfy_team_project/ui/pages/books/book_detail_page/widget/book_detail_progress_bar.dart';
import 'package:shelfy_team_project/ui/pages/books/widget/read_period.dart';

import 'custom_interactive_star_rating.dart';

class BookRecordState extends StatefulWidget {
  BookRecordDoing book;

  BookRecordState({required this.book});

  @override
  _BookRecordStateState createState() => _BookRecordStateState();
}

class _BookRecordStateState extends State<BookRecordState>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min, // 최소 크기로 설정
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300], // 비활성화 탭의 기본 배경색
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          // padding: const EdgeInsets.all(4),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: !isDarkMode ? Colors.white : Colors.black87, // 선택된 탭의 배경색
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            indicatorSize: TabBarIndicatorSize.tab, // 인디케이터 크기 조정
            // indicatorPadding:
            //     EdgeInsets.symmetric(horizontal: 8, vertical: 4), // 인디케이터 여백 설정
            labelColor: !isDarkMode
                ? const Color(0xFF4D77B2)
                : Colors.grey[400], // 선택된 탭 텍스트 색상
            unselectedLabelColor: Colors.black38, // 비활성화된 탭 텍스트 색상
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: '끝맺은 책'),
              Tab(text: '여정 중인 책'),
              Tab(text: '기다리는 책'),
              Tab(text: '잠든 책'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildDoneState(isDarkMode),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(children: [
                  ListView(
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              '${widget.book.book.book_title}을 읽고 있어요',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'JUA',
                                  color: !isDarkMode
                                      ? const Color(0xFF4D77B2)
                                      : Colors.grey[350]),
                            ),
                            Text(
                              '현재 페이지를 기록해 볼까요?',
                              style: Theme.of(context).textTheme.labelMedium,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      AdjustableProgressBar(bookRecord: widget.book),
                      const SizedBox(height: 20),
                      Text(
                          '${dateCalculation(widget.book.startDate)}일째 읽고있어요.'),
                      ReadPeriod(
                          startDate: widget.book.startDate,
                          isDarkMode: isDarkMode),
                    ],
                  ),
                  _buildSaveButton(isDarkMode, '여정이 끝났어요'),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildWishState(isDarkMode),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildStopState(isDarkMode),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDoneState(bool isDarkMode) {
    final ScrollController _scrollController =
        ScrollController(); // 스크롤 컨트롤러 추가
    return Stack(
      children: [
        ListView(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    '여정을 완료하셨네요!',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'JUA',
                        color: !isDarkMode
                            ? const Color(0xFF4D77B2)
                            : Colors.grey[350]),
                  ),
                  Text(
                    '남은 여운을 별점으로 기록해 볼까요?',
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            InteractiveStarRating(
                type: 1, size: 25, onRatingChanged: (newRating) {}),
            const SizedBox(height: 20),
            Text(
              '독서기간',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ReadPeriod(
              startDate: DateTime.now(),
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 15),
            Text(
              '한줄평',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 50, // 높이 조정
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: !isDarkMode ? Colors.grey[100] : Colors.grey[900],
                ),
                child: Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '이번 여정은 어떠셨나요?',
                        hintStyle: Theme.of(context).textTheme.labelMedium,
                        border: InputBorder.none,
                      ),
                      maxLines: null, // 여러 줄 입력 가능
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
        _buildSaveButton(isDarkMode, '저장')
      ],
    );
  }

  Widget _buildWishState(bool isDarkMode) {
    final ScrollController _scrollController =
        ScrollController(); // 스크롤 컨트롤러 추가
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                '이 책이 궁금하군요!',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'JUA',
                    color: !isDarkMode
                        ? const Color(0xFF4D77B2)
                        : Colors.grey[350]),
              ),
              Text(
                '기대지수와 기대평을 남겨볼까요?',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 20),
              InteractiveStarRating(
                type: 2,
                size: 25,
                onRatingChanged: (newRating) {},
              ),
              const SizedBox(height: 20),
              Text(
                '기대평',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 50, // 높이 조정
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: !isDarkMode ? Colors.grey[100] : Colors.grey[900],
                  ),
                  child: Scrollbar(
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '이번 여정은 어떠셨나요?',
                          hintStyle: Theme.of(context).textTheme.labelMedium,
                          border: InputBorder.none,
                        ),
                        maxLines: null, // 여러 줄 입력 가능
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildStopState(bool isDarkMode) {
    final TextEditingController _pageController = TextEditingController();
    final ScrollController _scrollController = ScrollController();

    return Stack(
      children: [
        ListView(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    '멈춘 페이지도 하나의 기록',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'JUA',
                        color: !isDarkMode
                            ? const Color(0xFF4D77B2)
                            : Colors.grey[350]),
                  ),
                  Text(
                    '이유를 남겨두면 돌아올 때 도움이 될 거예요',
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            InteractiveStarRating(
                type: 1, size: 25, onRatingChanged: (newRating) {}),

            const SizedBox(height: 20),

            /// 📌 페이지 입력 필드
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    controller: _pageController,
                    keyboardType: TextInputType.number, // ✅ 숫자 입력 전용
                    decoration: InputDecoration(
                        hintText: '00',
                        hintStyle: Theme.of(context).textTheme.labelMedium),
                  ),
                ),
                const SizedBox(width: 8), // ✅ 간격 추가
                Flexible(flex: 9, child: Text('페이지에서 쉬고 있어요')),
              ],
            ),

            const SizedBox(height: 20),

            /// 📌 독서 기간 표시
            Text('독서기간', style: Theme.of(context).textTheme.titleMedium),
            ReadPeriod(startDate: DateTime.now(), isDarkMode: isDarkMode),

            const SizedBox(height: 15),

            /// 📌 한줄평 입력
            Text('한줄평', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(
              height: 50, // 높이 조정
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: !isDarkMode ? Colors.grey[100] : Colors.grey[900],
                ),
                child: Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '이번 여정은 어떠셨나요?',
                        hintStyle: Theme.of(context).textTheme.labelMedium,
                        border: InputBorder.none,
                      ),
                      maxLines: null, // 여러 줄 입력 가능
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 60),
          ],
        ),
        _buildSaveButton(isDarkMode, '저장'),
      ],
    );
  }

  Widget _buildSaveButton(isDarkMode, String text) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
              !isDarkMode ? const Color(0xFF4D77B2) : Colors.grey[800]),
          fixedSize: MaterialStatePropertyAll(Size(300, 50)),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }

  int dateCalculation(DateTime startDate) {
    int period = DateTime.now().difference(startDate).inDays;
    return period;
  }
}
