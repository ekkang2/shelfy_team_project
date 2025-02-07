import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_section.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_tab.dart';
import 'package:shelfy_team_project/data/gvm/note_view_model/note_list_view_model.dart';
import '../../../../data/model/note_model.dart';
import 'note_statistcs_page.dart';

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
  bool isLatestFirst = true; // 정렬 순서 상태 변수

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(
        () => ref.read(noteListViewModelProvider.notifier).fetchNotes(1));
  }

  // ✅ 노트 리스트 정렬 함수 (최신순/오래된순)
  List<Note> _sortedNotes(List<Note> notes) {
    return List.from(notes)
      ..sort((a, b) => isLatestFirst
          ? DateTime.parse(b.createdAt).compareTo(DateTime.parse(a.createdAt))
          : DateTime.parse(a.createdAt).compareTo(DateTime.parse(b.createdAt)));
  }

  @override
  Widget build(BuildContext context) {
    final noteList = ref.watch(noteListViewModelProvider);
    final noteListViewModel = ref.watch(noteListViewModelProvider.notifier);

    // ✅ 기록 서랍 (북마크된 노트만) -> 정렬 없이 그대로
    final bookmarkedNotes = noteList.where((note) => note.notePin).toList();

    // ✅ 기록 조각 (전체 노트) -> 정렬 적용
    final sortedNotes = _sortByDate(noteList, isLatestFirst); // ✅ 기록 조각만 정렬!

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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28.0, vertical: 24.0),
                  children: [
                    // ✅ 기록 서랍 (정렬 없음)
                    NoteSection(
                      title: '기록 서랍',
                      notes: bookmarkedNotes, // ✅ 원본 리스트 사용 (정렬 X)
                      icon: Icons.bookmarks,
                    ),
                    const SizedBox(height: 16),
                    // ✅ 기록 조각 (정렬 적용)
                    NoteSection(
                      title: '기록 조각',
                      notes: sortedNotes, // ✅ 최신순 / 오래된 순 정렬 적용
                      icon: Icons.menu_book,
                      trailing: _buildSortButton(), // ✅ 기록 조각만 정렬
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

// ✅ 정렬 버튼 (PopupMenuButton)
  Widget _buildSortButton() {
    return PopupMenuButton<String>(
      onSelected: (value) {
        setState(() {
          isLatestFirst = (value == 'latest'); // ✅ 선택한 값 반영
        });
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'latest', child: Text('최신 순')),
        const PopupMenuItem(value: 'oldest', child: Text('오래된 순')),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(isLatestFirst ? '최신 순' : '오래된 순',
              style: TextStyle(color: Colors.grey[700])),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_drop_down, color: Colors.grey),
        ],
      ),
    );
  }

// ✅ 날짜 정렬 함수 (기록 조각만 적용)
  List<Note> _sortByDate(List<Note> notes, bool isLatestFirst) {
    List<Note> sortedList = List.from(notes);
    sortedList.sort((a, b) {
      DateTime dateA = DateTime.parse(a.createdAt);
      DateTime dateB = DateTime.parse(b.createdAt);
      return isLatestFirst ? dateB.compareTo(dateA) : dateA.compareTo(dateB);
    });
    return sortedList;
  }
}
