import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/book.dart';
import '../model/book_record_done.dart';

class DoneViewModel extends Notifier<List<BookRecordDone>> {
  @override
  List<BookRecordDone> build() {
    return doneBookList;
  }

  // 비즈니스 로직
  void addList(
      String title,
      int userId,
      DateTime startDate,
      Book book,
      int currentPage,
      String comment,
      int recordId,
      DateTime endDate,
      double rating) {
    // state.add <-- 원래 사용하고 있는 객체에 접근해서 추가했더니
    // 위젯 변경이 안 됨 but 새로운 객체를 만들어 할당하니 위젯 변경이 일어남
    state = [
      ...state,
      BookRecordDone(
          userId: userId,
          startDate: startDate,
          book: book,
          comment: comment,
          recordId: recordId,
          endDate: endDate,
          rating: rating)
    ];
  }
}

// 창고 관리자
final DoneViewModelProvider =
    NotifierProvider<DoneViewModel, List<BookRecordDone>>(
  () {
    return DoneViewModel();
  },
);
