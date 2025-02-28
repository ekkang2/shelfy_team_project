import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../_core/utils/exception_handler.dart';
import '../../../_core/utils/logger.dart';
import '../../../main.dart';
import '../../model/record_model/record_response_model.dart';
import '../../repository/record_repository.dart';

class RecordListViewModel extends Notifier<List<RecordResponseModel>> {
  final refreshController = RefreshController();
  final mContext = navigatorkey.currentContext!;
  final RecordRepository recordRepository = const RecordRepository();

  @override
  List<RecordResponseModel> build() {
    init();
    return [];
  }

  Future<void> init() async {
    try {
      Map<String, dynamic> responseBody = await recordRepository.findAll();

      if (!responseBody['success']) {
        ExceptionHandler.handleException(
            responseBody['errorMessage'], StackTrace.current);
        return;
      }

      logger.d('init() 호출해서 데이터 가꾸옴 !! ${responseBody['response']}');
      state = (responseBody['response'] as List)
          .map((e) => RecordResponseModel.fromMap(e))
          .toList();
      logger.d('여기 찍히나?');
    } catch (e, stackTrace) {
      ExceptionHandler.handleException('독서 기록 로딩 오류', stackTrace);
    }
  }

  // 페이징 처리 (다음 게시글 목록 불러오기)
  Future<void> nextList() async {}
}

final recordListProvider =
    NotifierProvider<RecordListViewModel, List<RecordResponseModel>>(
  () => RecordListViewModel(),
);
