import 'package:flutter/material.dart';

// 텍스트 테마
TextTheme textTheme() {
  return TextTheme(
    // 앱바 타이틀 화이트
    displayLarge: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
        fontFamily: 'JUA',
        fontWeight: FontWeight.normal),
    // 탭바 라벨 타이틀 블루
    displayMedium: TextStyle(
        fontSize: 14.8,
        color: const Color(0xFF4D77B2),
        fontFamily: 'Pretendard-Bold'),
    headlineLarge: TextStyle(
      fontFamily: 'Pretendard-Bold',
      color: Colors.black,
      fontSize: 22,
    ),
    // title... 블랙 두껍게
    titleLarge: TextStyle(
        fontSize: 17.0, color: Colors.black87, fontFamily: 'Pretendard-Bold'),
    titleMedium: TextStyle(
        fontSize: 16.0, color: Colors.black, fontFamily: 'Pretendard-Bold'),
    titleSmall: TextStyle(
        fontSize: 14.0, color: Colors.black, fontFamily: 'Pretendard-Bold'),
    // body... 블랙 기본얇기
    bodyLarge: TextStyle(
        fontSize: 16.0, color: Colors.black, fontFamily: 'Pretendard-Regular'),
    bodyMedium: TextStyle(
        fontSize: 14.0, color: Colors.black, fontFamily: 'Pretendard-Regular'),
    bodySmall: TextStyle(
        fontSize: 12.0, color: Colors.black, fontFamily: 'Pretendard-Regular'),
    // label... 그레이 기본얇기
    labelLarge: TextStyle(
        fontSize: 16.0, color: Colors.grey, fontFamily: 'Pretendard-Regular'),
    labelMedium: TextStyle(
        fontSize: 13.0, color: Colors.grey, fontFamily: 'Pretendard-Regular'),
    labelSmall: TextStyle(
        fontSize: 12.0, color: Colors.grey, fontFamily: 'Pretendard-Regular'),
  );
}

// AppBar 테마 설정
AppBarTheme appBarTheme() {
  return AppBarTheme(
    centerTitle: false,
    color: const Color(0xFF4D77B2),
    // AppBar 배경색
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
        fontFamily: 'JUA',
        fontWeight: FontWeight.normal),
  );
}

// 바텀네비게이션바 테마 설정
BottomNavigationBarThemeData bottomNavigationBarTheme() {
  return BottomNavigationBarThemeData(
    backgroundColor: Colors.white, // BottomNavigationBar 배경색
    selectedItemColor: const Color(0xFF4D77B2), // 선택된 아이템 색상
    unselectedItemColor: Colors.grey.withOpacity(0.6), // 선택되지 않은 아이템 색상
    showUnselectedLabels: true, // 선택 안된 라벨 표시 여부 설정
  );
}

// 전체 ThemeData 설정
ThemeData mTheme() {
  return ThemeData(
    // 머터리얼 3 때부터 변경 됨..
    // 자동 셋팅
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange)
    // 우리가 직접 지정 함
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
    ).copyWith(
      primary: const Color(0xFF4D77B2), // 주요 색상
      secondary: const Color(0xFF5B6A95), // 보조 색상
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme(),
    appBarTheme: appBarTheme(),
    bottomNavigationBarTheme: bottomNavigationBarTheme(),
  );
}

//============================== 다크 모드 theme 설정 =================================

// 다크 모드 텍스트 테마
TextTheme darkTextTheme() {
  return TextTheme(
    // 앱바 타이틀 화이트
    displayLarge: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
        fontFamily: 'JUA',
        fontWeight: FontWeight.normal),
    // 탭바 라벨 타이틀 블루
    displayMedium: TextStyle(
        fontSize: 14.8, color: Colors.black, fontFamily: 'Pretendard-Bold'),
    // title... 블랙 두껍게
    titleLarge: TextStyle(
        fontSize: 17.0, color: Colors.black87, fontFamily: 'Pretendard-Bold'),
    titleMedium: TextStyle(
        fontSize: 16.0, color: Colors.black, fontFamily: 'Pretendard-Bold'),
    titleSmall: TextStyle(
        fontSize: 14.0, color: Colors.black, fontFamily: 'Pretendard-Bold'),
    // body... 블랙 기본얇기
    bodyLarge: TextStyle(
        fontSize: 16.0, color: Colors.black, fontFamily: 'Pretendard-Regular'),
    bodyMedium: TextStyle(
        fontSize: 14.0, color: Colors.black, fontFamily: 'Pretendard-Regular'),
    bodySmall: TextStyle(
        fontSize: 12.0, color: Colors.black, fontFamily: 'Pretendard-Regular'),
    // label... 그레이 기본얇기
    labelLarge: TextStyle(
        fontSize: 16.0, color: Colors.grey, fontFamily: 'Pretendard-Regular'),
    labelMedium: TextStyle(
        fontSize: 13.0, color: Colors.grey, fontFamily: 'Pretendard-Regular'),
    labelSmall: TextStyle(
        fontSize: 12.0, color: Colors.grey, fontFamily: 'Pretendard-Regular'),
  );
}

// AppBar 테마 설정
AppBarTheme darkAppBarTheme() {
  return AppBarTheme(
    centerTitle: false,
    color: Colors.black,
    // AppBar 배경색
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
        fontFamily: 'JUA',
        fontWeight: FontWeight.normal),
  );
}

// 바텀네비게이션바 테마 설정
BottomNavigationBarThemeData darkBottomNavigationBarTheme() {
  return BottomNavigationBarThemeData(
    backgroundColor: Colors.black, // BottomNavigationBar 배경색
    selectedItemColor: Colors.white, // 선택된 아이템 색상
    unselectedItemColor: Colors.grey.withOpacity(0.6), // 선택되지 않은 아이템 색상
    showUnselectedLabels: true, // 선택 안된 라벨 표시 여부 설정
  );
}

IconThemeData darkIconTheme() {
  return IconThemeData(color: Colors.black);
}

// 전체 ThemeData 설정
ThemeData darkMTheme() {
  return ThemeData(
    // 머터리얼 3 때부터 변경 됨..
    // 자동 셋팅
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange)
    // 우리가 직접 지정 함
    iconTheme: darkIconTheme(),
    colorScheme: ColorScheme.dark(),
    scaffoldBackgroundColor: Colors.white,
    textTheme: darkTextTheme(),
    appBarTheme: darkAppBarTheme(),
    bottomNavigationBarTheme: darkBottomNavigationBarTheme(),
  );
}
