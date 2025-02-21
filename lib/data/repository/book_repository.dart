import 'package:dio/dio.dart';
import 'package:shelfy_team_project/_core/utils/logger.dart';
import 'package:shelfy_team_project/_core/utils/m_http.dart';

class BookRepository {
  // 생성자
  const BookRepository();

  // 책 검색
  Future<Map<String, dynamic>> searchBooks({required String query}) async {
    Response response =
        await dio.get('/api/book/search', queryParameters: {'query': query});

    Map<String, dynamic> responseBody = response.data;
    return responseBody;
  }

  // 책 상세보기 진입시 페이지 수 update
  Future<Map<String, dynamic>> selectBookDetailAndBookPageUpdate(
      {required String bookIsbn}) async {
    Response response = await dio.get('/api/book/detail/$bookIsbn');

    Map<String, dynamic> responseBody = response.data;
    return responseBody;
  }

  // 책 검색 더보기
  Future<Map<String, dynamic>> searchBooksMore({required String query}) async {
    Response response = await dio
        .get('/api/book/search/more', queryParameters: {'query': query});

    Map<String, dynamic> responseBody = response.data;
    return responseBody;
  }

  // 책 등록
  Future<Map<String, dynamic>> save(Map<String, dynamic> reqData) async {
    Response response = await dio.post('/api/my/book/save', data: reqData);

    Map<String, dynamic> responseBody = response.data;
    return responseBody;
  }
}
