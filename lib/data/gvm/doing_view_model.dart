import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../model/book.dart';
import '../model/book_record_doing.dart';

class DoingViewModel extends Notifier<List<BookRecordDoing>> {
  @override
  List<BookRecordDoing> build() {
    return doingBookList;
  }

  // 비즈니스 로직
  void addList(String title, int userId, DateTime startDate, Book book,
      int currentPage, String comment, int recordId) {
    // state.add <-- 원래 사용하고 있는 객체에 접근해서 추가했더니
    // 위젯 변경이 안 됨 but 새로운 객체를 만들어 할당하니 위젯 변경이 일어남
    state = [
      ...state,
      BookRecordDoing(
          userId: userId,
          startDate: startDate,
          book: book,
          currentPage: currentPage,
          comment: comment,
          recordId: recordId)
    ];
  }

  String formatSingleDate(BookRecordDoing doing) {
    final dateFormatter = DateFormat('yyyy년 MM월 dd일');
    return dateFormatter.format(doing.startDate);
  }

  String ceilProgressPages(BookRecordDoing doing) {
    return ((doing.currentPage / doing.book.book_page) * 100)
        .toStringAsFixed(1);
  }

  double progressPages(BookRecordDoing doing) {
    return (doing.currentPage / doing.book.book_page) * 100;
    ;
  }
}

// 창고 관리자
final DoingViewModelProvider =
    NotifierProvider<DoingViewModel, List<BookRecordDoing>>(
  () {
    return DoingViewModel();
  },
);
