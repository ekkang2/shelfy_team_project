import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/model/user_model/session_user.dart';

// ✅ 현재 로그인한 유저 정보를 저장하는 Provider
final sessionUserProvider = StateProvider<SessionUser?>((ref) => null);

// ✅ 로그인한 유저의 ID 가져오기 (watch 사용)
int getUserId(WidgetRef ref) {
  final sessionUser = ref.watch(sessionUserProvider); // ✅ watch() 사용
  final userId = sessionUser?.id ?? 0; // 기본값: 0 (로그인 안 한 경우)
  print("🐛 현재 로그인한 유저 ID: $userId");
  // ✅ 로그 추가

  return userId;
}
