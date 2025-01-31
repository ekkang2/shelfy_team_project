import 'package:flutter/material.dart';
import 'package:shelfy_team_project/theme.dart';

import '../../../../../data/model/book_record_doing.dart';

class AdjustableProgressBar extends StatefulWidget {
  final BookRecordDoing bookRecord; // BookRecordDoing 타입의 데이터 받기

  const AdjustableProgressBar({Key? key, required this.bookRecord})
      : super(key: key);

  @override
  _AdjustableProgressBarState createState() => _AdjustableProgressBarState();
}

class _AdjustableProgressBarState extends State<AdjustableProgressBar> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    // 초기 값 설정: bookRecord의 currentPage 값으로 초기화
    _currentValue = widget.bookRecord.currentPage.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23.0),
          child: Text(
            '${widget.bookRecord.ceilProgressPages()}%',
            style: textTheme().displayMedium,
          ),
        ),
        // 슬라이더
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 8.0, // 슬라이더 두께
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0), // 핸들 크기
            overlayShape:
                RoundSliderOverlayShape(overlayRadius: 20.0), // 오버레이 크기
          ),
          child: Slider(
            inactiveColor: Colors.grey[350],
            value: _currentValue,
            min: 0,
            max: widget.bookRecord.book.book_page.toDouble(), // 동적 최대 페이지 설정
            divisions: widget.bookRecord.book.book_page, // 동적 division 설정
            label: "${_currentValue.toInt()}p",
            onChanged: (value) {
              setState(() {
                _currentValue = value;
              });
            },
          ),
        ),
        // 페이지 정보 (오른쪽 정렬, 아래 라인)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${_currentValue.toInt()} / ${widget.bookRecord.book.book_page} 페이지',
              style: textTheme().labelMedium,
            ),
          ),
        ),
      ],
    );
  }
}
