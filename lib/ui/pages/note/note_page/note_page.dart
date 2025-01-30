import 'package:flutter/material.dart';
import 'package:shelfy_team_project/pages/note/components/note_tab.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_item.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 탭바 컨트롤러 초기화
  }

  final List<Note> noteDrawer = [
    Note(title: '파과를 읽고', preview: '파과 | 구병모', date: '2024.01.22'),
    Note(title: '천 개의 파랑', preview: '천 개의 파랑 | 천선란', date: '2024.01.22'),
  ];

  final List<Note> noteFragments = [
    Note(
        title: '읽고 싶은 책 리스트',
        preview: '읽고 싶은 책이 많다 2025년엔...',
        date: '2024.01.22'),
    Note(
        title: '조각은 어떻게 그런 삶을 살 수 있을까',
        preview: '파과 | 구병모',
        date: '2024.01.22'),
    Note(
        title: '읽고 싶은 책 리스트',
        preview: '읽고 싶은 책이 많다 2025년엔...',
        date: '2024.01.22'),
    Note(
        title: '파과를 드디어 읽게 되었다 구병모 작가님 팬이 돼',
        preview: '파과 | 구병모',
        date: '2024.01.22'),
    Note(
        title: '읽고 싶은 책 리스트',
        preview: '읽고 싶은 책이 많다 2025년엔...',
        date: '2024.01.22'),
    Note(
        title: '조각은 어떻게 그런 삶을 살 수 있을까',
        preview: '파과 | 구병모',
        date: '2024.01.22'),
  ];

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
                shrinkWrap: true, // ✅ 리스트 크기 자동 조절 (터치 문제 해결)
                physics: const NeverScrollableScrollPhysics(), // ✅ 내부 스크롤 막기
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
                    notes: noteFragments,
                    icon: Icons.menu_book,
                    trailing: Row(
                      children: [
                        const Text(
                          '최신 순',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
              const Center(
                child: Text('통계 화면', style: TextStyle(fontSize: 18)),
              ),
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

class NoteSection extends StatelessWidget {
  final String title;
  final List<Note> notes;
  final IconData icon; // 섹션 아이콘
  final Widget? trailing; // 우측 정렬 위젯 (예: 최신 순)

  const NoteSection({
    super.key,
    required this.title,
    required this.notes,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 전체 좌측 정렬 유지
      children: [
        // 섹션 제목과 트레일링 위젯을 같은 라인에 배치
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양끝 정렬
          crossAxisAlignment: CrossAxisAlignment.center, // 아이콘과 텍스트를 수직 정렬
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center, // 내부 좌측 정렬 유지
              children: [
                Icon(icon, color: Color(0xFF4D77B2), size: 20), // 아이콘 크기 조정
                const SizedBox(width: 8.0), // 아이콘과 텍스트 간 간격
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            if (trailing != null) trailing!, // 최신 순 텍스트와 아이콘
          ],
        ),
        const SizedBox(height: 8.0), // 섹션 제목과 리스트 간 간격
// ✅ 리스트 아이템 클릭 가능하도록 GestureDetector 추가
        ...notes.map(
          (note) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0), // ✅ 리스트 아이템 간 여백 추가
            child: NoteItem(note: note),
          ),
        ),
      ],
    );
  }
}
