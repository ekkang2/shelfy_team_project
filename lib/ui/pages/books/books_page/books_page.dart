import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shelfy_team_project/ui/pages/books/books_page/widget/shelf_book_item_doing.dart';
import 'package:shelfy_team_project/ui/pages/books/books_page/widget/shelf_book_item_done.dart';
import 'package:shelfy_team_project/ui/pages/books/books_page/widget/shelf_book_item_stop.dart';
import 'package:shelfy_team_project/ui/pages/books/books_page/widget/shelf_book_item_wish.dart';

import '../../../../data/gvm/record_view_model/record_list_view_model.dart';
import '../../../../data/model/record_model/record_list.dart';
import '../../../../data/model/record_model/record_response_model.dart';

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
    List<RecordResponseModel> model = ref.watch(recordListProvider);
    RecordListViewModel vm = ref.read(recordListProvider.notifier);

    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          _buildTabBar(context),
          Expanded(
            child: _buildTabBarView(model),
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

  TabBarView _buildTabBarView(List<RecordResponseModel> model) {
    List<RecordResponseModel> done =
        model.where((element) => element.stateType == 1).toList();
    List<RecordResponseModel> doing =
        model.where((element) => element.stateType == 2).toList();
    List<RecordResponseModel> wish =
        model.where((element) => element.stateType == 3).toList();
    List<RecordResponseModel> stop =
        model.where((element) => element.stateType == 4).toList();

    if (model == null) {
      return TabBarView(
        children: [
          Stack(
            children: [
              Center(child: Text('독서 기록 데이터가 없습니다.')),
              Positioned(
                bottom: 20,
                right: 20,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      const Color(0xFF4D77B2),
                    ),
                    iconColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.add),
                ),
              )
            ],
          ),
        ],
      ); //Center(child: CircularProgressIndicator());
    } else {
      return TabBarView(
        controller: _tabController, // ✅ TabController 추가
        children: [
          ListView.builder(
            itemCount: done.length,
            itemBuilder: (context, index) {
              return ShelfBookItemDone(done: done[index]);
            },
          ),
          ListView.builder(
            itemCount: doing.length,
            itemBuilder: (context, index) {
              return ShelfBookItemDoing(
                doing: doing[index],
              );
            },
          ),
          ListView.builder(
            itemCount: wish.length,
            itemBuilder: (context, index) {
              return ShelfBookItemWish(wish: wish[index]);
            },
          ),
          ListView.builder(
            itemCount: stop.length,
            itemBuilder: (context, index) {
              return ShelfBookItemStop(stop: stop[index]);
            },
          ),
        ],
      );
    }
  }
}
