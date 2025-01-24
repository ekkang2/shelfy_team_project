import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shelfy_team_project/theme.dart';

AppBar HomeAppBar(VoidCallback onSearchPressed, BuildContext context) {
  return AppBar(
    // 타이틀 위치
    titleSpacing: 8,
    // backgroundColor: const Color(0xFF4D77B2),
    scrolledUnderElevation: 0,
    title: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0, top: 6.0, bottom: 6.0),
          child: Image.asset(
            'assets/images/shelfy_kitty_logo.png',
            width: 40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Image.asset(
            'assets/images/Shelfy_textLogo_white.png',
            width: 80,
          ),
        )
      ],
    ),
    actions: [
      IconButton(
        onPressed: onSearchPressed,
        icon: Icon(
          CupertinoIcons.search,
          color: Colors.white,
        ),
      ),
    ],
  );
}

AppBar SearchAppBar(BuildContext context) {
  return AppBar(
    // 타이틀 위치
    titleSpacing: 8,
    // backgroundColor: const Color(0xFF4D77B2),
    scrolledUnderElevation: 0,
    title: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0, top: 6.0, bottom: 6.0),
          child: Image.asset(
            'assets/images/shelfy_kitty_logo.png',
            width: 40,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '책 검색',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'JUA',
          ),
        )
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.add_outlined,
          color: Colors.white,
        ),
      ),
    ],
  );
}

AppBar BooksAppBar(BuildContext context) {
  return AppBar(
    // 타이틀 위치
    titleSpacing: 8,
    // backgroundColor: const Color(0xFF4D77B2),
    scrolledUnderElevation: 0,
    title: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0, top: 6.0, bottom: 6.0),
          child: Image.asset(
            'assets/images/shelfy_kitty_logo.png',
            width: 40,
          ),
        ),
        const SizedBox(width: 10),
        Text('나의 책장', style: textTheme().displayLarge)
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(
          CupertinoIcons.search,
          color: Colors.white,
        ),
      ),
    ],
  );
}

AppBar NoteAppBar(BuildContext context) {
  return AppBar(
    // 타이틀 위치
    titleSpacing: 8,
    // backgroundColor: const Color(0xFF4D77B2),
    scrolledUnderElevation: 0,
    title: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0, top: 6.0, bottom: 6.0),
          child: Image.asset(
            'assets/images/shelfy_kitty_logo.png',
            width: 40,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '나의 기록',
          style: TextStyle(fontSize: 20, color: Colors.white),
        )
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/test");
        },
        icon: Icon(
          CupertinoIcons.square_pencil,
          color: Colors.white,
        ),
      ),
    ],
  );
}

AppBar MyAppbar(BuildContext context) {
  return AppBar(
    // 타이틀 위치
    titleSpacing: 8,
    // backgroundColor: const Color(0xFF4D77B2),
    scrolledUnderElevation: 0,
    title: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0, top: 6.0, bottom: 6.0),
          child: Image.asset(
            'assets/images/shelfy_kitty_logo.png',
            width: 40,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '나의 설정',
          style: TextStyle(fontSize: 20, color: Colors.white),
        )
      ],
    ),
  );
}

AppBar WriteAppBar(BuildContext context) {
  return AppBar(
    // 타이틀 위치
    titleSpacing: 8,
    // backgroundColor: const Color(0xFF4D77B2),
    scrolledUnderElevation: 0,
    title: Center(
      child: Text(
        '글쓰기',
        style: TextStyle(fontSize: 20),
      ),
    ),
    actions: [
      TextButton(
          onPressed: () {},
          child: Text(
            '완료',
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(color: Colors.white),
          )),
      // IconButton(
      //   onPressed: () {
      //     Navigator.of(context).pushNamed("/test");
      //   },
      //   icon: Icon(
      //     CupertinoIcons.square_pencil,
      //     color: Colors.white,
      //   ),
      // ),
    ],
  );
}
