import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // inputFormatters 사용을 위해 필요

import '../../../../../theme.dart';

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController publisherController = TextEditingController();
  final TextEditingController isbnController = TextEditingController();
  final TextEditingController pagesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                print('저장 버튼 클릭');
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
            buildSection('제목', titleController),
            buildSection('지은이', authorController),
            buildSection('출판사', publisherController),
            buildSection(
              'ISBN',
              isbnController,
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z0-9]')), // 영문자와 숫자 허용
              ],
            ),
            buildSection(
              '페이지',
              pagesController,
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
          keyboardType: keyboardType, // 입력 타입 설정
          inputFormatters: inputFormatters, // 입력 제한 설정
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
