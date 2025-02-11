import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/_core/utils/exception_handler.dart';
import 'package:shelfy_team_project/_core/utils/logger.dart';
import 'package:shelfy_team_project/data/model/book_model/book.dart';
import 'package:shelfy_team_project/data/repository/book_repository.dart';
import 'package:shelfy_team_project/main.dart';

/**
 * 2025/02/05 강은경
 * book view model 생성
 */

class BookVM extends Notifier<List<Book>> {
  // view-model 에서 context에 접근하기 위한 navigatorKey 사용
  final mContext = navigatorkey.currentContext!;

  BookRepository bookRepository = BookRepository();

  @override
  List<Book> build() {
    return []; // 초기 상태로 빈 리스트 설정
  }

  /**
   * 2025/02/05 강은경
   * 책 검색 뷰 모델
   */
  Future<void> searchBooks(
    String query,
  ) async {
    try {
      logger.d("검색어 :" + query);
      Map<String, dynamic> resBody =
          await bookRepository.searchBooks(query: query);
      logger.d("서버와 통신한 결과 :" + resBody['response'].toString());

      // 통신은 성공했지만 내부 판별 오류 시 방어적 코드 작성
      if (!resBody['success']) {
        ExceptionHandler.handleException(
            resBody['errorMessage'], StackTrace.current);

        state = []; // 오류 발생 시 빈 리스트로 상태 업데이트
        return; // 메서드 종료
      }

      // JSON 데이터를 Book 객체 리스트로 변환
      List<Book> books = (resBody['response'] as List)
          .map((bookJson) => Book.fromJson(bookJson))
          .toList();

      state = books; // 검색 결과를 상태로 업데이트
    } catch (e, stackTrace) {
      ExceptionHandler.handleException('서버 연결 실패', stackTrace);
      state = []; // 예외 발생 시 빈 리스트로 상태 업데이트
    }
  }

  /**
   * 2025/02/10 강은경
   * 책 검색 더보기 뷰 모델
   */
  Future<void> searchBooksMore(
    String query,
  ) async {
    try {ㄷ
      logger.d("더보기 검색어 :" + query);
      Map<String, dynamic> resBody =
          await bookRepository.searchBooksMore(query: query);
      logger.d("검색어 더보기 서버와 통신한 결과 :" + resBody['response'].toString());

      // 통신은 성공했지만 내부 판별 오류 시 방어적 코드 작성
      if (!resBody['success']) {
        ExceptionHandler.handleException(
            resBody['errorMessage'], StackTrace.current);

        state = []; // 오류 발생 시 빈 리스트로 상태 업데이트
        return; // 메서드 종료
      }

      // JSON 데이터를 Book 객체 리스트로 변환
      List<Book> books = (resBody['response'] as List)
          .map((bookJson) => Book.fromJson(bookJson))
          .toList();

      state = books; // 검색 결과를 상태로 업데이트
    } catch (e, stackTrace) {
      ExceptionHandler.handleException('서버 연결 실패', stackTrace);
      state = []; // 예외 발생 시 빈 리스트로 상태 업데이트
    }
  }
}

// 창고 관리자 선언
final bookProvider = NotifierProvider<BookVM, List<Book>>(
  () => BookVM(),
);
