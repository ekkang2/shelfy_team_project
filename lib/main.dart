import 'package:flutter/material.dart';
import 'package:shelfy_team_project/theme.dart';

import 'pages/main_screen.dart';
import 'pages/note/note_write_page.dart';

void main() {
  runApp(const ShelfUI());
}

class ShelfUI extends StatelessWidget {
  const ShelfUI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shelfy_ui',
      debugShowCheckedModeBanner: false,
      theme: mTheme(), // 테마를 적용
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/test': (context) => const NoteWritePage(),
      },
    );
  }
}
