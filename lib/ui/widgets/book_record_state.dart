import 'package:flutter/material.dart';

import 'custom_interactive_star_rating.dart';

class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
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
              color: Colors.white, // 선택된 탭의 배경색
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            indicatorSize: TabBarIndicatorSize.tab, // 인디케이터 크기 조정
            // indicatorPadding:
            //     EdgeInsets.symmetric(horizontal: 8, vertical: 4), // 인디케이터 여백 설정
            labelColor: const Color(0xFF4D77B2), // 선택된 탭 텍스트 색상
            unselectedLabelColor: Colors.black38, // 비활성화된 탭 텍스트 색상
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text('다 읽으셨군요.'),
                    ),
                    const SizedBox(height: 20),
                    InteractiveStarRating(
                        type: 1, size: 25, onRatingChanged: (newRating) {}),
                    const SizedBox(height: 20),
                    Text(
                      '독서기간',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text('기간 들어가는 겁니다'),
                          Text('기간 들어가는 겁니다'),
                        ],
                      ),
                      decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.3)),
                    ),
                    const SizedBox(height: 20),
                    Text('한줄평을 남겨보세요!'),
                    TextField(),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('기록 남기기'),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black12),
                      ),
                    ),
                  ],
                ),
              ),
              Center(child: Text('여정 중인 책 내용')),
              Center(child: Text('기다리는 책 내용')),
              Center(child: Text('잠든 책 내용')),
            ],
          ),
        ),
      ],
    );
  }
}
