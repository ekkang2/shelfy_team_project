import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/_core/utils/exception_handler.dart';
import 'package:shelfy_team_project/data/gvm/book_view_model/book_event_notifier.dart';
import 'package:shelfy_team_project/data/repository/book_repository.dart';
import 'package:shelfy_team_project/main.dart';

class BookWriteViewModel extends Notifier<
    (
      String? myBookTitle,
      String? myBookAuthor,
      String? myBookPublisher,
      String? myBookIsbn,
      String? myBookPage,
    )> {
  // 뷰 모델에서 컨텍스트를 사용하는 ㄴ방안
  final mContext = navigatorkey.currentContext!;
  BookRepository bookRepository = const BookRepository();

  // 상태값을 초기화
  @override
  (
    String? myBookTitle,
    String? myBookAuthor,
    String? myBookPublisher,
    String? myBookIsbn,
    String? myBookPage,
  ) build() {
    return (null, null, null, null, null);
  }

  // 행위 - 책 등록
  // 0. 뷰모델에서 예외처리
  // 1. 데이터 Map 구조로 변환 처리
  // 2. 응답 --> success -- false
  // 3. 응답 --> success -- true
  Future<void> createBook({
    required String myBookTitle,
    required String myBookAuthor,
    required String myBookPublisher,
    required String myBookIsbn,
    required String myBookPage,
  }) async {
    try {
      // 데이터 가공 처리
      final body = {
        "myBookTitle": myBookTitle,
        "myBookAuthor": myBookAuthor,
        "myBookPublisher": myBookPublisher,
        "myBookIsbn": myBookIsbn,
        "myBookPage": myBookPage,
      };

      Map<String, dynamic> resBody = await bookRepository.save(body);

      // 2
      if (!resBody['success']) {
        ExceptionHandler.handleException(
            resBody['errorMessage'], StackTrace.current);
        return;
      }

      // 시스템 키보드가 있다면 자동 닫기
      FocusScope.of(mContext).unfocus();

      // 게시글 오나성 메세지
      ScaffoldMessenger.of(mContext)
          .showSnackBar(SnackBar(content: Text('책 등록 완료')));

      // 상태 갱신 처리
      state = (null, null, null, null, null);

      ref.read(bookEventProvider.notifier).bookCreate();
    } catch (e, stackTrace) {
      ExceptionHandler.handleException('책 등록시 오류 발생', stackTrace);
    }
  }
}

// 창고 관리자 만들기
final bookWriteViewModelProvider = NotifierProvider<
    BookWriteViewModel,
    (
      String? myBookTitle,
      String? myBookAuthor,
      String? myBookPublisher,
      String? myBookIsbn,
      String? myBookPage,
    )>(() => BookWriteViewModel());
