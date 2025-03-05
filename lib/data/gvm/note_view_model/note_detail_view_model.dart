import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../../../providers/session_user_provider.dart';
import '../../model/note_model.dart';
import '../../repository/note_repository.dart';
import 'note_view_model.dart';
import 'note_list_view_model.dart';

final logger = Logger();

// 노트 상세 조회 ViewModel
final noteDetailViewModelProvider =
    FutureProvider.autoDispose.family<Note?, int>((ref, noteId) async {
  final repository = ref.read(noteRepositoryProvider);
  try {
    final response = await repository.findById(id: noteId); // noteId로 조회
    return Note.fromJson(response);
  } catch (e, stackTrace) {
    return Future.error(e, stackTrace); // 예외를 Future.error로 반환하여 AsyncError 유지
  }
});

class NoteDetailViewModel extends StateNotifier<Note?> {
  final NoteRepository _repository;
  final WidgetRef _ref; //  Riverpod ref 추가
  final int noteId;

  NoteDetailViewModel(this._repository, this._ref, this.noteId) : super(null) {
    fetchNote();
  }

  Future<void> fetchNote() async {
    try {
      final response = await _repository.findById(id: noteId);
      if (response.isNotEmpty) {
        state = Note.fromJson(response);
      }
    } catch (e) {}
  }

  // 북마크 토글 함수
  Future<void> toggleBookmark() async {
    if (state == null || state!.noteId == null) {
      return;
    }

    final updatedPinStatus = !state!.notePin;
    try {
      await _repository.updateNotePin(state!.noteId!, updatedPinStatus);
      state = state!.copyWith(notePin: updatedPinStatus);

      // 유저 ID 가져와서 노트 리스트 갱신
      try {
        final userId = getUserId(_ref) ?? 0;

        if (userId > 0) {
          _ref.invalidate(noteListViewModelProvider);

          Future.microtask(() {
            _ref.read(noteListViewModelProvider.notifier).fetchNotes(userId);
          });
        } else {}
      } catch (e) {}
    } catch (e) {}
  }

  Future<void> updateNote(WidgetRef ref, Note updatedNote) async {
    final repository = ref.read(noteRepositoryProvider);

    //  현재 시간을 updatedAt에 반영
    String updatedTime = DateTime.now().toIso8601String();
    final noteData = updatedNote.toJson();
    noteData['noteUpdatedAt'] = updatedTime; // updatedAt을 현재 시간으로 설정

    final result = await repository.update(updatedNote.noteId!, noteData);

    if (result == null || result.isEmpty) {
      return;
    }

    if (result.containsKey('success') && result['success'] == true) {
      //  fetchNotes 실행 추가하여 즉시 리스트 갱신
      final userId = getUserId(ref);
      if (userId > 0) {
        await ref.read(noteListViewModelProvider.notifier).fetchNotes(userId);
      }
    } else {}
  }

// 노트 삭제 함수
  Future<void> deleteNote(WidgetRef ref, int noteId) async {
    final repository = ref.read(noteRepositoryProvider);
    try {
      final result = await repository.delete(id: noteId);
      if (result == null || !result['success']) {
        return;
      }

      ref.invalidate(noteDetailViewModelProvider(noteId));
      ref.invalidate(noteListViewModelProvider);
    } catch (e) {
      rethrow;
    }
  }
}
