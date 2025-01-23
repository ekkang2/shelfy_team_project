import 'package:flutter/material.dart';
import 'package:shelfy_team_project/models/book_record_doing.dart';
import 'package:shelfy_team_project/theme.dart';

import 'components/doing_book_item.dart';
import 'components/done_book_list.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileTab();
  }
}

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  // 멤버 변수
  // tabController는 TabBar와 TabBarView를 동기화하는 컨트롤러입니다.
  TabController? _tabController;

  // 단 한 번 호출되는 메서드이다.
  @override
  void initState() {
    super.initState();
    print('프로필 탭 내부 클래스 init 호출했다');
    // length 는 탭의 개수를 의미한다.
    // vsync는 자연스러운 애니메이션 전환을 위해서 TickerProvider를 활용한다.
    _tabController = TabController(length: 4, vsync: this);
  }

  // build 메서드는 기본적으로 그림을 그릴 때 호출이 된다.
  @override
  Widget build(BuildContext context) {
    // 화면을 그려주는 영역
    print('빌드 호출');
    return Column(
      children: [
        _buildTabBar(),
        Expanded(
          child: _buildTabBarView(),
        ),
      ],
    );
  }

  TabBarView _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        // 끝맺은 책
        DoneBookList(),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return DoingBookItem(doing: bookRecordDoingList[index]);
            },
            itemCount: bookRecordDoingList.length,
          ),
        ),
        Text('3'),
        Text('4'),
        // 여정 중인 책
        // 기다리는 책
        // 잠든 책
      ],
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: const Color(0xFF4D77B2),
          width: 3.0,
        ),
        insets: EdgeInsets.symmetric(horizontal: 0),
      ),
      labelColor: const Color(0xFF4D77B2),
      unselectedLabelColor: Colors.black38,
      dividerHeight: 3,
      dividerColor: Colors.black26,
      labelStyle: textTheme().displayMedium,
      // 중간 매개체로 연결
      controller: _tabController,
      tabs: [
        Tab(
          child: Text('끝맺은 책'),
        ),
        Tab(
          child: Text(
            '여정 중인 책',
            overflow: TextOverflow.visible,
            maxLines: 1,
          ),
        ),
        Tab(text: '기다리는 책'),
        Tab(text: '잠든 책'),
      ],
    );
  }
}
