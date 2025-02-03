import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/search/search_page/widget/add_book.dart';

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
        onPressed: () {
          // 페이지 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBook(), // 이동할 페이지
            ),
          );
        },
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
    titleSpacing: (ModalRoute.of(context)?.canPop ?? false) ? -10 : 8,
    // backgroundColor: const Color(0xFF4D77B2),
    scrolledUnderElevation: 0,
    title: Row(
      children: [
        Visibility(
          visible: !(ModalRoute.of(context)?.canPop ?? false),
          child: Padding(
            padding: const EdgeInsets.only(left: 6.0, top: 6.0, bottom: 6.0),
            child: Image.asset(
              'assets/images/shelfy_kitty_logo.png',
              width: 40,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text('나의 책장', style: Theme.of(context).textTheme.displayLarge)
      ],
    ),
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
          // Navigator.of(context).pushNamed(
          //     "/note"); // 현재 context에서 Navigator 객체를 가져와 '/test' 경로로 이동
          Navigator.pushNamed(
              context, '/note'); // '/test' 경로로 이동하여 NoteWritePage 화면을 표시
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
          style: TextStyle(fontSize: 20),
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
    ],
  );
}

AppBar ViewAppBar(BuildContext context) {
  return AppBar(
    // 타이틀 위치
    titleSpacing: 8,
    // backgroundColor: const Color(0xFF4D77B2),
    scrolledUnderElevation: 0,
    title: Center(
      child: Text(
        '글보기',
        style: TextStyle(fontSize: 20),
      ),
    ),
    actions: [
      TextButton(
          onPressed: () {},
          child: Text(
            '수정',
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(color: Colors.white),
          )),
    ],
  );
}

AppBar BookDetailBar(BuildContext context) {
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
          '상세 보기',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'JUA',
          ),
        )
      ],
    ),
  );
}

AppBar BasicAppBar(BuildContext context, String title) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        // 현재 포커스된 위젯의 포커스를 해제
        FocusScope.of(context).unfocus();
        Navigator.pop(context);
      },
      icon: Icon(CupertinoIcons.arrow_left),
    ),
    // 타이틀 위치
    titleSpacing: 8,
    scrolledUnderElevation: 0,
    title: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'JUA',
          ),
        )
      ],
    ),
  );
}
