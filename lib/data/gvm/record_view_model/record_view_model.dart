import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/_core/utils/exception_handler.dart';
import 'package:shelfy_team_project/_core/utils/logger.dart';
import 'package:shelfy_team_project/data/repository/record_repository.dart';
import 'package:shelfy_team_project/main.dart';
import 'package:shelfy_team_project/ui/widgets/common_snackbar.dart';

import '../../../ui/pages/main_screen.dart';
import '../../model/record_model/record_.dart';

class RecordViewModel extends Notifier<Record> {
  //  사용 선언
  final mContext = navigatorkey.currentContext!;
  RecordRepository recordRepository = const RecordRepository();

  //  상태값 초기화
  @override
  Record build() {
    return Record(
        stateId: null,
        bookId: null,
        userId: null,
        stateType: null,
        startDate: null,
        endDate: null,
        comment: null,
        progress: null,
        rating: null,
        isWriteCompleted: false);
  }

  /**
   * 독서기록 생성
   * 0. 뷰모델에서 예외 처리
   * 1. 데이터 map 구조로 변환
   * 2. 응답 -> success -- false
   */
  Future<void> createRecord({
    required String bookId,
    required int stateType,
    DateTime? startDate,
    DateTime? endDate,
    String? comment,
    double? rating,
    int? progress,
  }) async {
    try {
      final body = {
        "bookId": bookId,
        "stateType": stateType,
        "startDate": startDate?.toIso8601String(), // ✅ 문자열 변환
        "endDate": endDate?.toIso8601String(), // ✅ null 체크 후 변환
        "comment": comment,
        "rating": rating,
        "progress": progress,
      };
      logger.d('보낼 데이터 $body');

      Map<String, dynamic> responseBody = await recordRepository.save(body);
      logger.d('응답 데이터 $responseBody');

      if (!responseBody['success']) {
        ScaffoldMessenger.of(mContext)
            .showSnackBar(SnackBar(content: Text("기록 추가 실패")));

        ExceptionHandler.handleException(
            responseBody['errorMessage'], StackTrace.current);
        return;
      }

      FocusScope.of(mContext).unfocus();
      CommonSnackbar.show(mContext, "기록이 추가되었어요!");
      state = Record(
        stateId: null,
        bookId: null,
        userId: null,
        stateType: null,
        startDate: null,
        endDate: null,
        comment: null,
        progress: null,
        rating: null,
        isWriteCompleted: false,
      );

      Navigator.pushAndRemoveUntil(
        mContext,
        MaterialPageRoute(builder: (context) => MainScreen(initialIndex: 2)),
        (route) => false, // 기존 스택 제거
      );

      //
    } catch (e, stackTrace) {
      ExceptionHandler.handleException(e, stackTrace);
    }
  }
}

// 창고관리자
final recordViewModelProvider = NotifierProvider<RecordViewModel, Record>(
  () => RecordViewModel(),
);
