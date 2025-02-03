import 'package:flutter/material.dart';

import '../../main.dart';
import 'logger.dart';

class ExceptionHandler {
  static void handleException(dynamic exception, StackTrace stackTrace) {
    logger.e('Exception : $exception');
    logger.e('StackTrace : $stackTrace');

    // 간혹 비동기 작업 시 currentContext 가 사라질 수도 있다.
    final mContext = navigatorkey.currentContext;
    if (mContext == null) return;

    // 시스템 키보드가 있다면 내려주자
    FocusScope.of(mContext).unfocus();

    ScaffoldMessenger.of(mContext).showSnackBar(
      SnackBar(
        content: Text(
          exception.toString(),
        ),
      ),
    );
  }
}
