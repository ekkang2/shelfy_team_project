import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InteractiveStarRating extends StatefulWidget {
  final int type; // 1: 별, 0: 하트
  final double size;
  final Function(double) onRatingChanged;
  final double? rating;

  const InteractiveStarRating({
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
  double _rating = 0.0;

  @override
  void initState() {
    super.initState();
    _rating = widget.rating ?? 0.0;
  }

  void _updateRating(double positionX, double maxWidth) {
    if (maxWidth <= 0) return;
    positionX = positionX.clamp(0.0, maxWidth); // 터치 위치 보정
    double starWidth = maxWidth / 5; // 별 하나의 정확한 크기
    double newRating = (positionX / starWidth).clamp(0.0, 5.0);
    newRating = (newRating * 2).round() / 2; // 0.5 단위 반올림

    setState(() {
      _rating = newRating;
    });
    widget.onRatingChanged(_rating);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanUpdate: (details) {
            _updateRating(details.localPosition.dx, constraints.maxWidth);
          },
          onTapDown: (details) {
            _updateRating(details.localPosition.dx, constraints.maxWidth);
          },
          child: Padding(
            padding: EdgeInsets.zero, // 터치 범위 조정
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                double fillAmount = (_rating - index).clamp(0.0, 1.0);

                if (fillAmount == 1.0) {
                  return Icon(
                    widget.type == 1
                        ? CupertinoIcons.star_fill
                        : CupertinoIcons.heart_fill,
                    color:
                        widget.type == 1 ? Colors.amber : Colors.redAccent[100],
                    size: widget.size,
                  );
                } else if (fillAmount >= 0.5) {
                  return Stack(
                    children: [
                      Icon(
                        widget.type == 1
                            ? CupertinoIcons.star_lefthalf_fill
                            : CupertinoIcons.heart_fill,
                        color: widget.type == 1
                            ? Colors.amber
                            : Colors.redAccent[100],
                        size: widget.size,
                      ),
                    ],
                  );
                } else {
                  return Icon(
                    widget.type == 1
                        ? CupertinoIcons.star
                        : CupertinoIcons.heart,
                    color: Colors.grey[300],
                    size: widget.size,
                  );
                }
              }),
            ),
          ),
        );
      },
    );
  }
}
