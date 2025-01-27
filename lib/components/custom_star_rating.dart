import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/*
  박연화 2025/01/27
  별점 출력 위젯
  매개변수 : 실수형 별점, 정수형 타입 ( 1 - star / 0 - heart)
 */
Widget customStarRating(double rating, int type) {
  return Row(
    children: List.generate(5, (index) {
      if (index + 1 <= rating) {
        // 완전한 별
        return Icon(
            type == 1 ? CupertinoIcons.star_fill : CupertinoIcons.heart_fill,
            color: type == 1 ? Colors.amber : Colors.redAccent[100],
            size: 18);
      } else if (index < rating && rating - index < 1) {
        // 반쪽 별
        return Stack(
          children: [
            Icon(
                type == 1
                    ? CupertinoIcons.star_fill
                    : CupertinoIcons.heart_fill,
                color: Colors.grey[300],
                size: 18), // 회색 별
            ClipRect(
              clipper: HalfClipper(),
              child: Icon(
                  type == 1
                      ? CupertinoIcons.star_fill
                      : CupertinoIcons.heart_fill,
                  color: type == 1 ? Colors.amber : Colors.redAccent[100],
                  size: 18), // 노란색 반쪽
            ),
          ],
        );
      } else {
        // 빈 별
        return Icon(
            type == 1 ? CupertinoIcons.star_fill : CupertinoIcons.heart_fill,
            color: Colors.grey[300],
            size: 18);
      }
    }),
  );
}

class HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width / 2, size.height); // 왼쪽 절반 클립
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
