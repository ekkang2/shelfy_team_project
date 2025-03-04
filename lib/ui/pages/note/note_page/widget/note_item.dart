import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../../data/gvm/note_view_model/note_list_view_model.dart';
import '../../../../../data/gvm/user_view_model/session_view_model.dart';
import '../../../../../data/model/note_model.dart';
import '../../../../../providers/session_user_provider.dart';
import '../note_view_page.dart';

class NoteListView extends ConsumerWidget {
  final int? userId;

  const NoteListView({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteViewModel = ref.watch(noteListViewModelProvider);

    // ✅ 유저 ID가 없거나 0이면 전체 리스트에서 메시지 표시
    if (userId == null || userId == 0) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "유저 정보가 없습니다",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    // ✅ 노트가 없으면 전체 리스트에서 한 번만 메시지 표시
    if (noteViewModel.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "저장된 노트가 없습니다",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    // ✅ 노트 리스트 표시
    return ListView.builder(
      itemCount: noteViewModel.length,
      itemBuilder: (context, index) {
        final note = noteViewModel[index];
        return NoteItem(userId: userId, note: note);
      },
    );
  }
}

// ✅ 개별 노트 아이템 UI
class NoteItem extends ConsumerWidget {
  final int? userId;
  final Note note;

  const NoteItem({super.key, required this.userId, required this.note});

  Future<void> _navigateToNoteDetail(
      BuildContext context, WidgetRef ref) async {
    final shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NoteViewPage(noteId: note.noteId!)),
    );

    if (shouldRefresh == true) {
      ref.invalidate(noteListViewModelProvider);
      await Future.delayed(Duration(milliseconds: 100));

      int validUserId = ref.read(sessionProvider).id ?? 0;
      if (validUserId > 0) {
        // _fetchNotesOnce(validUserId); // ✅ 중복 실행 방지하여 fetchNotes 호출
      } else {
        print("🚨 fetchNotes 실행 안 함: 유저 ID 없음");
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (note.noteId != null) {
          _navigateToNoteDetail(context, ref);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    note.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  DateFormat("yyyy.MM.dd")
                      .format(DateTime.parse(note.createdAt)),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              note.content,
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
