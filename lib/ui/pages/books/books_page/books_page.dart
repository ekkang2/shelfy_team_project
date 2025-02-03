import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/data/gvm/doing_view_model.dart';
import 'package:shelfy_team_project/data/gvm/done_view_model.dart';
import 'package:shelfy_team_project/data/model/book_record_doing.dart';
import 'package:shelfy_team_project/data/model/book_record_done.dart';
import 'package:shelfy_team_project/ui/pages/books/books_page/widget/shelf_book_item_stop.dart';

import '../../../../data/gvm/stop_view_model.dart';
import '../../../../data/gvm/wish_view_model.dart';
import 'widget/shelf_book_item_doing.dart';
import 'widget/shelf_book_item_done.dart';
import 'widget/shelf_book_item_wish.dart';
import 'widget/shelf_status_widget.dart';

class BooksPage extends ConsumerWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doingList = ref.watch(DoingViewModelProvider);
    final doingNotifier = ref.read(DoingViewModelProvider.notifier);

    final doneList = ref.watch(DoneViewModelProvider);
    final doneNotifier = ref.read(DoneViewModelProvider.notifier);

    final wishList = ref.watch(wishViewModelProvider);
    final wishNotifier = ref.read(wishViewModelProvider.notifier);

    final stopList = ref.watch(stopViewModelProvider);
    final stopNotifier = ref.read(stopViewModelProvider.notifier);

    return DefaultTabController(
      length: 4, // 탭 개수
      child: Column(
        children: [
          _buildTabBar(context),
          Expanded(
            child: _buildTabBarView(doingList, doingNotifier, doneList,
                doneNotifier, wishList, wishNotifier, stopList, stopNotifier),
          ),
        ],
      ),
    );
  }

  TabBar _buildTabBar(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: !isDarkMode ? Color(0xFF4D77B2) : Colors.grey,
          width: 3.0,
        ),
      ),
      dividerColor: Colors.transparent,
      labelColor: !isDarkMode ? const Color(0xFF4D77B2) : Colors.grey[400],
      unselectedLabelColor: !isDarkMode ? Colors.black38 : Colors.grey[600],
      labelStyle: Theme.of(context).textTheme.displayMedium,
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
      List wishList,
      WishViewModel wishNoti,
      List stopList,
      StopViewModel stopNoti) {
    return TabBarView(
      children: [
        // 끝맺은 책
        ListView.builder(
          itemBuilder: (context, index) {
            final done = doneList[index];
            return ShelfBookItemDone(
                done: done, widget: DoneWidget(done, doneNoti, context));
          },
          itemCount: doneList.length,
        ),
        // 여정 중인 책
        ListView.builder(
          itemBuilder: (context, index) {
            final doing = doingList[index];
            return ShelfBookItemDoing(
              doing: doing,
              widget: doingWidget(
                  doing, doingNotifier, context), // 여기에 창고에서 프로그래스 함수 호출
            );
          },
          itemCount: doingList.length,
        ),
        // 기다리는 책
        ListView.builder(
          itemBuilder: (context, index) {
            final wish = wishList[index];
            return ShelfBookItemWish(
              book: wish,
              noti: wishNoti,
            );
          },
          itemCount: wishList.length,
        ),
        // 잠든 책
        ListView.builder(
          itemBuilder: (context, index) {
            final stop = stopList[index];
            return ShelfBookItemStop(
              book: stop,
              noti: stopNoti,
            );
          },
          itemCount: stopList.length,
        ),
      ],
    );
  }
}
