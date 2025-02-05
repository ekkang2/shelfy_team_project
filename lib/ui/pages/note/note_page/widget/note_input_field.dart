import 'package:flutter/material.dart';

/*
     날짜 : 2025/02/05
     이름 : 박경림
     내용 : 제목/내용 입력 공통 위젯 추가
*/
class NoteInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isEditMode; // 글쓰기/글보기 모드 구분
  final bool isTitle; // 제목인지 본문인지 구분
  final int? maxLines; // 최대 줄 수 (null이면 무제한)

  const NoteInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isEditMode = true,
    this.isTitle = false,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: isEditMode,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: isTitle
                ? Colors.black // ✅ 제목 입력 시 항상 검정색
                : (isEditMode
                    ? Colors.grey
                    : Colors.black), // ✅ 내용 입력 시 글쓰기(회색), 글보기(검정)
          ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelMedium,
        border: InputBorder.none,
      ),
      maxLines: maxLines ?? null, // null이면 무제한 입력
    );
  }
}
