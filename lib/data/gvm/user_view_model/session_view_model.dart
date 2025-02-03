import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/data/repository/user_repository/user_repository.dart';
import 'package:shelfy_team_project/main.dart';

import '../../model/user_model/session_user.dart';

class SessionVM extends Notifier<SessionUser> {
  // view-model 에서 context에 접근하기 위한 navigatorKey 사용
  final currentContext = navigatorkey.currentContext;

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

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final body = {
      'username': username,
      'password': password,
    };
    await userRepository.findByUidAndPassword(body);
  }
}

// 창고 관리자 선언
final sessionProvider = NotifierProvider<SessionVM, SessionUser>(
  () => SessionVM(),
);
