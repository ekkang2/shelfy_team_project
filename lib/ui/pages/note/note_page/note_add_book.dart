import 'package:flutter/material.dart';
import '../../../../../data/model/book.dart'; // 기존 모델 파일 import

class NoteAddBookPage extends StatefulWidget {
  const NoteAddBookPage({super.key});

  @override
  State<NoteAddBookPage> createState() => _NoteAddBookPageState();
}

class _NoteAddBookPageState extends State<NoteAddBookPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int? _selectedBookId;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '책 추가',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF4D77B2),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFF4D77B2),
                labelColor: const Color(0xFF4D77B2),
                unselectedLabelColor: Colors.black38,
                indicatorWeight: 2,
                onTap: (index) {
                  setState(() {
                    if (index == 1) {
                      _searchQuery = "";
                      _searchController.clear();
                    }
                  });
                },
                tabs: [
                  _buildTabItem('여정 중인 책',
                      isSelected: _tabController.index == 0),
                  _buildTabItem('나의 서재', isSelected: _tabController.index == 1),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildBookList(bookList.take(5).toList()), // 상위 5개 책만 표시
                  _buildSearchableBookList(),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '기록과 함께 하는 책을 선택해주세요.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String text, {required bool isSelected}) {
    return Tab(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildBookList(List<Book> books) {
    return _buildBookListView(books);
  }

  Widget _buildSearchableBookList() {
    List<Book> filteredBooks = bookList
        .where((book) =>
            book.book_title
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            book.book_author.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ),
        Expanded(child: _buildBookListView(filteredBooks)),
      ],
    );
  }

  Widget _buildBookListView(List<Book> books) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: books.length,
      separatorBuilder: (_, __) => Divider(
        color: Colors.grey[300],
        thickness: 0.8,
        height: 1,
      ),
      itemBuilder: (context, index) {
        final book = books[index];
        final isSelected = _selectedBookId == book.book_id;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedBookId = isSelected ? null : book.book_id;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    book.book_image,
                    width: 50,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.book_title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        book.book_author,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).primaryColorLight
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.add,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
