import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/model/user_model/session_user.dart';

// 유저 정보 관리 (StateNotifier)
class SessionUserNotifier extends StateNotifier<SessionUser?> {
  SessionUserNotifier() : super(null);

  void login(SessionUser user) {
    print("로그인: ${user.id}"); // 로그인 정보 확인
    state = user;
  }

  void logout() {
    print("🚨 로그아웃: 상태 초기화");
    state = null;
  }
}

// 유저 정보 Provider
final sessionUserProvider =
    StateNotifierProvider<SessionUserNotifier, SessionUser?>((ref) {
  return SessionUserNotifier();
}, name: "sessionUserProvider");

// 현재 로그인한 유저 ID 가져오기 (불필요한 rebuild 방지)
int getUserId(WidgetRef ref) {
  final user = ref.watch(sessionUserProvider);
  print("getUserId() 호출 - 현재 user: $user"); // ✅ 유저 정보 확인 로그 추가

  if (user == null) {
    print("🚨 getUserId() 실패: 유저 정보 없음");
    return 0;
  }

  print("getUserId() 반환: ${user.id}");
  return user.id ?? 0;
}
