import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/model/user_model/session_user.dart';

// ✅ 현재 로그인한 유저 정보를 저장하는 Provider
final sessionUserProvider = StateProvider<SessionUser?>((ref) => null);

// ✅ 로그인한 유저의 ID 가져오기 (로그인 안 했으면 기본값 1)
int getUserId(WidgetRef ref) {
  final sessionUser = ref.read(sessionUserProvider);
  return sessionUser?.id ?? 1; // 로그인했으면 sessionUser.id, 없으면 1
}
