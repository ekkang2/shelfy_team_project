import 'package:flutter/material.dart';
import 'package:shelfy_team_project/theme.dart';

class DoneBookList extends StatelessWidget {
  const DoneBookList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text(
            '어쩌구 저쩌구 이것저것',
            style: textTheme().titleLarge,
          ),
          subtitle: Text('이 책은 개짱입니다', style: textTheme().bodyMedium),
        ),
        ListTile(
          title:
              Text('Books Yveis Saint Laulent', style: textTheme().titleLarge),
          subtitle: Text('This Book is Fxxking Awesome',
              style: textTheme().bodySmall),
        ),
      ],
    );
  }
}
