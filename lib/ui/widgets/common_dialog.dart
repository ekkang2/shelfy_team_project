import 'package:flutter/material.dart';

// 1. 함수형 다이얼로그 (간단한 확인/취소 용)
void showConfirmationDialog({
  required BuildContext context,
  required String title,
  String? subtitle,
  required String confirmText,
  required VoidCallback onConfirm,
  required String snackBarMessage,
  IconData? snackBarIcon,
  Color confirmTextColor = Colors.blue,
  Color snackBarColor = Colors.green,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min, // 내용에 맞게 크기 최소화
            children: [
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 20), // 버튼과 텍스트 사이 간격
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('취소'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              if (snackBarIcon != null) ...[
                                Icon(snackBarIcon, color: Colors.white),
                                const SizedBox(width: 8),
                              ],
                              Text(snackBarMessage),
                            ],
                          ),
                          duration: const Duration(seconds: 2),
                          backgroundColor: snackBarColor,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(confirmText,
                        style: TextStyle(color: confirmTextColor)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

// 2. 위젯 기반 다이얼로그 (복잡한 UI나 커스터마이징 용)
class CommonDialog extends StatelessWidget {
  final String title;
  final String? description;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const CommonDialog({
    super.key,
    required this.title,
    this.description,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center),
            if (description != null) ...[
              const SizedBox(height: 8),
              Text(description!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey),
                  textAlign: TextAlign.center),
            ],
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDialogButton(context, cancelText, Colors.grey,
                    onCancel ?? () => Navigator.of(context).pop()),
                _buildDialogButton(context, confirmText,
                    Theme.of(context).colorScheme.primary, onConfirm),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 버튼 스타일 공통 처리
  Widget _buildDialogButton(
      BuildContext context, String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: color,
        side: BorderSide(color: color),
        minimumSize: const Size(100, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text, style: Theme.of(context).textTheme.labelLarge),
    );
  }
}
