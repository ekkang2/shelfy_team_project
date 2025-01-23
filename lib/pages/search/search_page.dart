import 'package:flutter/material.dart';
import 'package:shelfy_team_project/models/book.dart';

import 'components/book_item.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: Container(
            height: 45.0,
            child: SearchBar(
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
            ),
          ),
        ),
        // Expanded 위젯으로 ListView 감싸기
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return BookItem(book: bookList[index]);
            },
            itemCount: bookList.length,
          ),
        ),
      ],
    );
  }
}
