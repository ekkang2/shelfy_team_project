import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../../_core/utils/logger.dart';
import '../../../../../data/gvm/note_view_model/note_list_view_model.dart';
import '../../../../../data/model/note_model.dart';
import '../note_view_page.dart';

class NoteItem extends ConsumerWidget {
  final Note note;

  const NoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // ✅ noteId가 null인지 체크
        if (note.noteId != null) {
          ref.read(selectedNoteProvider.notifier).state = note; // ✅ 선택된 노트 저장

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  NoteViewPage(noteId: note.noteId!), // ✅ noteId 전달
            ),
          );
        } else {
          print("🚨 noteId가 null이어서 페이지 이동을 중단함");
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border:
              Border.all(color: Colors.grey.shade300, width: 1), // ✅ 기존 스타일 유지
          borderRadius: BorderRadius.circular(8.0), // ✅ 기존 스타일 유지
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    note.title, // ✅ 기존 스타일 유지
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  DateFormat("yyyy.MM.dd")
                      .format(DateTime.parse(note.createdAt)), // ✅ 변환 후 표시
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8.0), // ✅ 기존 간격 유지
            Text(
              note.content, // ✅ 기존 스타일 유지
              style: Theme.of(context).textTheme.labelMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
