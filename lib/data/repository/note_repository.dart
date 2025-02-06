import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../_core/utils/m_http.dart';

/*
  생성일 : 2025/02/06
  작성자 : 박경림
  내용 : 노트 repository 추가 - API 요청 처리
 */
class NoteRepository {
  const NoteRepository();

  // 노트 목록 조회
  // 페이지네이션 없음 나중에 추가 가능
  // - return : 서버로부터 받은 노트 목록 (Map 형태)
  Future<Map<String, dynamic>> findAll() async {
    Response response = await dio.get('/api/note');
    Map<String, dynamic> responseBody = response.data;
    return responseBody;
  }

  // 특정 노트 상세 조회
  Future<Map<String, dynamic>> findById({required int id}) async {
    Response response = await dio.get('/api/note/$id');
    Map<String, dynamic> responseBody = response.data;
    return responseBody;
  }

  // 특정 노트 삭제
  Future<Map<String, dynamic>> delete({required int id}) async {
    Response response = await dio.delete('/api/note/$id');
    Map<String, dynamic> responseBody = response.data;
    return responseBody;
  }

  // 노트 생성
  Future<Map<String, dynamic>> save(Map<String, dynamic> reqData) async {
    Response response = await dio.post('/api/note', data: reqData);
    Map<String, dynamic> responseBody = response.data;
    return responseBody;
  }

  // 노트 수정
  Future<Map<String, dynamic>> update(
      int id, Map<String, dynamic> reqData) async {
    Response response = await dio.put('/api/note/$id', data: reqData);
    Map<String, dynamic> responseBody = response.data;
    return responseBody;
  }
}
