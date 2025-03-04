import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../_core/utils/m_http.dart';

/*
  생성일 : 2025/02/06
  작성자 : 박경림
  내용 : 노트 repository 추가 - API 요청 처리
 */
final logger = Logger();

class NoteRepository {
  const NoteRepository();

  // 테스트 중 특정 유저의 노트 목록 조회 (기본 userId=1)
  Future<Map<String, dynamic>> findAllByUser({int userId = 1}) async {
    try {
      logger.d("API 호출: findAllByUser, userId: $userId");
      Response response = await dio.get('/api/note/user/$userId');
      logger.d("API 응답: ${response.toString()}");
      return response.data;
    } catch (e) {
      print("🚨 findAllByUser 실패: $e");
      return {}; //  실패 시 빈 맵 반환
    }
  }

  //  특정 노트 상세 조회
  Future<Map<String, dynamic>> findById({required int id}) async {
    try {
      Response response = await dio.get('/api/note/$id');
      return response.data;
    } catch (e) {
      print("🚨 findById 실패: $e");
      return {};
    }
  }

  //  특정 노트 삭제
  Future<Map<String, dynamic>> delete({required int id}) async {
    try {
      Response response = await dio.delete('/api/note/$id');
      return response.data;
    } catch (e) {
      print("🚨 delete 실패: $e");
      return {};
    }
  }

  //  노트 생성 (save 함수 추가)
  Future<Map<String, dynamic>> save(Map<String, dynamic> reqData) async {
    try {
      Response response = await dio.post('/api/note', data: reqData);
      return response.data;
    } catch (e) {
      return {};
    }
  }

  //  노트 수정
  Future<Map<String, dynamic>> update(
      int id, Map<String, dynamic> reqData) async {
    try {
      logger.d("PATCH 요청: /api/note/$id, 데이터: $reqData"); //  요청 확인
      Response response =
          await dio.patch('/api/note/$id', data: reqData); //  PATCH 요청으로 변경
      logger.d(" 응답 데이터: ${response.data}"); //  응답 로그
      return response.data;
    } catch (e) {
      logger.e("update API 호출 실패: $e");
      return {"success": false, "errorMessage": e.toString()};
    }
  }

  //  특정 노트의 북마크 상태 업데이트
  Future<void> updateNotePin(int noteId, bool notePin) async {
    try {
      await dio.patch('/api/note/$noteId/pin',
          queryParameters: {"notePin": notePin});
    } catch (e) {
      throw Exception("북마크 업데이트 실패");
    }
  }
}
