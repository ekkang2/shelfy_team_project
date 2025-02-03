// API 서버의 기본 URL 설정
// 전역 변수 사용
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final baseUrl = 'http://192.168.0.115:8080';

// 전역 변수 dio <--
final dio = Dio(
  BaseOptions(
    baseUrl: baseUrl,
    contentType: 'application/json;charset=UTF-8',
    // 주의! 응답 상태 200 이외에는 모두 에러로 간주하도록 기본적으로 설정되어 있음
    // 다른 상태 코드 모두 허용 ( 201, 202 등 )
    validateStatus: (status) => true,
  ),
);

// 중요 데이터 보관소 ( 금고 생성 )
// 로컬에 민감한 데이터를 보관하는 안전한 금고 역할을 한다.
const secureStorage = FlutterSecureStorage();
