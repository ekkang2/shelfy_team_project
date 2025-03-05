import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 별점 또는 하트 점수를 조절할 수 있는 위젯
class InteractiveStarRating extends StatefulWidget {
  final int type; // 1이면 별, 0이면 하트
  final double size; // 아이콘 크기
  final Function(double) onRatingChanged; // 별점이 변경될 때 실행할 함수
  double? rating;

  InteractiveStarRating({
    Key? key,
    required this.type,
    required this.size,
    required this.onRatingChanged,
    this.rating,
  }) : super(key: key);

  @override
  _InteractiveStarRatingState createState() => _InteractiveStarRatingState();
}

class _InteractiveStarRatingState extends State<InteractiveStarRating> {
  double _rating = 0.0; // 현재 선택된 별점 값

  @override
  void initState() {
    _rating = widget.rating ?? 0.0;
  }

  // 사용자가 터치한 위치를 기반으로 별점을 계산하는 함수
  void _updateRating(double positionX, double maxWidth) {
    double starWidth = maxWidth / 5; // 전체 너비를 5개의 별로 나누어 한 개 별의 너비 계산
    int fullStars = (positionX / starWidth).floor(); // 몇 번째 별을 터치했는지 확인
    double remainder = (positionX % starWidth) / starWidth; // 별 안에서 터치한 위치 비율

    // 터치한 위치에 따라 반 개(0.5) 또는 전체(1.0) 별을 채움
    double newRating = fullStars + (remainder < 0.5 ? 0.5 : 1.0);
    newRating = newRating.clamp(0.0, 5.0); // 0에서 5 사이로 값 제한

    setState(() {
      _rating = newRating; // 새 별점 값으로 업데이트
    });
    widget.onRatingChanged(_rating); // 부모 위젯에 변경된 별점 전달
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        // 사용자가 드래그할 때 별점 업데이트
        RenderBox box =
            context.findRenderObject() as RenderBox; // 위젯의 위치 및 크기 가져오기
        _updateRating(details.localPosition.dx, box.size.width);
      },
      onTapDown: (details) {
        // 사용자가 터치했을 때 별점 업데이트
        RenderBox box = context.findRenderObject() as RenderBox;
        _updateRating(details.localPosition.dx, box.size.width);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
        children: List.generate(5, (index) {
          // 별 5개 생성
          if (index + 1 <= _rating) {
            // 별이 채워져야 하는 경우
            return Icon(
                widget.type == 1
                    ? CupertinoIcons.star_fill // 별 아이콘 사용
                    : CupertinoIcons.heart_fill, // 하트 아이콘 사용
                color: widget.type == 1
                    ? Colors.amber
                    : Colors.redAccent[100], // 색상 설정
                size: widget.size);
          } else if (index < _rating && _rating - index == 0.5) {
            // 반개 별이 필요한 경우
            return Stack(
              children: [
                Icon(
                    widget.type == 1
                        ? CupertinoIcons.star_fill
                        : CupertinoIcons.heart_fill,
                    color: Colors.grey[300], // 배경색 (빈 별)
                    size: widget.size),
                ClipRect(
                  clipper: HalfClipper(), // 반쪽만 보이도록 클리퍼 사용
                  child: Icon(
                      widget.type == 1
                          ? CupertinoIcons.star_fill
                          : CupertinoIcons.heart_fill,
                      color: widget.type == 1
                          ? Colors.amber
                          : Colors.redAccent[100], // 앞쪽 색상
                      size: widget.size),
                ),
              ],
            );
          } else {
            // 빈 별을 표시할 경우
            return Icon(
                widget.type == 1
                    ? CupertinoIcons.star_fill
                    : CupertinoIcons.heart_fill,
                color: Colors.grey[300], // 빈 별 색상
                size: widget.size);
          }
        }),
      ),
    );
  }
}

// 반쪽 별을 만들기 위한 클리퍼 클래스
class HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width / 2, size.height); // 별의 왼쪽 반쪽만 표시
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false; // 클리퍼 변경 불필요
}
