import 'package:flutter/material.dart';
import 'common_snackbar.dart';

void showConfirmationDialog({
  required BuildContext context,
  required String title,
  String? subtitle,
  required String confirmText,
  required VoidCallback onConfirm,
  required String snackBarMessage,
  IconData? snackBarIcon,
  String snackBarType = 'success', // ✅ 공통 스낵바 타입 설정
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
            mainAxisSize: MainAxisSize.min,
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
              const SizedBox(height: 20),
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

                      // ✅ 스낵바 색상을 CommonSnackbar에서 관리하도록 수정
                      switch (snackBarType) {
                        case 'success':
                          CommonSnackbar.success(context, snackBarMessage);
                          break;
                        case 'error':
                          CommonSnackbar.error(context, snackBarMessage);
                          break;
                        case 'warning':
                          CommonSnackbar.warning(context, snackBarMessage);
                          break;
                        case 'info':
                        default:
                          CommonSnackbar.info(context, snackBarMessage);
                          break;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child:
                        Text(confirmText, style: TextStyle(color: Colors.blue)),
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
