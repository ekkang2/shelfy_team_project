import 'package:flutter/material.dart';

class NoteAddBookPage extends StatefulWidget {
  const NoteAddBookPage({super.key});

  @override
  State<NoteAddBookPage> createState() => _NoteAddBookPageState();
}

class _NoteAddBookPageState extends State<NoteAddBookPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('책 추가'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: '예정 중인 책'),
              Tab(text: '나의 서재'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildBookList(), // 📌 예정 중인 책 리스트
            _buildBookList(), // 📌 나의 서재 리스트 (같은 UI 재사용 가능)
          ],
        ),
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text('기록과 함께 하는 책을 선택해주세요.'),
          ),
        ),
      ),
    );
  }

  Widget _buildBookList() {
    final List<Map<String, String>> books = [
      {'title': 'Yves Saint Laurent', 'author': 'Suzy Menkes'},
      {'title': 'The Book of Signs', 'author': 'Rudolf Koch'},
      {'title': 'Yves Saint Laurent', 'author': 'Suzy Menkes'},
      {'title': 'The Book of Signs', 'author': 'Rudolf Koch'},
    ];

    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            width: 50,
            height: 70,
            color: Colors.grey[300], // 책 표지 이미지 대신 임시 색상
          ),
          title: Text(
            books[index]['title']!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(books[index]['author']!),
          trailing: IconButton(
            icon: const Icon(Icons.add, color: Colors.blue),
            onPressed: () {
              print("📚 '${books[index]['title']}' 추가됨");
              Navigator.pop(
                  context, books[index]['title']); // ✅ 선택 후 이전 페이지로 데이터 전달
            },
          ),
        );
      },
    );
  }
}
