import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_section.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_tab.dart';
import 'package:shelfy_team_project/data/gvm/note_list_view_model.dart';
import 'package:intl/intl.dart';
import '../../../../data/model/note_model.dart';
import 'note_statistcs_page.dart'; // 날짜 변환을 위한 intl 패키지 추가

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NoteStatsTab();
  }
}

class NoteStatsTab extends ConsumerStatefulWidget {
  const NoteStatsTab({super.key});

  @override
  ConsumerState<NoteStatsTab> createState() => _NoteStatsTabState();
}

class _NoteStatsTabState extends ConsumerState<NoteStatsTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLatestFirst = true; // 정렬 순서 상태 변수 (true: 최신 순)

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // ✅ 노트 목록 불러오기
    Future.microtask(
      () => ref.read(noteListViewModelProvider.notifier).fetchNotes(1),
    ); // ✅ 유저 ID 추가
  }

  // ✅ 날짜 비교 함수 (정렬 기준)
  int _compareDates(Note a, Note b) {
    try {
      DateTime dateA = DateTime.parse(a.createdAt); // ✅ createdAt 필드 기준 정렬
      DateTime dateB = DateTime.parse(b.createdAt);
      return isLatestFirst ? dateB.compareTo(dateA) : dateA.compareTo(dateB);
    } catch (e) {
      print("🚨 날짜 변환 오류: ${a.createdAt} | ${b.createdAt}");
      return 0;
    }
  }

  // ✅ 노트 리스트 정렬 함수 (최신순/오래된순)
  List<Note> _sortedNotes(List<Note> notes) {
    List<Note> sortedList = List.from(notes);
    sortedList.sort(_compareDates);
    return sortedList;
  }

  @override
  Widget build(BuildContext context) {
    final noteList = ref.watch(noteListViewModelProvider); // ✅ 상태 구독

    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NoteTabBar(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28.0, vertical: 16.0),
                  children: [
                    NoteSection(
                      title: '기록 서랍',
                      notes: _sortedNotes(noteList), // ✅ 정렬된 노트 리스트 사용
                      icon: Icons.bookmarks,
                    ),
                  ],
                ),
                const NoteStatisticsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
