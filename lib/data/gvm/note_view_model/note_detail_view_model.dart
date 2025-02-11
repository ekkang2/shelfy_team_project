import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../../model/note_model.dart';
import '../../repository/note_repository.dart';
import 'note_view_model.dart';

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
  final int noteId;

  NoteDetailViewModel(this._repository, this.noteId) : super(null) {
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
}

// ✅ 노트 수정 함수
Future<void> updateNote(WidgetRef ref, Note updatedNote) async {
  final repository = ref.read(noteRepositoryProvider);
  final noteData = updatedNote.toJson(); // JSON 변환

  logger.d("📌 PATCH 요청 보낼 데이터: $noteData"); // ✅ 전송 데이터 로그 추가

  try {
    final result = await repository.update(updatedNote.noteId!, noteData);
    logger.d("✅ 노트 수정 서버 응답: $result"); // ✅ 서버 응답 로그

    if (result['success'] == true) {
      ref.invalidate(noteDetailViewModelProvider(updatedNote.noteId!));
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
    await repository.delete(id: noteId); // ✅ API 호출
    logger.d("✅ 노트 삭제 성공");

    // ✅ 삭제 후 FutureProvider 상태 무효화
    ref.invalidate(noteDetailViewModelProvider(noteId));
  } catch (e) {
    logger.e("🚨 노트 삭제 실패: $e");
    rethrow;
  }
}
