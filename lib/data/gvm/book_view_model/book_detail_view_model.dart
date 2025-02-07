import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/_core/utils/exception_handler.dart';
import 'package:shelfy_team_project/_core/utils/logger.dart';
import 'package:shelfy_team_project/data/model/book_model/book.dart';
import 'package:shelfy_team_project/data/repository/book_repository.dart';
import 'package:shelfy_team_project/main.dart';

/**
 * 2025/02/07 강은경
 * book detail view model 생성
 */

class BookDetailVM extends Notifier<Book> {
  // view-model 에서 context에 접근하기 위한 navigatorKey 사용
  final mContext = navigatorkey.currentContext!;
  BookRepository bookRepository = BookRepository();

  @override
  Book build() {
    return Book(
        bookId: null,
        bookImage: null,
        bookTitle: null,
        bookDesc: null,
        bookAuthor: null,
        bookPublisher: null,
        bookIsbn: null,
        bookPage: null,
        bookPublishedAt: null);
  }

  /**
   * 2025/02/07 강은경
   * 책 상세보기 뷰 모델
   */
  Future<void> selectBookDetail(
    String bookIsbn,
  ) async {
    try {
      logger.d("bookIsbn :" + bookIsbn);
      Map<String, dynamic> resBody = await bookRepository
          .selectBookDetailAndBookPageUpdate(bookIsbn: bookIsbn);
      logger.d("서버와 통신한 결과 : " + resBody['response'].toString());

      // 통신은 성공했지만 내부 판별 오류 시 방어적 코드 작성
      if (!resBody['success']) {
        ExceptionHandler.handleException(
            resBody['errorMessage'], StackTrace.current);
        state = Book(
            bookId: null,
            bookImage: null,
            bookTitle: null,
            bookDesc: null,
            bookAuthor: null,
            bookPublisher: null,
            bookIsbn: null,
            bookPage: null,
            bookPublishedAt: null); // 오류 발생 시 빈 Book 객체 유지
        return; // 메서드 종료
      }

      // API 응답 데이터를 Book 모델로 변환
      Book book = Book.fromJson(resBody['response']);

      // 상태 업데이트 (뷰에서 감지)
      state = book;
    } catch (e, stackTrace) {
      ExceptionHandler.handleException('서버 연결 실패', stackTrace);
    }
  }
}

// 창고 관리자 선언
final bookDetailProvider = NotifierProvider<BookDetailVM, Book>(
  () => BookDetailVM(),
);
