import 'package:flutter/material.dart';

class Note {
  final String title; // 제목
  final String preview; // 본문 미리보기
  final String date; // 날짜

  Note({
    required this.title,
    required this.preview,
    required this.date,
  });
}

class NoteItem extends StatelessWidget {
  final Note note;

  const NoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // 외부 여백
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // 배경색
          border: Border.all(color: Colors.grey.shade300, width: 1), // 테두리
          borderRadius: BorderRadius.circular(8.0), // 테두리 둥글기
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0), // 내부 여백
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 첫 줄: 제목과 날짜
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양끝 정렬
                children: [
                  // 제목 (길면 생략 처리)
                  Expanded(
                    child: Text(
                      note.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 1, // 한 줄로 제한
                      overflow: TextOverflow.ellipsis, // 생략 표시(...)
                    ),
                  ),
                  const SizedBox(width: 8.0), // 제목과 날짜 간 간격
                  // 날짜
                  Text(
                    note.date,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 8.0), // 제목과 미리보기 간 간격
              // 두 번째 줄: 본문 미리보기
              Text(
                note.preview,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1, // 한 줄로 제한
                overflow: TextOverflow.ellipsis, // 생략 표시(...)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
