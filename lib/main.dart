import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/_core/constants/theme.dart';
import 'package:shelfy_team_project/ui/pages/auth/join_page/join_page.dart';
import 'package:shelfy_team_project/ui/pages/auth/login_page/login_page.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/note_add_book.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/note_view_page.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/note_write_page.dart';

import 'data/gvm/darkmode_model.dart';
import 'ui/pages/main_screen.dart';

void main() {
  runApp(ProviderScope(child: const ShelfUI()));
}

// Navigator ( 화면 전환을 관리하는 객체 ) -- stack 구조로 화면을 관리한다.
GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();
// 고유 키를 생성 ( GlobalKey ) --> 모든 위젯은 고유 값을 식별하기 위해 키를 가질 수 있다.
// 전역 변수로 navigatorkey 선언 --> Navigator 관리 상태에 접근이 가능하다.
// 현재 가장 위에 있는 context 를 알아낼 수 있다.

class ShelfUI extends ConsumerWidget {
  const ShelfUI({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool _isDarkMode = ref.watch(darkModeNotiProvider);
    return MaterialApp(
      title: 'shelfy_ui',
      debugShowCheckedModeBanner: false,
      theme: mTheme(_isDarkMode),
      navigatorKey: navigatorkey,
      // 테마를 적용
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        // 노트 라우트
        '/noteWrite': (context) => NoteWritePage(),
        '/noteView': (context) => const NoteViewPage(),
        '/noteAddBook': (context) => const NoteAddBookPage(),
        // My 페이지 목록
        '/login': (context) => LoginPage(),
        '/join': (context) => const JoinPage(),
      },
    );
  }
}
