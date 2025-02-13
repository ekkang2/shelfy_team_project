import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shelfy_team_project/_core/utils/logger.dart';
import 'package:shelfy_team_project/data/repository/record_repository.dart';

import '../../../_core/utils/exception_handler.dart';
import '../../../main.dart';
import '../../model/record_model/record_list.dart';

class RecordTypeListViewModel extends AutoDisposeNotifier<RecordList?> {
  final refreshController = RefreshController();
  final mContext = navigatorkey.currentContext!;
  final RecordRepository recordRepository = const RecordRepository();

  @override
  RecordList? build() {
    init();
    return null;
  }

  // 목록 초기화
  Future<void> init() async {
    try {
      //todo type이랑 page번호 받아와야 함
      Map<String, dynamic> resBody =
          await recordRepository.findAllByType(type: 1);
      if (!resBody['success']) {
        ExceptionHandler.handleException(
            resBody['errorMessage'], StackTrace.current);
        return;
      }
      logger.d('레코드 리스트 init() ${resBody['response']['contents']}');
      // 상태 업데이트
      state = RecordList.fromMap(resBody['response']);
    } catch (e, stackTrace) {
      ExceptionHandler.handleException('게시글 목록 로딩 중 오류', stackTrace);
    }
  }

  // 페이징 처리 (다음 게시글 목록 불러오기)
  Future<void> nextList() async {
    if (state == null) return;

    if (state!.isLast) {
      await Future.delayed(Duration(milliseconds: 500));
      return;
    }
    //todo 타입 받아와
    Map<String, dynamic> responseBody = await recordRepository.findAllByType(
        page: state!.pageNumber + 1, type: 1);

    if (!responseBody['success']) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text('게시글을 못 불러 왔어요')),
      );
      return;
    }

    RecordList prevModel = state!;
    RecordList nextModel = RecordList.fromMap(responseBody['response']);
    state = nextModel
        .copyWith(records: [...prevModel.records, ...nextModel.records]);
  }
}

final recordListTypeProvider =
    NotifierProvider.autoDispose<RecordTypeListViewModel, RecordList?>(
  () => RecordTypeListViewModel(),
);
