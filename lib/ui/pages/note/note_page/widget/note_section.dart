import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shelfy_team_project/data/model/note_model.dart';

final logger = Logger(); // Logger 인스턴스 생성

class NoteSection extends StatelessWidget {
  final String title;
  final List<Note> notes; // ✅ Note 모델만 사용
  final IconData icon;
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ 상단 제목 + 아이콘 + 정렬 옵션
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8.0),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if (trailing != null) trailing!,
          ],
        ),
        const SizedBox(height: 8.0),

        // ✅ 노트 리스트 렌더링 (NoteItem 없이 직접 ListTile 사용)
        ...notes
            .map(
              (note) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ListTile(
                  tileColor: Colors.grey[200], // 배경색 추가
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)), // 카드 스타일
                  title: Text(note.title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(note.content,
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  trailing: note.notePin
                      ? const Icon(Icons.push_pin, color: Colors.blue)
                      : null,
                  onTap: () {
                    // ✅ 노트 상세 페이지 이동 가능 (필요하면 여기에 로직 추가)
                    logger.d("노트 선택됨: ${note.title}");
                  },
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
