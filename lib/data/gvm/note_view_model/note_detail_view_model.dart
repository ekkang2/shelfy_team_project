import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../../model/note_model.dart';
import '../../repository/note_repository.dart';
import 'note_view_model.dart';
import 'note_list_view_model.dart'; // ✅ 노트 리스트 뷰모델 가져오기

final logger = Logger();

// ✅ 노트 상세 조회 ViewModel
final noteDetailViewModelProvider =
    FutureProvider.autoDispose.family<Note?, int>((ref, noteId) async {
  final repository = ref.read(noteRepositoryProvider);
  try {
    final response = await repository.findById(id: noteId); // ✅ noteId로 조회
    return Note.fromJson(response);
  } catch (e) {
    print("🚨 노트 조회 실패: $e");
    return null;
  }
});

class NoteDetailViewModel extends StateNotifier<Note?> {
  final NoteRepository _repository;
  final WidgetRef _ref; // ✅ Riverpod ref 추가
  final int noteId;

  NoteDetailViewModel(this._repository, this._ref, this.noteId) : super(null) {
    fetchNote();
  }

  Future<void> fetchNote() async {
    logger.d("📌 fetchNote 실행됨 (noteId: $noteId)");
    try {
      final response = await _repository.findById(id: noteId);
      if (response.isNotEmpty) {
        state = Note.fromJson(response);
        logger.d("✅ 노트 데이터 불러오기 완료: ${state!.title}");
      }
    } catch (e) {
      logger.e("🚨 노트 불러오기 실패: $e");
    }
  }

  // ✅ 북마크 토글 함수
  Future<void> toggleBookmark() async {
    if (state == null) return;

    final updatedPinStatus = !state!.notePin;
    try {
      await _repository.updateNotePin(state!.noteId!, updatedPinStatus);
      state = state!.copyWith(notePin: updatedPinStatus); // ✅ UI 반영

      // ✅ 노트 리스트도 새로고침
      _ref.invalidate(noteListViewModelProvider);

      logger.d("✅ 북마크 상태 변경 완료 (notePin: $updatedPinStatus)");
    } catch (e) {
      logger.e("🚨 북마크 변경 실패: $e");
    }
  }
}

// ✅ 노트 수정 함수
Future<void> updateNote(WidgetRef ref, Note updatedNote) async {
  final repository = ref.read(noteRepositoryProvider);
  final noteData = updatedNote.toJson();

  logger.d("📌 PATCH 요청 보낼 데이터: $noteData");

  try {
    final result = await repository.update(updatedNote.noteId!, noteData);
    logger.d("✅ 노트 수정 서버 응답: $result");

    if (result['success'] == true) {
      ref.invalidate(noteDetailViewModelProvider(updatedNote.noteId!));
      ref.invalidate(noteListViewModelProvider); // ✅ 리스트 새로고침
    } else {
      logger.e("🚨 노트 수정 실패 (서버 응답 오류): ${result['errorMessage']}");
    }
  } catch (e) {
    logger.e("🚨 노트 수정 실패 (예외 발생): $e");
  }
}

// ✅ 노트 삭제 함수
Future<void> deleteNote(WidgetRef ref, int noteId) async {
  final repository = ref.read(noteRepositoryProvider);
  try {
    await repository.delete(id: noteId);
    logger.d("✅ 노트 삭제 성공");

    ref.invalidate(noteDetailViewModelProvider(noteId));
    ref.invalidate(noteListViewModelProvider); // ✅ 삭제 후 리스트 업데이트
  } catch (e) {
    logger.e("🚨 노트 삭제 실패: $e");
    rethrow;
  }
}
