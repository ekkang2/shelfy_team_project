import 'package:flutter/material.dart';

import '../../../../../data/model/book.dart'; // 기존 모델 파일 import

class NoteAddBookPage extends StatefulWidget {
  const NoteAddBookPage({super.key});

  @override
  State<NoteAddBookPage> createState() => _NoteAddBookPageState();
}

class _NoteAddBookPageState extends State<NoteAddBookPage>
    with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin을 사용하여 애니메이션 최적화
  late TabController _tabController; // 탭 컨트롤러 (TabBar 관리)
  int? _selectedBookId; // 선택된 책의 ID (하나만 선택 가능)
  TextEditingController _searchController =
      TextEditingController(); // 검색창 입력 컨트롤러
  String _searchQuery = ""; // 현재 검색어 저장

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2, vsync: this); // 탭 컨트롤러 초기화, vsync는 애니메이션 성능 최적화를 위해 사용
  }

  @override
  void dispose() {
    _tabController.dispose(); // 메모리 누수를 방지하기 위해 TabController 해제
    _searchController.dispose(); // 검색창 컨트롤러 해제 (메모리 관리)
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
              color: Colors.white, // 탭 바 배경색 지정
              child: TabBar(
                controller: _tabController,
                // 컨트롤러 연결
                indicatorColor: const Color(0xFF4D77B2),
                labelColor: const Color(0xFF4D77B2),
                unselectedLabelColor: Colors.black38,
                indicatorWeight: 2,
                // 탭 인디케이터 두께 설정
                onTap: (index) {
                  setState(() {
                    if (index == 1) {
                      _searchQuery = "";
                      _searchController.clear(); // "나의 서재" 탭 클릭 시 검색어 초기화
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
                controller: _tabController, // 컨트롤러 연결
                children: [
                  _buildBookList(bookList.take(5).toList()), // 상위 5개 책만 표시
                  _buildSearchableBookList(), // 검색 가능한 책 목록
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '기록과 함께 하는 책을 선택해주세요.',
                style: TextStyle(fontSize: 14, color: Colors.grey), // 안내 문구
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
          fontWeight:
              isSelected ? FontWeight.bold : FontWeight.normal, // 선택된 탭은 볼드 처리
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
                .contains(_searchQuery.toLowerCase()) || // 제목 검색
            book.book_author
                .toLowerCase()
                .contains(_searchQuery.toLowerCase())) // 작가 검색
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Container(
            height: 40, // 검색창 높이 설정
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0), // 검색창 배경색
              borderRadius: BorderRadius.circular(20), // 둥근 모서리
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value; // 검색어 변경 시 상태 업데이트
                });
              },
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: '책 제목이나 작가를 검색하세요',
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                // 돋보기 아이콘
                border: InputBorder.none,
                // 기본 테두리 제거
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ),
        Expanded(child: _buildBookListView(filteredBooks)), // 검색 결과 표시
      ],
    );
  }

  Widget _buildBookListView(List<Book> books) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: books.length,
      separatorBuilder: (_, __) => Divider(
        color: Colors.grey[300], // 리스트 아이템 사이 구분선
        thickness: 0.8,
        height: 1,
      ),
      itemBuilder: (context, index) {
        final book = books[index];
        final isSelected = _selectedBookId == book.book_id;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedBookId =
                  isSelected ? null : book.book_id; // 하나만 선택 가능하게 설정
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4), // 책 이미지 둥근 모서리 처리
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
                        : Colors.grey[200], // 기본 배경색
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.add,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey, // 기본 아이콘 색상
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
