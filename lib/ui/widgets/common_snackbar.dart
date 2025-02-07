import 'package:flutter/material.dart';

class CommonSnackbar {
  static void show(BuildContext context, String message,
      {Color color = const Color(0xFF1976D2), // ✅ 기본은 iOS 스타일 파란색!
      IconData icon = Icons.info}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // ✅ 테마 컬러 반영
  static void success(BuildContext context, String message) =>
      show(context, message,
          color: Theme.of(context).colorScheme.primary,
          icon: Icons.check_circle);

  static void error(BuildContext context, String message) =>
      show(context, message,
          color: Theme.of(context).colorScheme.error, icon: Icons.error);

  static void warning(BuildContext context, String message) =>
      show(context, message,
          color: Theme.of(context).colorScheme.secondary, icon: Icons.warning);

  static void info(BuildContext context, String message) =>
      show(context, message,
          color: Theme.of(context).colorScheme.surfaceTint, icon: Icons.info);
}
