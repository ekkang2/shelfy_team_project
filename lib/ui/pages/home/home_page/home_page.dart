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
  final List<String> months = ['전체보기'] +
      List.generate(12, (index) => (index + 1).toString().padLeft(2, '0'));

  @override
  void initState() {
    super.initState();

    // 현재 날짜를 기본값으로 설정
    DateTime now = DateTime.now();
    selectedYear = now.year.toString();
    selectedMonth = '전체보기';

    // 2010년부터 현재년도까지 리스트 생성
    years = List.generate(
        now.year - 2010 + 1, (index) => (2010 + index).toString());

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeaderWithYearAndMonth(),
        _buildTabBar(),
        Expanded(
          child: _buildTabBarView(),
        )
      ],
    );
  }

  Widget _buildHeaderWithYearAndMonth() {
    String displayDate =
        selectedMonth == '전체보기' ? selectedYear : "$selectedYear-$selectedMonth";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 75.0, vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF4D77B2)),
            onPressed: () {
              setState(() {
                int currentIndex = years.indexOf(selectedYear);
                if (currentIndex > 0) {
                  selectedYear = years[currentIndex - 1];
                  selectedMonth = '전체보기'; // 연도 변경 시 월을 전체보기로 초기화
                }
              });
            },
          ),
          GestureDetector(
            onTap: () => _showMonthSelectionDialog(),
            child: Text(
              displayDate,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4D77B2)),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFF4D77B2)),
            onPressed: () {
              setState(() {
                int currentIndex = years.indexOf(selectedYear);
                if (currentIndex < years.length - 1) {
                  selectedYear = years[currentIndex + 1];
                  selectedMonth = '전체보기'; // 연도 변경 시 월을 전체보기로 초기화
                }
              });
            },
          ),
        ],
      ),
    );
  }

  void _showMonthSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('월 선택'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: months
                  .map(
                    (month) => ListTile(
                      title: Text(month),
                      onTap: () {
                        setState(() {
                          selectedMonth = month;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  TabBarView _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        // 쌓아보기
        StackView(
          selectedYear: selectedYear,
          selectedMonth: selectedMonth,
        ),
        // 책장보기
        ShelfView(
          selectedYear: selectedYear,
          selectedMonth: selectedMonth,
        ),
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
