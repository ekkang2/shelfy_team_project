import 'package:flutter/material.dart';

class NoteTabBar extends StatelessWidget {
  final TabController tabController;

  const NoteTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0), // 회색 라인
        ),
      ),
      child: TabBar(
        controller: tabController,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            color: Color(0xFF4D77B2), // 파란색 일자 라인
            width: 2.0,
          ),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: const Color(0xFF4D77B2), // 선택된 탭 텍스트 색상
        unselectedLabelColor: Colors.black38, // 선택되지 않은 탭 텍스트 색상
        tabs: const [
          Tab(text: '노트'),
          Tab(text: '통계'),
        ],
      ),
    );
  }
}
