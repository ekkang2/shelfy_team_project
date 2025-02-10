/*
  생성일 : 2025/02/01
  작성자 : 전규찬
  내용 : SessionUser 관련 view-model
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/_core/utils/logger.dart';
import 'package:shelfy_team_project/_core/utils/m_http.dart';
import 'package:shelfy_team_project/data/repository/user_repository.dart';
import 'package:shelfy_team_project/main.dart';
import 'package:shelfy_team_project/ui/pages/main_screen.dart';
import 'package:shelfy_team_project/ui/widgets/common_snackbar.dart';

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
      userUid: null,
      userNick: null,
      userProfile: null,
      accessToken: null,
      isLogined: false,
    );
  }

  /**
   * 2025/02/04 전규찬
   * 로그인 뷰 모델 기능
   */
  Future<void> login({
    // 아이디
    required String userUid,
    // 비밀번호
    required String userPwd,
  }) async {
    try {
      final body = {
        'userUid': userUid,
        'userPwd': userPwd,
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
      secureStorage.write(key: 'accessToken', value: accessToken);

      // SessionUser 상태 업데이트 ( 깊은 복사를 통해 플러터에게 상태의 변화를 인지하게끔 만듬 )
      Map<String, dynamic> data = resBody['response'];

      state = SessionUser(
        id: data['userId'], // ✅ 기존 'id' 대신 'userId' 사용
        userUid: data['userUid'],
        userNick: data['userNick'],
        userProfile: data['userProfile'],
        accessToken: accessToken,
        isLogined: true,
      );

      // ✅ 로그 추가해서 상태 확인
      logger.d("🔥 로그인 성공 - 현재 상태: ${state.id}, ${state.userNick}");

      // 추후 dio를 통한 api 요청에 토큰을 포함시키기 위한 dio Option 수정
      dio.options.headers['Authorization'] = accessToken;

      // 홈 화면으로 페이지 이동
      Navigator.pushNamedAndRemoveUntil(mContext, '/', (route) => false);

      // 로그인 성공 스낵바 출력
      CommonSnackbar.success(mContext, '로그인 되었습니다.');
    } catch (e, stackTrace) {
      ExceptionHandler.handleException('서버 연결 실패', stackTrace);
      CommonSnackbar.error(mContext, '서버 연결 실패.');
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
        'userPwd': userPwd,
        'userProfile': 'profile_default.png',
      });
      // 통신은 성공했지만 내부 판별 오류 시 방어적 코드 작성
      if (!resBody['success']) {
        ExceptionHandler.handleException(
            resBody['errorMessage'], StackTrace.current);
        return; // 실행의 제어권 반납
      }
      // 회원가입 성공 시 바로 로그인 페이지로 이동
      Navigator.popAndPushNamed(mContext, '/login');

      // 회원가입 성공 스낵바 출력
      CommonSnackbar.success(mContext, '회원가입 되었습니다.');
    } catch (e, stackTrace) {
      ExceptionHandler.handleException('서버 연결 실패', stackTrace);
    }
  }

  void logout() {
    // secureStorage 에서 토큰 제거
    secureStorage.delete(key: 'accessToken');

    // dio 헤더의 Authorization 제거
    dio.options.headers['Authorization'] = '';

    // sessionUser 초기화
    state = SessionUser(
      id: null,
      userUid: null,
      userNick: null,
      userProfile: null,
      accessToken: null,
      isLogined: false,
    );

    // 로그인 페이지로 이동
    Navigator.pushAndRemoveUntil(
      mContext,
      MaterialPageRoute(builder: (context) => MainScreen(initialIndex: 0)),
      (route) => false,
    );
  }

  // 회원가입 시 중복 검사
  // 아이디 중복 검사
  Future<void> checkDuplicateUserUid(String userUid) async {
    final bool isDuplicate = await userRepository.validateUserUid(userUid);
  }

  // 닉네임 중복 검사
  Future<void> checkDuplicateUserNick(String userNick) async {
    final bool isDuplicate = await userRepository.validateUserUid(userNick);
  }

  // 이메일 중복 검사
  Future<void> checkDuplicateUserEmail(String userEmail) async {
    final bool isDuplicate = await userRepository.validateUserUid(userEmail);
  }

  // 이메일 인증 처리
  Future<void> sendVerificationEmail(String userEmail) async {
    final bool isEmailSent = await userRepository.verifyEmail(userEmail);
    if (isEmailSent) {
      CommonSnackbar.success(mContext, '인증 코드가 전송되었습니다');
    } else {
      CommonSnackbar.error(mContext, '인증 코드 전송에 실패하였습니다');
    }
  }
}

// 창고 관리자 선언
final sessionProvider = NotifierProvider<SessionVM, SessionUser>(
  () => SessionVM(),
);
