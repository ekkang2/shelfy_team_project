import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'note_item.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        ...notes
            .map(
              (note) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0), // 리스트 간 간격 추가
                child: NoteItem(note: note),
              ),
            )
            .toList(),
      ],
    );
  }
}
