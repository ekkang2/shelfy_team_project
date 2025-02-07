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
