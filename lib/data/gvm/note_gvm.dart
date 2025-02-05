import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/note_model.dart';
import '../repository/note_repository.dart';

/*
     날짜 : 2025/02/05
     이름 : 박경림
     내용 : ViewModel 분리 - 노트 작성 상태 관리 및 비즈니스 로직 처리
*/
// 상태 관리 Provider 정의
final noteViewModelProvider =
    StateNotifierProvider<NoteViewModel, AsyncValue<void>>((ref) {
  return NoteViewModel(ref.read(noteRepositoryProvider));
});

final noteRepositoryProvider = Provider((ref) => NoteRepository());

// 노트 작성 상태 관리 및 비즈니스 로직 처리
class NoteViewModel extends StateNotifier<AsyncValue<void>> {
  final NoteRepository _repository;

  NoteViewModel(this._repository) : super(const AsyncData(null));

  // 노트 작성 API 호출
  Future<void> submitNote(Note note) async {
    state = const AsyncLoading(); // 로딩 상태
    try {
      await _repository.submitNote(note);
      state = const AsyncData(null); // 성공 시 상태 초기화
    } catch (e, stack) {
      state = AsyncError(e, stack); // 에러 상태 저장
    }
  }
}
