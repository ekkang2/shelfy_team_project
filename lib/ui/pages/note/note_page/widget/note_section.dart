import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../../../data/model/note_model.dart';
import 'note_item.dart';

final logger = Logger(); // Logger 인스턴스 생성

class NoteSection extends StatelessWidget {
  final String title;
  final List<Note> notes;
  final int userId; // ✅ 유저 ID 추가

  final IconData icon; // ✅ 아이콘 스타일 유지
  final Widget? trailing;

  const NoteSection({
    super.key,
    required this.title,
    required this.notes,
    required this.userId,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ 섹션 제목 + 아이콘 + 정렬 옵션
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF4D77B2)), // ✅ 원래 스타일 유지
                const SizedBox(width: 8.0),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold), // ✅ 기존 스타일 유지
                ),
              ],
            ),
            if (trailing != null) trailing!,
          ],
        ),
        const SizedBox(height: 16.0),

        // ✅ 리스트 간격 & 스타일 유지
        ...notes
            .map(
              (note) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0), // ✅ 리스트 간 간격 유지
                child: NoteItem(
                  note: note,
                  userId: userId, // ✅ 유저 ID 추가
                ), // ✅ 올바르게 NoteItem으로 변경
              ),
            )
            .toList(),
      ],
    );
  }
}
