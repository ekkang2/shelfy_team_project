import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/note_model.dart';
import '../repository/note_repository.dart';

/*
     날짜 : 2025/02/05
     이름 : 박경림
     내용 : ViewModel 분리 - 노트 작성 상태 관리 및 비즈니스 로직 처리
*/

// Repository Provider 정의 (먼저 정의)
final noteRepositoryProvider = Provider((ref) => NoteRepository());

// 상태 관리 Provider 정의
final noteViewModelProvider =
    StateNotifierProvider<NoteViewModel, AsyncValue<void>>((ref) {
  return NoteViewModel(ref.read(noteRepositoryProvider));
});

// 노트 작성 상태 관리 및 비즈니스 로직 처리
class NoteViewModel extends StateNotifier<AsyncValue<void>> {
  final NoteRepository _repository;

  NoteViewModel(this._repository) : super(const AsyncData(null));

  // 노트 작성 API 호출
  Future<void> submitNote(Note note) async {
    state = const AsyncLoading(); // 로딩 상태
    try {
      // 리포지터리의 save 메서드 호출 및 응답 처리
      final result = await _repository.save(note.toJson());
      print('노트 저장 성공: $result'); // 서버 응답 출력

      state = const AsyncData(null); // 성공 시 상태 초기화
    } catch (e, stack) {
      print('노트 저장 실패: $e'); // 에러 로그 추가
      state = AsyncError(e, stack); // 에러 상태 저장
      rethrow; // 에러를 상위로 다시 던짐
    }
  }
}
