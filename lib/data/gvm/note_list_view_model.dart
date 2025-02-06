import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../_core/utils/m_http.dart';
import '../model/note_model.dart';

import '../../ui/pages/note/note_page/widget/note_item.dart';
import '../repository/note_repository.dart';
import 'note_view_model.dart';

final noteListViewModelProvider =
    StateNotifierProvider<NoteListViewModel, List<Note>>(
  (ref) => NoteListViewModel(ref.watch(noteRepositoryProvider)),
);

class NoteListViewModel extends StateNotifier<List<Note>> {
  final NoteRepository _repository;

  NoteListViewModel(this._repository) : super([]);

  // ✅ 노트 목록 불러오기
  Future<void> fetchNotes(int userId) async {
    try {
      final response = await dio.get('/api/note/user/$userId'); // ✅ API 호출
      print("📌 API 응답 데이터: ${response.data}"); // ✅ 응답 데이터 확인

      // ✅ `response.data`를 직접 JSON으로 변환 후 접근
      final List<Map<String, dynamic>> jsonList =
          response.data['response'] != null
              ? List<Map<String, dynamic>>.from(response.data['response'])
              : [];

      final notes = jsonList.map((json) => Note.fromJson(json)).toList();
      state = notes; // ✅ 상태 업데이트
    } catch (e, stackTrace) {
      print("노트 목록 불러오기 실패: $e");
    }
  }
}
