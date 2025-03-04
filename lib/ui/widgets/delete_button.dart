import 'package:flutter/material.dart';

import 'common_dialog.dart';

Widget deleteButton(BuildContext context, Function func) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.grey),
          onPressed: () {
            showConfirmationDialog(
              context: context,
              title: '기록을 삭제하시겠습니까?',
              subtitle: '삭제한 기록은 복구할 수 없어요!',
              confirmText: '삭제',
              snackBarMessage: '삭제 완료!',
              snackBarIcon: Icons.delete_forever,
              snackBarType: 'error',
              onConfirm: () => func(),
            );
          },
        ),
      ],
    ),
  );
}
