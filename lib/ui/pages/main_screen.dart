import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/custom_appbar.dart';
import 'books/books_page/books_page.dart';
import 'home/home_page/home_page.dart';
import 'my/my_page/my_page.dart';
import 'note/note_page/note_page.dart';
import 'search/search_page/search_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainPageState();
}

class _MainPageState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              HomeAppBar(() {
                setState(() {
                  _selectedIndex = 1;
                });
              }, context),
              SearchAppBar(context),
              BooksAppBar(context),
              NoteAppBar(context),
              MyAppbar(context),
            ],
          ),
        ),
        // IndexedStack 을 활용해 여러 화면을 동시에 호출하고 각 페이지의 상태를 기억함 ( 스크롤 위치 등 )
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            HomePage(),
            SearchPage(),
            BooksPage(),
            NotePage(),
            MyPage(),
          ],
        ),
        bottomNavigationBar: SizedBox(
          // 가로 길이를 최대로 확장
          width: double.infinity,
          height: 70,
          child: Theme(
            data: Theme.of(context).copyWith(
              // 클릭 시 물결 애니메이션 제거
              splashFactory: NoSplash.splashFactory,
              // 클릭 시 원 모양 애니메이션 제거
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              // 4개 이상의 아이콘을 추가할 때 fixed 타입으로 변경 ( 아이콘 탭 시에도 위치 고정된 상태 유지 )
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.stacked_bar_chart),
                  label: 'My Shelf',
                ),
                BottomNavigationBarItem(
                  // 아이콘 크기 때문에 틀어진 라벨 위치를 맞추기 위해 사이즈박스 사용
                  icon: SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(FontAwesomeIcons.penNib, size: 18),
                  ),
                  label: 'Note',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'My',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
