import 'package:dio/dio.dart';
import '../model/note_model.dart';

/*
  생성일 : 2025/02/05
  작성자 : 박경림
  내용 : 노트 repository 추가 - API 요청 처리
 */
class NoteRepository {
  final Dio _dio = Dio();

  Future<void> submitNote(Note note) async {
    try {
      final response = await _dio.post(
        'http://10.0.2.2:8082/api/note',
        data: note.toJson(), // ✅ Note 모델의 toJson() 호출
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('노트 저장 실패: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('노트 저장 중 에러 발생: $e');
    }
  }
}
