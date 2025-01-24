import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/data/gvm/doing_view_model.dart';
import 'package:shelfy_team_project/data/gvm/done_view_model.dart';
import 'package:shelfy_team_project/data/model/book_record_doing.dart';
import 'package:shelfy_team_project/data/model/book_record_done.dart';
import 'package:shelfy_team_project/theme.dart';

import 'components/shelf_book_item.dart';
import 'components/shelf_status_widget.dart';

class BooksPage extends ConsumerWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doingList = ref.watch(DoingViewModelProvider);
    final doingNotifier = ref.read(DoingViewModelProvider.notifier);

    final doneList = ref.watch(DoneViewModelProvider);
    final doneNotifier = ref.read(DoneViewModelProvider.notifier);

    return DefaultTabController(
      length: 4, // 탭 개수
      child: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: _buildTabBarView(
                doingList, doingNotifier, doneList, doneNotifier),
          ),
        ],
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Color(0xFF4D77B2),
          width: 3.0,
        ),
      ),
      labelColor: const Color(0xFF4D77B2),
      unselectedLabelColor: Colors.black38,
      labelStyle: textTheme().displayMedium,
      tabs: const [
        Tab(text: '끝맺은 책'),
        Tab(text: '여정 중인 책'),
        Tab(text: '기다리는 책'),
        Tab(text: '잠든 책'),
      ],
    );
  }

  TabBarView _buildTabBarView(
    List<BookRecordDoing> doingList,
    DoingViewModel doingNotifier,
    List<BookRecordDone> doneList,
    DoneViewModel doneNoti,
  ) {
    return TabBarView(
      children: [
        // 끝맺은 책
        // ListView.builder(
        //   itemBuilder: (context, index) {
        //     final doneRecord = doneList[index];
        //     return ShelfBookItem(
        //       done: doneRecord,
        //       widget: doingWidget(record, doneNoti), // 여기에 창고에서 프로그래스 함수 호출
        //     );
        //   },
        //   itemCount: doneList.length,
        // ),
        // 여정 중인 책
        ListView.builder(
          itemBuilder: (context, index) {
            final doing = doingList[index];
            return ShelfBookItem(
              doing: doing,
              widget: doingWidget(doing, doingNotifier), // 여기에 창고에서 프로그래스 함수 호출
            );
          },
          itemCount: doingList.length,
        ),
        // 기다리는 책
        const Center(child: Text('기다리는 책')),
        // 잠든 책
        const Center(child: Text('잠든 책')),
      ],
    );
  }
}
//
// class ProfileTab extends StatefulWidget {
//   const ProfileTab({super.key});
//
//   @override
//   State<ProfileTab> createState() => _ProfileTabState();
// }
//
// class _ProfileTabState extends State<ProfileTab>
//     with SingleTickerProviderStateMixin {
//   // 멤버 변수
//   // tabController는 TabBar와 TabBarView를 동기화하는 컨트롤러입니다.
//   TabController? _tabController;
//
//   // 단 한 번 호출되는 메서드이다.
//   @override
//   void initState() {
//     super.initState();
//     print('프로필 탭 내부 클래스 init 호출했다');
//     // length 는 탭의 개수를 의미한다.
//     // vsync는 자연스러운 애니메이션 전환을 위해서 TickerProvider를 활용한다.
//     _tabController = TabController(length: 4, vsync: this);
//   }
//
//   // build 메서드는 기본적으로 그림을 그릴 때 호출이 된다.
//   @override
//   Widget build(BuildContext context) {
//     // 화면을 그려주는 영역
//     print('빌드 호출');
//     return Column(
//       children: [
//         _buildTabBar(),
//         Expanded(
//           child: _buildTabBarView(),
//         ),
//       ],
//     );
//   }
//
//   TabBarView _buildTabBarView() {
//     return TabBarView(
//       controller: _tabController,
//       children: [
//         // 끝맺은 책
//         Text('data'),
//         Expanded(
//           child: ListView.builder(
//             itemBuilder: (context, index) {
//               return DoingBookItem(
//                 doing: doingBookList[index],
//                 widget: doingWidget(30.0), // 여기에 창고에서 프로그래스 함수 호출
//               );
//             },
//             itemCount: doingBookList.length,
//           ),
//         ),
//         Text('3'),
//         Text('4'),
//         // 여정 중인 책
//         // 기다리는 책
//         // 잠든 책
//       ],
//     );
//   }
//
//   TabBar _buildTabBar() {
//     return TabBar(
//       indicatorSize: TabBarIndicatorSize.tab,
//       indicator: UnderlineTabIndicator(
//         borderSide: BorderSide(
//           color: const Color(0xFF4D77B2),
//           width: 3.0,
//         ),
//         insets: EdgeInsets.symmetric(horizontal: 0),
//       ),
//       labelColor: const Color(0xFF4D77B2),
//       unselectedLabelColor: Colors.black38,
//       dividerHeight: 3,
//       dividerColor: Colors.black26,
//       labelStyle: textTheme().displayMedium,
//       // 중간 매개체로 연결
//       controller: _tabController,
//       tabs: [
//         Tab(
//           child: Text('끝맺은 책'),
//         ),
//         Tab(
//           child: Text(
//             '여정 중인 책',
//             overflow: TextOverflow.visible,
//             maxLines: 1,
//           ),
//         ),
//         Tab(text: '기다리는 책'),
//         Tab(text: '잠든 책'),
//       ],
//     );
//   }
// }
