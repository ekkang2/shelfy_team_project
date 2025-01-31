import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/*
  박연화 2025/01/27
  매개변수 : int type, double width(라벨 크기, double height
  타입
  1 - 끝맺은 책 / 2 - 여정 중인 책 / 3 - 기다리는 책(읽고 싶은) / 4 - 잠든 책(중단한)
 */
Widget customRecordLabel(int type) {
  String labelText = '';
  IconData labelIcon = FontAwesomeIcons.book;
  double width = 0;
  if (type == 1) {
    width = 105.0;
    labelIcon = FontAwesomeIcons.book;
    labelText = '끝맺은 책';
  } else if (type == 2) {
    width = 120.0;
    labelIcon = Icons.menu_book;
    labelText = '여정 중인 책';
  } else if (type == 3) {
    width = 115.0;
    labelIcon = Icons.bookmark;
    labelText = '기다리는 책';
  } else if (type == 4) {
    width = 85.0;
    labelIcon = CupertinoIcons.pause_circle;
    labelText = '잠든 책';
  }
  return Container(
    width: width,
    decoration: BoxDecoration(
      color: Color(0xFF4D77B2),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            labelIcon,
            color: Colors.white,
            size: type == 1 ? 12 : 15,
          ),
          const SizedBox(width: 6),
          Text(
            labelText,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
