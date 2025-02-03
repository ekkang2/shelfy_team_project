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
          // TODO - 페이지 이동 임포트 빼기
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
        Text('나의 기록', style: Theme.of(context).textTheme.displayLarge)
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {
          // 현재 위젯 트리(context)에서 Navigator 객체를 가져와서 '/note' 페이지로 이동
          // 다중 Navigator가 있을 경우, 정확히 어떤 Navigator를 사용할지 명확하게 지정
          // Navigator.of(context).pushNamed("/note");
          Navigator.pushNamed(context, '/noteWrite'); // 단순한 페이지 이동
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

// 노트 페이지 공통 AppBar
AppBar NoteCustomAppBar({
  required BuildContext context,
  required String title, // 타이틀 텍스트
  String? actionText, // 우측 버튼 텍스트 (null 가능)
  VoidCallback? onActionPressed, // 버튼 클릭 시 실행할 함수 (null 가능)
}) {
  return AppBar(
    titleSpacing: 8,
    scrolledUnderElevation: 0,
    title: Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.displayLarge), // 타이틀 표시
      ],
    ),
    actions: [
      if (actionText != null && onActionPressed != null) // 조건부로 TextButton 표시
        TextButton(
          onPressed: onActionPressed,
          child:
              Text(actionText, style: Theme.of(context).textTheme.displayLarge),
        ),
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
