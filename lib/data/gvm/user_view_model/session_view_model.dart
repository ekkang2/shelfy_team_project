/*
  생성일 : 2025/02/01
  작성자 : 전규찬
  내용 : SessionUser 관련 view-model
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/_core/utils/m_http.dart';
import 'package:shelfy_team_project/data/repository/user_repository/user_repository.dart';
import 'package:shelfy_team_project/main.dart';

import '../../../_core/utils/exception_handler.dart';
import '../../model/user_model/session_user.dart';

class SessionVM extends Notifier<SessionUser> {
  // view-model 에서 context에 접근하기 위한 navigatorKey 사용
  final mContext = navigatorkey.currentContext!;

  UserRepository userRepository = UserRepository();

  @override
  SessionUser build() {
    return SessionUser(
      id: null,
      username: null,
      accessToken: null,
      isLogined: null,
    );
  }

  /**
   * 2025/02/04 전규찬
   * 로그인 뷰 모델 기능
   */
  Future<void> login({
    // 아이디
    required String username,
    // 비밀번호
    required String password,
  }) async {
    try {
      final body = {
        'username': username,
        'password': password,
      };
      // 레코드 문법으로 2 가지 리턴 값이 존재함 ( body 와 token )
      final (resBody, accessToken) =
          await userRepository.findByUidAndPassword(body);
      // 통신은 성공했지만 서버 내부적 오류가 발생했을 시
      if (!resBody['success']) {
        ExceptionHandler.handleException(
            resBody['errorMessage'], StackTrace.current);
        return;
      }
      // SecureStorage 에 엑세스 토큰 저장
      secureStorage.write(key: 'accToken', value: accessToken);

      // SessionUser 상태 업데이트 ( 깊은 복사를 통해 플러터에게 상태의 변화를 인지하게끔 만듬 )
      Map<String, dynamic> data = resBody['response'];
      state = SessionUser(
        id: data['id'],
        username: data['username'],
        accessToken: accessToken,
        isLogined: true,
      );

      // 추후 dio를 통한 api 요청에 토큰을 포함시키기 위한 dio Option 수정
      dio.options.headers['Authorization'] = accessToken;

      //
    } catch (e, stackTrace) {
      ExceptionHandler.handleException('서버 연결 실패', stackTrace);
    }
  }

  /**
   * 2025/02/04 전규찬
   * 회원가입 뷰 모델 기능
   */
  Future<void> join({
    required String userUid,
    required String userNick,
    required String userEmail,
    required String userPwd,
  }) async {
    try {
      Map<String, dynamic> resBody = await userRepository.insertUser({
        'userUid': userUid,
        'userNick': userNick,
        'userEmail': userEmail,
        'userPwd': userPwd
      });
      // 통신은 성공했지만 내부 판별 오류 시 방어적 코드 작성
      if (!resBody['success']) {
        ExceptionHandler.handleException(
            resBody['errorMessage'], StackTrace.current);
        return; // 실행의 제어권 반납
      }
      // 회원가입 성공 시 바로 로그인 페이지로 이동
      Navigator.popAndPushNamed(mContext, '/login');
    } catch (e, stackTrace) {
      ExceptionHandler.handleException('서버 연결 실패', stackTrace);
    }
  }
}

// 창고 관리자 선언
final sessionProvider = NotifierProvider<SessionVM, SessionUser>(
  () => SessionVM(),
);
