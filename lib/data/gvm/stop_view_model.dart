import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shelfy_team_project/data/model/book_record_stop.dart';

import '../model/book.dart';

class StopViewModel extends Notifier<List<BookRecordStop>> {
  @override
  List<BookRecordStop> build() {
    return stopBookList;
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
      BookRecordStop(
          userId: userId,
          startDate: startDate,
          book: book,
          comment: comment,
          recordId: recordId,
          rating: rating,
          endDate: endDate)
    ];
  }

  String formatSingleDate(DateTime time) {
    final dateFormatter = DateFormat('yyyy.MM.dd');
    return dateFormatter.format(time);
  }
}

// 창고 관리자
final stopViewModelProvider =
    NotifierProvider<StopViewModel, List<BookRecordStop>>(
  () {
    return StopViewModel();
  },
);
