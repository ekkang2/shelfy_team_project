import 'package:dio/dio.dart';
import '../../_core/utils/m_http.dart';

/*
  2025/02/05 박연화
  독서기록
 */
class RecordRepository {
  const RecordRepository();

  // 250205 박연화 독서기록 생성 api 요청
  Future<Map<String, dynamic>> save(Map<String, dynamic> reqData) async {
    Response response = await dio.post('/api/record', data: reqData);
    Map<String, dynamic> responseBody = response.data;
    return responseBody;
  }
}
