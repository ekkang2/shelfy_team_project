import 'package:flutter/material.dart';

class CommonSnackbar {
  // 모든 스낵바 공통 함수 (아이콘, 색상 설정 가능)
  static void show(BuildContext context, String message,
      {Color color = Colors.blue, IconData icon = Icons.info}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white), // 아이콘 표시 (흰색)
            const SizedBox(width: 8), // 아이콘과 메시지 간격
            Expanded(child: Text(message)), // 메시지 표시 (여러 줄 가능)
          ],
        ),
        backgroundColor: color, // 배경색 (파란색, 초록색, 빨간색 등)
        behavior: SnackBarBehavior.floating, // 화면 위에 뜨는 스타일
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)), // 둥근 테두리
      ),
    );
  }

  // 성공 메시지 (초록색, 체크 아이콘)
  static void success(BuildContext context, String message) =>
      show(context, message, color: Colors.green, icon: Icons.check_circle);

  // 오류 메시지 (빨간색, 에러 아이콘)
  static void error(BuildContext context, String message) =>
      show(context, message, color: Colors.red, icon: Icons.error);

  // 경고 메시지 (주황색, 경고 아이콘)
  static void warning(BuildContext context, String message) =>
      show(context, message, color: Colors.orange, icon: Icons.warning);

  // 일반 정보 메시지 (파란색, 정보 아이콘)
  static void info(BuildContext context, String message) =>
      show(context, message);
}
