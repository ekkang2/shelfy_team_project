import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/data/gvm/book_view_model/book_view_model.dart';
import 'package:shelfy_team_project/data/model/book_model/book.dart';
import 'package:shelfy_team_project/ui/pages/search/search_page/widget/book_item.dart';

class SearchPage extends ConsumerWidget {
  SearchPage({super.key});

  final TextEditingController _searchController =
      TextEditingController(); // 검색어 컨트롤러 추가
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              elevation: WidgetStatePropertyAll(0),
              leading: Icon(
                Icons.search,
                color: Colors.grey[500],
              ),
              hintText: '검색어를 입력해주세요',
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
              onSubmitted: (query) async {
                // Enter 키 이벤트 추가
                if (query.isNotEmpty) {
                  await bookvm.searchBooks(query); // 검색 요청 실행
                }
              },
            ),
          ),
        ),
        // Expanded 위젯으로 ListView 감싸기
        Expanded(
          child: bookList.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return BookItem(book: bookList[index]);
                  },
                  itemCount: bookList.length,
                )
              : Center(child: Text("검색 결과가 없습니다.")),
        ),
      ],
    );
  }
}
