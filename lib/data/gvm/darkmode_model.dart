import 'package:flutter_riverpod/flutter_riverpod.dart';

class DarkModeNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false; // 초기 상태를 직접 설정
  }

  void changeDarkMode() {
    state = !state;
  }
}

final darkModeNotiProvider = NotifierProvider<DarkModeNotifier, bool>(
  DarkModeNotifier.new, // 더 간결하게 Notifier 생성
);
