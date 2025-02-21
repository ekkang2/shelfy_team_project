import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/model/user_model/session_user.dart';

// ✅ 유저 정보 관리 (StateNotifier)
class SessionUserNotifier extends StateNotifier<SessionUser?> {
  SessionUserNotifier() : super(null);

  // ✅ 로그인 정보 저장 (앱 내 상태 유지)
  void login(SessionUser user) {
    state = user;
  }

  // ✅ 로그아웃 (상태 초기화)
  void logout() {
    state = null;
  }
}

// ✅ 유저 정보 Provider
final sessionUserProvider =
    StateNotifierProvider<SessionUserNotifier, SessionUser?>(
  (ref) => SessionUserNotifier(),
);

// ✅ 현재 로그인한 유저 ID 가져오기 (불필요한 rebuild 방지)
int getUserId(WidgetRef ref) => ref.read(sessionUserProvider)?.id ?? 0;
