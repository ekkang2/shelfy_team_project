// 1. 책 이벤트의 정의

import 'package:flutter_riverpod/flutter_riverpod.dart';

enum BookAction {
  none, // 아무런 이벤트도 발생하지 않음
  created, // 게시글 생성 이벤트 정의
}

// 2. 이벤트 노티파이어 생성
class BookEventNotifier extends Notifier<BookAction> {
  @override
  BookAction build() {
    return BookAction.none;
  }

  // 행위 설계
  void bookCreate() {
    state = BookAction.created;
  }

  // 이벤트 처리 후 상태를 초기화 하는 코드(중복 이벤트 방지)
  void reset() => state = BookAction.none;
}

// 3. 이벤트 프로바이더 생성
final bookEventProvider = NotifierProvider<BookEventNotifier, BookAction>(
  () {
    return BookEventNotifier();
  },
);
