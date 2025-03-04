import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import '../../../providers/session_user_provider.dart';
import '../../model/note_model.dart';
import '../../repository/note_repository.dart';
import '../user_view_model/session_view_model.dart';
import 'note_view_model.dart';

final logger = Logger();

// 노트 목록 ViewModel Provider
final noteListViewModelProvider =
    StateNotifierProvider<NoteListViewModel, List<Note>>(
  (ref) => NoteListViewModel(ref.watch(noteRepositoryProvider)),
);

// 선택된 노트 Provider
final selectedNoteProvider = StateProvider<Note?>((ref) => null);

// 날짜 비교 함수
int _compareDates(Note a, Note b, bool isLatestFirst) {
  try {
    DateTime dateA = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(a.createdAt);
    DateTime dateB = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(b.createdAt);
    return isLatestFirst ? dateB.compareTo(dateA) : dateA.compareTo(dateB);
  } catch (e) {
    return 0;
  }
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
      logger.w("fetchNotes 실행 안 함: ViewModel이 dispose됨");
      return;
    }

    if (userId == 0) {
      logger.w("유효하지 않은 유저 ID (로그인 필요)");
      state = [];
      return;
    }

    if (state.isNotEmpty && state.first.userId == userId) {
      logger.w("fetchNotes 중복 실행 방지됨 (userId: $userId)");
      return;
    }
    logger.d("fetchNotes 실행됨 (userId: $userId)");

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
        logger.d("상태 업데이트 완료! 노트 개수: ${state.length}");
      }
    } catch (e, stackTrace) {
      logger.e("노트 목록 불러오기 실패: $e", error: e, stackTrace: stackTrace);
    }
  }

  // 최신순/오래된순 정렬 함수 (isLatestFirst 매개변수 추가)
  List<Note> _sortedNotes(List<Note> notes, bool isLatestFirst) {
    List<Note> sortedList = List.from(notes);
    sortedList.sort((a, b) => _compareDates(a, b, isLatestFirst));
    return sortedList;
  }
}

void fetchNotesOnce(WidgetRef ref, int userId, bool isFetching) {
  if (isFetching) return; // 중복 실행 방지

  final sessionUser = ref.read(sessionProvider);
  if (sessionUser.id == null) {
    print("유저 정보 없음! fetchNotes 실행 안 함");
    return;
  }

  ref.read(noteListViewModelProvider.notifier).fetchNotes(userId);
}
