import 'package:dio/dio.dart';

import '../../_core/utils/m_http.dart';

/*
  생성일 : 2025/02/05
  작성자 : 박경림
  내용 : 노트 repository 추가 - API 요청 처리
 */
class NoteRepository {
  const NoteRepository();

  Future<Map<String, dynamic>> save(Map<String, dynamic> reqData) async {
    Response response =
        await dio.post('http://10.0.2.2:8082/api/note', data: reqData);
    return response.data; // 서버 응답 반환
  }
}
