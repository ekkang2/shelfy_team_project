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
  final WidgetRef _ref; // ✅ Riverpod ref 추가
  final int noteId;

  NoteDetailViewModel(this._repository, this._ref, this.noteId) : super(null) {
    fetchNote();
  }

  Future<void> fetchNote() async {
    logger.d("fetchNote 실행됨 (noteId: $noteId)");
    try {
      final response = await _repository.findById(id: noteId);
      if (response.isNotEmpty) {
        state = Note.fromJson(response);
        logger.d("노트 데이터 불러오기 완료: ${state!.title}");
      }
    } catch (e) {
      logger.e("노트 불러오기 실패: $e");
    }
  }

  // 북마크 토글 함수
  Future<void> toggleBookmark() async {
    if (state == null || state!.noteId == null) {
      logger.e(" 북마크 변경 실패: 노트 정보가 없음");
      return;
    }

    final updatedPinStatus = !state!.notePin;
    try {
      await _repository.updateNotePin(state!.noteId!, updatedPinStatus);
      state = state!.copyWith(notePin: updatedPinStatus);

      // 유저 ID 가져와서 노트 리스트 갱신
      try {
        final userId = getUserId(_ref) ?? 0;
        logger.d("가져온 유저 ID: $userId");

        if (userId > 0) {
          logger.d("유저 ID 확인됨: $userId - 리스트 새로고침 실행");

          _ref.invalidate(noteListViewModelProvider);
          logger.d("노트 리스트 Provider 무효화됨 (userId: $userId)");

          Future.microtask(() {
            logger.d("fetchNotes 호출됨 (userId: $userId)");
            _ref.read(noteListViewModelProvider.notifier).fetchNotes(userId);
          });
        } else {
          logger.e("로그인되지 않은 상태! 리스트 새로고침 건너뜀");
        }
      } catch (e) {
        logger.e("유저 정보 가져오기 실패: $e");
      }

      logger.d("북마크 상태 변경 완료 (notePin: $updatedPinStatus)");
    } catch (e) {
      logger.e("북마크 변경 실패: $e");
    }
  }

// 노트 수정 함수
//   Future<void> updateNote(WidgetRef ref, Note updatedNote) async {
//     final repository = ref.read(noteRepositoryProvider);
//     final noteData = updatedNote.toJson();
//
//     logger.d("PATCH 요청 보낼 데이터: $noteData");
//
//     final result = await repository.update(updatedNote.noteId!, noteData);
//     logger.d("노트 수정 서버 응답: $result");
//
//     if (result == null || result.isEmpty) {
//       logger.e("노트 수정 실패: 응답 데이터가 없음");
//       return;
//     }
//
//     if (result.containsKey('success') && result['success'] == true) {
//       ref.invalidate(noteDetailViewModelProvider(updatedNote.noteId!));
//       ref.invalidate(noteListViewModelProvider);
//
//       final userId = getUserId(ref);
//       if (userId > 0) {
//         logger.d("🛠 수정 후 즉시 fetchNotes 실행 (userId: $userId)");
//         await ref.read(noteListViewModelProvider.notifier).fetchNotes(userId);
//       }
//     } else {
//       logger.e("노트 수정 실패 (서버 응답 오류): ${result['errorMessage'] ?? '알 수 없는 오류'}");
//     }
//   }

  Future<void> updateNote(WidgetRef ref, Note updatedNote) async {
    final repository = ref.read(noteRepositoryProvider);

    // ✅ 현재 시간을 updatedAt에 반영
    String updatedTime = DateTime.now().toIso8601String();
    final noteData = updatedNote.toJson();
    noteData['noteUpdatedAt'] = updatedTime; // updatedAt을 현재 시간으로 설정

    logger.d("🐛 PATCH 요청 보낼 데이터: $noteData");

    final result = await repository.update(updatedNote.noteId!, noteData);
    logger.d("🐛 노트 수정 서버 응답: $result");

    if (result == null || result.isEmpty) {
      logger.e("🐛 노트 수정 실패: 응답 데이터가 없음");
      return;
    }

    if (result.containsKey('success') && result['success'] == true) {
      // ✅ fetchNotes 실행 추가하여 즉시 리스트 갱신
      final userId = getUserId(ref);
      if (userId > 0) {
        logger.d("🛠 수정 후 즉시 fetchNotes 실행 (userId: $userId)");
        await ref.read(noteListViewModelProvider.notifier).fetchNotes(userId);
      }
    } else {
      logger.e(
          "🐛 노트 수정 실패 (서버 응답 오류): ${result['errorMessage'] ?? '알 수 없는 오류'}");
    }
  }

// 노트 삭제 함수
  Future<void> deleteNote(WidgetRef ref, int noteId) async {
    final repository = ref.read(noteRepositoryProvider);
    try {
      final result = await repository.delete(id: noteId);
      if (result == null || !result['success']) {
        logger.e("노트 삭제 실패: ${result?['errorMessage'] ?? '알 수 없는 오류'}");
        return;
      }

      logger.d("노트 삭제 성공");
      ref.invalidate(noteDetailViewModelProvider(noteId));
      ref.invalidate(noteListViewModelProvider);
    } catch (e) {
      logger.e("노트 삭제 실패 (예외 발생): $e");
      rethrow;
    }
  }
}
