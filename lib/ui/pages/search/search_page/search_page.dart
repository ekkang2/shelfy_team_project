import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/data/gvm/book_view_model/book_view_model.dart';
import 'package:shelfy_team_project/data/model/book_model/book.dart';
import 'package:shelfy_team_project/ui/pages/search/search_page/widget/book_item.dart';

class SearchPage extends ConsumerStatefulWidget {
  SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController =
      TextEditingController(); // 검색어 컨트롤러 추가
  final FocusNode _focusNode = FocusNode(); // 포커스 감지
  bool _isLoading = false; // 로딩 상태 추가

  @override
  void initState() {
    super.initState();
    // FocusNode 리스너 추가
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose(); // 텍스트 컨트롤러 해제
    _focusNode.dispose(); // 포커스 노드 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookvm = ref.read(bookProvider.notifier);
    final List<Book> bookList = ref.watch(bookProvider); // 상태 감시 추가

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: Container(
            height: 45.0,
            child: SearchBar(
              controller: _searchController,
              focusNode: _focusNode,
              elevation: WidgetStatePropertyAll(0),
              leading: Icon(
                Icons.search,
                color: Colors.grey[500],
              ),
              hintText: '책 제목 또는 저자, 출판사를 입력해 주세요.',
              hintStyle: WidgetStatePropertyAll(
                TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14.0,
                ),
              ),
              backgroundColor: WidgetStatePropertyAll(Colors.grey[200]),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              // 검색어가 입력되고 포커스가 있을 때만 x버튼 표시
              trailing: _searchController.text.isNotEmpty && _focusNode.hasFocus
                  ? [
                      IconButton(
                        onPressed: () {
                          _searchController.clear(); // 검색어 초기화
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey[500],
                          size: 21.0,
                        ),
                      ),
                    ]
                  : [],
              onSubmitted: (query) async {
                // Enter 키 이벤트 추가
                if (query.isNotEmpty) {
                  setState(() {
                    _isLoading = true; // 로딩 시작
                  });
                  await bookvm.searchBooks(query); // 검색 요청 실행
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
            ),
          ),
        ),
        // Expanded 위젯으로 ListView 감싸기
        Expanded(
          child: _isLoading
              ? Center(child: CircularProgressIndicator()) // 로딩 표시
              : bookList.isNotEmpty
                  ? ListView.builder(
                      itemCount: bookList.length + 1, // 마지막 항목으로 검색결과 더보기 버튼 추가
                      itemBuilder: (context, index) {
                        if (index < bookList.length) {
                          return BookItem(book: bookList[index]); // 기존 책 항목
                        } else {
                          return // 검색 결과 더보기 버튼
                              Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 18),
                            child: OutlinedButton(
                              onPressed: () async {
                                // 더보기 버튼 클릭 시 검색 실행 로직 추가
                                if (_searchController.text.isNotEmpty) {
                                  setState(() {
                                    _isLoading = true; // 로딩 시작
                                  });
                                  await bookvm
                                      .searchBooksMore(_searchController.text);
                                  setState(() {
                                    _isLoading = false; // 로딩 종료
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Text('검색결과 더보기'),
                                  ),
                                  Icon(Icons.arrow_forward, size: 16.0),
                                ],
                              ),
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: Color(0xFF4D77B2)), // 테두리 색상 설정
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(7.0))),
                            ),
                          );
                        }
                      },
                    )
                  : Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("검색 결과가 없습니다."),
                      ],
                    )),
        ),
      ],
    );
  }
}
