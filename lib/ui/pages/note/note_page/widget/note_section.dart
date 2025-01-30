import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../../../../pages/note/components/note_item.dart';

final logger = Logger(); // Logger 인스턴스 생성

class NoteSection extends StatelessWidget {
  final String title;
  final List<Note> notes;
  final IconData icon; // 아이콘 매개변수 추가
  final Widget? trailing;

  const NoteSection({
    super.key,
    required this.title,
    required this.notes,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 섹션 전체 좌측 정렬
      children: [
        // 섹션 제목과 트레일링을 같은 Row에 배치 (양끝 정렬)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양끝 정렬
          crossAxisAlignment: CrossAxisAlignment.center, // 수직 정렬
          children: [
            // 좌측: 아이콘 + 섹션 제목
            Row(
              children: [
                Icon(icon, color: Color(0xFF4D77B2)), // 아이콘
                const SizedBox(width: 8.0), // 아이콘과 텍스트 간격
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)
                    // 스타일을 유지하며, 특정 속성만 변경
                    ),
              ],
            ),
            // 우측: 트레일링 위젯 (최신 순)
            if (trailing != null) trailing!,
          ],
        ),
        const SizedBox(height: 8.0), // 섹션 제목과 리스트 간 간격
        // 리스트 아이템들
        ...notes.map((note) => NoteItem(note: note)).toList(),
      ],
    );
  }
}
