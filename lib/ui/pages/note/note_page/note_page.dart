import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  bool isLatestFirst = true;
  bool isBookmarkedExpanded = true;
  bool _isFetching = false; //  중복 실행 방지 플래그

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sessionUser = ref.read(sessionProvider);
      final userId = sessionUser.id ?? 0;

      if (userId != 0) {
        print("initState에서 fetchNotes 호출: userId=$userId");
        ref.read(noteListViewModelProvider.notifier).fetchNotes(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final noteList = ref.watch(noteListViewModelProvider);

    final bookmarkedNotes = noteList.where((note) => note.notePin).toList();
    final sortedNotes = _sortByDate(noteList, isLatestFirst);

    //  sessionProvider 값 변경 감지를 build() 내부에서 실행
    ref.listen<SessionUser>(sessionProvider, (previous, next) {
      if (previous?.id != next.id && next.id != null && next.id != 0) {
        ref.read(noteListViewModelProvider.notifier).fetchNotes(next.id!);
      }
      ref.read(noteListViewModelProvider.notifier).fetchNotes(next.id!);
      // }
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
                    if (bookmarkedNotes.isNotEmpty)
                      NoteSection(
                        title: '기록 서랍',
                        icon: Icons.bookmarks,
                        userId: ref.read(sessionProvider).id ?? 0,
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
                        notes: isBookmarkedExpanded ? bookmarkedNotes : [],
                      ),
                    const SizedBox(height: 16),
                    if (sortedNotes.isNotEmpty)
                      NoteSection(
                        title: '기록 조각',
                        notes: sortedNotes,
                        icon: Icons.menu_book,
                        userId: ref.read(sessionProvider).id ?? 0,
                        trailing: _buildSortButton(),
                      )
                    else
                      _buildEmptyNoteMessage(),
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

  Widget _buildSortButton() {
    return PopupMenuButton<String>(
      onSelected: (value) {
        setState(() {
          isLatestFirst = (value == 'latest');
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
            Text("아직 작성된 노트가 없습니다.",
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
      ),
    );
  }

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
