import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shelfy_team_project/ui/pages/books/books_page/widget/shelf_book_item_done.dart';

import '../../../../data/gvm/record_view_model/record_list_view_model.dart';
import '../../../../data/model/record_model/record_list.dart';

class BooksPage extends ConsumerStatefulWidget {
  final int initialIndex; // 초기 탭 인덱스 추가

  const BooksPage({super.key, this.initialIndex = 0}); // 기본값 설정

  @override
  ConsumerState<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends ConsumerState<BooksPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.initialIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RecordListViewModel vm = ref.read(recordListProvider.notifier);
    RecordList? model = ref.watch(recordListProvider);

    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          _buildTabBar(context),
          Expanded(
            child: _buildTabBarView(model, vm),
          ),
        ],
      ),
    );
  }

  TabBar _buildTabBar(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TabBar(
      controller: _tabController, // ✅ TabController 추가
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: !isDarkMode ? const Color(0xFF4D77B2) : Colors.grey,
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

  TabBarView _buildTabBarView(RecordList? model, RecordListViewModel vm) {
    if (model == null) {
      return TabBarView(
        children: [
          CircularProgressIndicator(),
        ],
      ); //Center(child: CircularProgressIndicator());
    } else {
      return TabBarView(
        controller: _tabController, // ✅ TabController 추가
        children: [
          SmartRefresher(
            controller: _refreshController, // RefreshController를 View에서 관리
            enablePullUp: true,
            enablePullDown: true,
            onRefresh: () async {
              await vm.init();
              _refreshController.refreshCompleted();
            },
            onLoading: () async {
              await vm.nextList();
              _refreshController.loadComplete();
            },
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ShelfBookItemDone(done: model.records[index]);
              },
              itemCount: model.records.length,
            ),
          ),
          Center(child: Text('여정 중인 책')),
          Center(child: Text('기다리는 책')),
          Center(child: Text('잠든 책')),
        ],
      );
    }
  }
}
