import 'package:flutter/material.dart';

Widget customElevatedButton(
    {required bool isDarkMode, required String text, VoidCallback? onPressed}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
          !isDarkMode ? const Color(0xFF4D77B2) : Colors.grey[800]),
      fixedSize: MaterialStatePropertyAll(Size(300, 50)),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
  );
}
