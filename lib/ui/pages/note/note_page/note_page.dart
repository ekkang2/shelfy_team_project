import 'package:flutter/material.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_item.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_section.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_tab.dart';

import '../../../../data/model/note_memo.dart';
import 'package:intl/intl.dart';

import 'note_statistcs_page.dart'; // 날짜 변환을 위한 intl 패키지 추가

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NoteStatsTab();
  }
}

class NoteStatsTab extends StatefulWidget {
  const NoteStatsTab({super.key});

  @override
  State<NoteStatsTab> createState() => _NoteStatsTabState();
}

class _NoteStatsTabState extends State<NoteStatsTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLatestFirst = true; // 정렬 순서 상태 변수 (true: 최신 순)

  // 날짜 비교 함수 (유효한 날짜 변환 적용)
  int _compareDates(Note a, Note b) {
    try {
      DateTime dateA = DateFormat("yyyy.MM.dd").parse(a.date); // 날짜 변환 적용
      DateTime dateB = DateFormat("yyyy.MM.dd").parse(b.date);
      return isLatestFirst
          ? dateB.compareTo(dateA)
          : dateA.compareTo(dateB); // 최신순 or 오래된순 정렬
    } catch (e) {
      print("🚨 날짜 변환 오류: ${a.date} | ${b.date}");
      return 0; // 변환 실패 시 정렬 유지
    }
  }

  // 정렬된 노트 리스트 반환 함수
  List<Note> _sortedNotes(List<Note> notes) {
    List<Note> sortedList = List.from(notes);
    sortedList.sort(_compareDates); // 날짜 기준 정렬
    return sortedList;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 탭바 컨트롤러 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 전체 좌측 정렬 유지
      children: [
        NoteTabBar(tabController: _tabController), // 커스텀 탭바 사용
        Expanded(
          // 남은 공간을 확장하여 활용
          child: TabBarView(
            controller: _tabController,
            children: [
              // 노트 리스트 화면
              ListView(
                shrinkWrap: true, // 리스트 크기 자동 조절 (터치 문제 해결)
                padding: const EdgeInsets.symmetric(
                    horizontal: 28.0, vertical: 16.0), // 공통 패딩
                children: [
                  NoteSection(
                    title: '기록 서랍',
                    notes: noteDrawer,
                    icon: Icons.bookmarks,
                  ),
                  const SizedBox(height: 16.0), // 섹션 간 간격
                  NoteSection(
                    title: '기록 조각',
                    notes: _sortedNotes(noteFragments), // 정렬된 노트 리스트 사용
                    // notes: noteFragments,
                    icon: Icons.menu_book,
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        setState(() {
                          isLatestFirst =
                              (value == 'latest'); // 선택한 값에 따라 정렬 상태 변경
                          noteDrawer.sort(_compareDates); // 노트 즉시 정렬
                          noteFragments.sort(_compareDates);
                        });
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem<String>(
                          value: 'latest',
                          child: Text('최신 순'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'oldest',
                          child: Text('오래된 순'),
                        ),
                      ],
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isLatestFirst ? '최신 순' : '오래된 순',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                          const Icon(Icons.arrow_drop_down, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // 두 번째 탭: 통계 화면 (올바른 위치)
              const NoteStatisticsPage(), // 새로운 통계 위젯 추가
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose(); // 탭 컨트롤러 해제
    super.dispose();
  }
}
