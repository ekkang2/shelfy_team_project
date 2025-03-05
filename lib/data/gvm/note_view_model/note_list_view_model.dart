import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import '../../model/note_model.dart';
import '../../repository/note_repository.dart';
import 'note_view_model.dart';

final logger = Logger(
  level: Level.debug, // 디버그 레벨로 설정되어 있는지 확인
);

// 노트 목록 ViewModel Provider
final noteListViewModelProvider =
    StateNotifierProvider<NoteListViewModel, List<Note>>(
  (ref) => NoteListViewModel(ref.watch(noteRepositoryProvider)),
);

// 선택된 노트 Provider
final selectedNoteProvider = StateProvider<Note?>((ref) => null);

// 날짜 비교 함수: updatedAt 또는 createdAt 기준 최신순 정렬
int _compareDates(Note a, Note b, bool isLatestFirst) {
  try {
    // 최신 날짜를 가져옴 (수정 날짜가 있으면 그것을, 없으면 작성 날짜를 사용)
    DateTime dateA = _getLatestDate(a);
    DateTime dateB = _getLatestDate(b);

    // 날짜만 비교
    int dateComparison = DateFormat("yyyy-MM-dd")
        .format(dateB)
        .compareTo(DateFormat("yyyy-MM-dd").format(dateA));

    if (dateComparison == 0) {
      // 같은 날짜라면 시간 비교
      dateComparison = dateB.compareTo(dateA);
    }

    return isLatestFirst ? dateComparison : -dateComparison;
  } catch (e) {
    print("날짜 비교 오류: $e");
    return 0;
  }
}

// 노트의 최신 날짜를 가져오는 함수 (시간까지 포함)
DateTime _getLatestDate(Note note) {
  String? latestDate = note.updatedAt != null && note.updatedAt!.isNotEmpty
      ? note.updatedAt
      : note.createdAt;

  return DateFormat("yyyy-MM-ddTHH:mm:ss").parse(latestDate!);
}

// 노트 목록을 관리하는 ViewModel
class NoteListViewModel extends StateNotifier<List<Note>> {
  final NoteRepository _repository;
  bool isLatestFirst = true; // 정렬 순서 상태 추가

  NoteListViewModel(this._repository) : super([]);

  // 정렬 방식 변경 (최신순 ↔ 오래된순)
  void toggleSortOrder() {
    isLatestFirst = !isLatestFirst;

    // 새로운 리스트로 바꿔 UI 갱신 유도
    state = List.from(_sortedNotes(state, isLatestFirst));
  }

  Future<void> fetchNotes(int userId) async {
    if (!mounted) {
      return;
    }

    if (userId == 0) {
      state = [];
      return;
    }

    try {
      final response = await _repository.findAllByUser(userId: userId);

      if (response == null || response['response'] == null) {
        state = [];
        return;
      }

      final List<Map<String, dynamic>> jsonList =
          List<Map<String, dynamic>>.from(response['response']);
      List<Note> notes = jsonList.map((json) => Note.fromJson(json)).toList();

      if (mounted) {
        state = List.from(_sortedNotes(notes, isLatestFirst));
        // UI 강제 업데이트
        state = [...state]; // 새로운 리스트로 할당하여 강제 리렌더링 유도
      }
    } catch (e, stackTrace) {}
  }

  // 최신순/오래된순 정렬 함수 (isLatestFirst 매개변수 추가)
  List<Note> _sortedNotes(List<Note> notes, bool isLatestFirst) {
    List<Note> sortedList = List.from(notes);
    sortedList.sort((a, b) => _compareDates(a, b, isLatestFirst));
    return sortedList;
  }
}
