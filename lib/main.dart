import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/theme.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/note_add_book.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/note_view_page.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/note_write_page.dart';

import 'data/gvm/darkmode_model.dart';
import 'pages/main_screen.dart';

void main() {
  runApp(ProviderScope(child: const ShelfUI()));
}

class ShelfUI extends ConsumerWidget {
  const ShelfUI({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool _isDarkMode = ref.watch(darkModeNotiProvider);
    return MaterialApp(
      title: 'shelfy_ui',
      debugShowCheckedModeBanner: false,
      theme: !_isDarkMode ? mTheme() : darkMTheme(),
      // 테마를 적용
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/note': (context) => const NoteWritePage(),
        '/noteView': (context) => const NoteViewPage(),
        '/noteAddBook': (context) => const NoteAddBookPage(),
      },
    );
  }
}
