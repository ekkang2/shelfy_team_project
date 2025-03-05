import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/gvm/user_view_model/session_view_model.dart';
import '../data/model/user_model/session_user.dart';

// 유저 정보 관리 (StateNotifier)
class SessionUserNotifier extends StateNotifier<SessionUser?> {
  SessionUserNotifier() : super(null);

  void login(SessionUser user) {
    state = user;
  }

  void logout() {
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
  final user = ref.watch(sessionProvider);

  if (user == null) {
    return 0;
  }

  return user.id ?? 0;
}
