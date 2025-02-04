import 'package:dio/dio.dart';
import 'package:shelfy_team_project/_core/utils/logger.dart';
import 'package:shelfy_team_project/_core/utils/m_http.dart';

class UserRepository {
  // 생성자
  const UserRepository();

  // 로그인 기능
  Future<(Map<String, dynamic>, String)> findByUidAndPassword(
      Map<String, dynamic> reqData) async {
    // 받은 reqData를 서버로 post 요청과 함께 보냄
    Response response = await dio.post('/login', data: reqData);
    // HTTP 응답 메시지 header의 토큰 추출
    String accessToken = response.headers['Authorization']?[0] ?? '';
    // HTTP 응답 메시지의 body 추출
    Map<String, dynamic> responseBody = response.data;
    logger.d(accessToken);
    logger.i(responseBody);

    return (responseBody, accessToken);
  }

  // 회원가입 기능
  Future<Map<String, dynamic>> insertUser(Map<String, dynamic> reqData) async {
    Response response = await dio.post('/join', data: reqData);
    return response.data;
  }

// 로그아웃 기능

// 자동 로그인 기능

// 소셜 로그인 기능
}
