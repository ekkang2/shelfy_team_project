import 'package:flutter/material.dart';

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
              Center(child: Text('끝맺은 책 내용')),
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
