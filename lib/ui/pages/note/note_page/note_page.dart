import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/providers/session_user_provider.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_section.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_tab.dart';
import 'package:shelfy_team_project/data/gvm/note_view_model/note_list_view_model.dart';
import '../../../../data/gvm/user_view_model/session_view_model.dart';
import '../../../../data/model/note_model.dart';
import '../../../../data/model/user_model/session_user.dart';
import 'note_statistcs_page.dart';
import 'package:logger/logger.dart';

final logger = Logger(); // Logger 인스턴스 추가

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
  bool isBookmarkedExpanded = true; // 기록 서랍 펼침 상태 추가

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // ✅ 초기 노트 목록 가져오기
    Future.microtask(() {
      final userId = ref.read(sessionProvider).id ?? 0;
      if (userId != 0) {
        ref.read(noteListViewModelProvider.notifier).fetchNotes(userId);
      }
    });
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
    final noteItem = ref.watch(noteListViewModelProvider);

    // ✅ 기록 서랍 (북마크된 노트만) -> 정렬 없이 그대로
    final bookmarkedNotes = noteList.where((note) => note.notePin).toList();

    // ✅ 기록 조각 (전체 노트) -> 정렬 적용
    final sortedNotes = _sortByDate(noteList, isLatestFirst); // ✅ 기록 조각만 정렬!

    // ✅ sessionProvider 값 변경 감지 (로그인 상태 변경 시 `fetchNotes()` 실행)
    ref.listen<SessionUser>(sessionProvider, (previous, next) {
      if (previous?.id != next.id && next.id != null && mounted) {
        noteListViewModel.fetchNotes(next.id!);
      }
    });
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
                    // ✅ 기록 서랍 (접고 펼치는 기능)
                    // ✅ 기록 서랍 (리스트만 접고 펼침)
                    if (bookmarkedNotes.isNotEmpty)
                      NoteSection(
                        title: '기록 서랍',
                        icon: Icons.bookmarks,
                        userId: getUserId(ref),
                        trailing: IconButton(
                          icon: Icon(
                            isBookmarkedExpanded
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isBookmarkedExpanded = !isBookmarkedExpanded;
                            });
                          },
                        ),
                        notes: isBookmarkedExpanded
                            ? bookmarkedNotes
                            : [], // ✅ 리스트만 숨김
                      ),

                    const SizedBox(height: 16),
                    // ✅ 기록 조각 (정렬 적용)
                    if (sortedNotes.isNotEmpty)
                      NoteSection(
                        title: '기록 조각',
                        notes: sortedNotes,
                        icon: Icons.menu_book,
                        userId: getUserId(ref),
                        trailing: _buildSortButton(),
                      )
                    else
                      _buildEmptyNoteMessage(), // 🔥 노트가 없을 때 안내 메시지 표시
                  ],
                ),
                NoteStatisticsPage(),
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

  Widget _buildEmptyNoteMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.edit_note,
                size: 50, color: Colors.grey[400]), // 📝 아이콘 추가
            const SizedBox(height: 10),
            Text(
              "노트가 비어있어요. 새로운 글을 남겨보세요!",
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
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
