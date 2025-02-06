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
}
