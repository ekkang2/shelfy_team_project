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

  // ✅ 테스트 중 특정 유저의 노트 목록 조회 (기본 userId=1)
  Future<Map<String, dynamic>> findAllByUser({int userId = 1}) async {
    // ✅ userId 추가
    try {
      Response response = await dio.get('/api/note/user/$userId');
      return response.data;
    } catch (e) {
      print("🚨 findAllByUser 실패: $e");
      return {}; // ✅ 실패 시 빈 맵 반환
    }
  }

  // ✅ 특정 노트 상세 조회
  Future<Map<String, dynamic>> findById({required int id}) async {
    try {
      Response response = await dio.get('/api/note/$id');
      return response.data;
    } catch (e) {
      print("🚨 findById 실패: $e");
      return {};
    }
  }

  // ✅ 특정 노트 삭제
  Future<Map<String, dynamic>> delete({required int id}) async {
    try {
      Response response = await dio.delete('/api/note/$id');
      return response.data;
    } catch (e) {
      print("🚨 delete 실패: $e");
      return {};
    }
  }

  // ✅ 노트 생성 (save 함수 추가)
  Future<Map<String, dynamic>> save(Map<String, dynamic> reqData) async {
    try {
      Response response = await dio.post('/api/note', data: reqData);
      return response.data;
    } catch (e) {
      return {};
    }
  }

  // ✅ 노트 수정
  Future<Map<String, dynamic>> update(
      int id, Map<String, dynamic> reqData) async {
    try {
      Response response = await dio.put('/api/note/$id', data: reqData);
      return response.data;
    } catch (e) {
      print("🚨 update 실패: $e");
      return {};
    }
  }
}
