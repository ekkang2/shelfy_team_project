import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod 패키지 import
import 'package:shelfy_team_project/data/gvm/record_view_model/record_list_view_model.dart';
import 'package:shelfy_team_project/data/model/record_model/record_response_model.dart';
import 'widget/shelf_view.dart';
import 'widget/stack_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeTab();
  }
}

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  late String selectedYear;
  late String selectedMonth;

  late List<String> years;
  final List<String> months = ['전체보기'] +
      List.generate(12, (index) => (index + 1).toString().padLeft(2, '0'));

  List<RecordResponseModel> doneBookList = []; // 필드로 추가

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    selectedYear = now.year.toString();
    selectedMonth = '전체보기';

    years = List.generate(
        now.year - 2010 + 1, (index) => (2010 + index).toString());

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // ref.watch를 통해 상태를 감시
    List<RecordResponseModel> model = ref.watch(recordListProvider);
    print('모델 데이터: ${model.length}'); // 모델 데이터 길이 출력
    RecordListViewModel vm = ref.read(recordListProvider.notifier);

    if (model.isEmpty) {
      return Center(child: CircularProgressIndicator()); // 로딩 인디케이터 표시
    }
    // doneBookList를 업데이트
    doneBookList = model.where((element) => element.stateType == 1).toList();

    return Column(
      children: [
        _buildHeaderWithYearAndMonth(),
        _buildTabBar(),
        Expanded(
          child: _buildTabBarView(),
        )
      ],
    );
  }

  Widget _buildHeaderWithYearAndMonth() {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    String displayDate =
        selectedMonth == '전체보기' ? selectedYear : "$selectedYear-$selectedMonth";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 75.0, vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: !isDarkMode ? Color(0xFF4D77B2) : Colors.grey[300]),
            onPressed: () {
              setState(() {
                int currentIndex = years.indexOf(selectedYear);
                if (currentIndex > 0) {
                  selectedYear = years[currentIndex - 1];
                  selectedMonth = '전체보기';
                }
              });
            },
          ),
          GestureDetector(
            onTap: () => _showMonthSelectionDialog(),
            child: Text(
              displayDate,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: !isDarkMode ? Color(0xFF4D77B2) : Colors.grey[300]),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios,
                color: !isDarkMode ? Color(0xFF4D77B2) : Colors.grey[300]),
            onPressed: () {
              setState(() {
                int currentIndex = years.indexOf(selectedYear);
                if (currentIndex < years.length - 1) {
                  selectedYear = years[currentIndex + 1];
                  selectedMonth = '전체보기';
                }
              });
            },
          ),
        ],
      ),
    );
  }

  void _showMonthSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('월 선택'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: months
                  .map(
                    (month) => ListTile(
                      title: Text(month),
                      onTap: () {
                        setState(() {
                          selectedMonth = month;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  TabBarView _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        // 쌓아보기
        StackView(
          selectedYear: selectedYear,
          selectedMonth: selectedMonth,
          done: doneBookList.isNotEmpty ? doneBookList : [], // 빈 리스트를 전달
        ),
        // 책장보기
        ShelfView(
          selectedYear: selectedYear,
          selectedMonth: selectedMonth,
          done: doneBookList.isNotEmpty ? doneBookList : [], // 빈 리스트를 전달
        ),
      ],
    );
  }

  TabBar _buildTabBar() {
    return TabBar(controller: _tabController, tabs: [
      Tab(text: '쌓아보기'),
      Tab(text: '책장보기'),
    ]);
  }
}
