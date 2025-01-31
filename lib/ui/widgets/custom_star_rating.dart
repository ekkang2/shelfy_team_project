import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
  박연화 2025/01/27
  별점 출력 위젯
  매개변수 : 실수형 별점, 정수형 타입 ( 1 - star / 0 - heart), 별점 사이즈 (별 한 개의 크기 / 리스트 18 상세보기 25)
 */
Widget customStarRating(double rating, int type, double size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(5, (index) {
      if (index + 1 <= rating) {
        // 완전한 별
        return Icon(
            type == 1 ? CupertinoIcons.star_fill : CupertinoIcons.heart_fill,
            color: type == 1 ? Colors.amber : Colors.redAccent[100],
            size: size);
      } else if (index < rating && rating - index < 1) {
        // 반쪽 별
        return Stack(
          children: [
            Icon(
                type == 1
                    ? CupertinoIcons.star_fill
                    : CupertinoIcons.heart_fill,
                color: Colors.grey[300],
                size: size), // 회색 별
            ClipRect(
              clipper: HalfClipper(),
              child: Icon(
                  type == 1
                      ? CupertinoIcons.star_fill
                      : CupertinoIcons.heart_fill,
                  color: type == 1 ? Colors.amber : Colors.redAccent[100],
                  size: size), // 노란색 반쪽
            ),
          ],
        );
      } else {
        // 빈 별
        return Icon(
            type == 1 ? CupertinoIcons.star_fill : CupertinoIcons.heart_fill,
            color: Colors.grey[300],
            size: size);
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
