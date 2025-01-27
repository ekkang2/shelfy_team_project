import 'package:flutter/material.dart';

import 'widget/shelf_view.dart';
import 'widget/stack_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeTab();
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  // 현재 날짜 필터 상태
  late String selectedYear;
  late String selectedMonth;

  late List<String> years;
  final List<String> months =
      List.generate(12, (index) => (index + 1).toString().padLeft(2, '0'));

  // 단 한번 호출되는 메서드
  @override
  void initState() {
    super.initState();

    // 현재 날짜를 기본값으로 설정
    DateTime now = DateTime.now();
    selectedYear = now.year.toString();
    selectedMonth = now.month.toString().padLeft(2, '0');

    // 2010년부터 현재년도까지 리스트 생성
    years = List.generate(
        now.year - 2010 + 1, (index) => (2010 + index).toString());

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTabBar(),
        Expanded(
          child: _buildTabBarView(),
        )
      ],
    );
  }

  TabBarView _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        // 쌓아보기
        StackView(),
        // 책장보기
        ShelfView(),
      ],
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: const Color(0xFF4D77B2),
              width: 3.0,
            ),
            insets: EdgeInsets.symmetric(horizontal: 130.0)),
        labelColor: const Color(0xFF4D77B2),
        unselectedLabelColor: Colors.black38,
        dividerHeight: 3,
        dividerColor: Colors.black26,
        controller: _tabController,
        tabs: [
          Tab(text: '쌓아보기'),
          Tab(text: '책장보기'),
        ]);
  }
}
