import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/data/gvm/book_view_model/book_write_view_model.dart'; // inputFormatters 사용을 위해 필요

class AddBook extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();

  AddBook({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 뷰 모델 상태를 구독
    final data = ref.watch(bookWriteViewModelProvider);
    // 뷰 모델 행위 사용(뷰 모델 자체를 들고오기)
    final vm = ref.read(bookWriteViewModelProvider.notifier);

    return SafeArea(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          // 타이틀 위치
          titleSpacing: 3,
          scrolledUnderElevation: 0,
          title: Text(
            '책 정보 등록',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'JUA',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // 저장 버튼 클릭 이벤트
                vm.createBook(
                  myBookTitle: _titleController.text.trim(),
                  myBookAuthor: _authorController.text.trim(),
                  myBookPublisher: _publisherController.text.trim(),
                  myBookIsbn: _isbnController.text.trim(),
                  myBookPage: _pagesController.text.trim(),
                );
                // 레코드 문법 활용 가능
                if (data.$3 == true) {
                  // 페이지 이동 처리
                  _titleController.clear();
                  _authorController.clear();
                  _publisherController.clear();
                  _isbnController.clear();
                  _pagesController.clear();
                }
              },
              child: Text(
                '저장',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'JUA',
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            // 이미지 업로드 섹션
            Center(
              child: GestureDetector(
                onTap: () {
                  // 이미지 업로드 동작 추가
                  print('이미지 업로드 클릭');
                },
                child: Container(
                  width: 120,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            buildSection('제목', _titleController),
            buildSection('지은이', _authorController),
            buildSection('출판사', _publisherController),
            buildSection(
              'ISBN',
              _isbnController,
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z0-9]')), // 영문자와 숫자 허용
              ],
            ),
            buildSection(
              '페이지',
              _pagesController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // 숫자만 허용
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        // 제목
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'JUA',
          ),
        ),
        // 입력 필드
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          // 입력 타입 설정
          inputFormatters: inputFormatters,
          // 입력 제한 설정
          decoration: InputDecoration(
            border: InputBorder.none, // 입력 필드 밑줄 제거
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
          cursorColor: Colors.grey,
        ),
        // 하단 구분선
        Divider(
          thickness: 1,
          color: Colors.grey[300],
          height: 10,
        ),
      ],
    );
  }
}
