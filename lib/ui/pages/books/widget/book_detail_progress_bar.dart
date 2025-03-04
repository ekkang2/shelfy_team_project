import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdjustableProgressBar extends StatefulWidget {
  final int totalPage;
  final int? currentPage;
  final bool iconVisible;
  final Function(int) onProgressChanged; //  변경된 progress 값 전달할 콜백

  const AdjustableProgressBar({
    Key? key,
    required this.totalPage,
    required this.iconVisible,
    this.currentPage,
    required this.onProgressChanged, //  필수 매개변수로 추가
  }) : super(key: key);

  @override
  _AdjustableProgressBarState createState() => _AdjustableProgressBarState();
}

class _AdjustableProgressBarState extends State<AdjustableProgressBar> {
  late double _currentValue;
  late TextEditingController _currentPageController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _currentValue = (widget.currentPage ?? 0).toDouble();
    _currentPageController =
        TextEditingController(text: _currentValue.toInt().toString());
  }

  @override
  void dispose() {
    _currentPageController.dispose();
    super.dispose();
  }

  void _enableEditing() {
    setState(() {
      _isEditing = true;
      _currentPageController.text = _currentValue.toInt().toString();
    });
  }

  void _submitPage(String value) {
    int? newValue = int.tryParse(value);
    if (newValue != null && newValue >= 0 && newValue <= widget.totalPage) {
      setState(() {
        _currentValue = newValue.toDouble();
      });
      widget.onProgressChanged(newValue); //  부모 위젯으로 progress 값 전달
    }
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Visibility(
                visible: widget.iconVisible,
                child: Row(
                  children: [
                    Icon(
                      Icons.bookmark,
                      color: !isDarkMode
                          ? const Color(0xFF4D77B2)
                          : Colors.grey[500],
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
              Text(
                '${ceilProgressPages(currentPage: _currentValue.toInt(), totalPage: widget.totalPage)}%',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
        ),

        //  슬라이더
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 8.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
          ),
          child: Slider(
            inactiveColor: !isDarkMode ? Colors.grey[350] : Colors.grey[800],
            thumbColor:
                !isDarkMode ? const Color(0xFF4D77B2) : Colors.grey[500],
            activeColor:
                !isDarkMode ? const Color(0xFF4D77B2) : Colors.grey[400],
            value: _currentValue,
            min: 0,
            max: widget.totalPage.toDouble(),
            divisions: widget.totalPage,
            label: "${_currentValue.toInt()}p",
            onChanged: (value) {
              setState(() {
                _currentValue = value;
                _currentPageController.text = _currentValue.toInt().toString();
              });
              widget.onProgressChanged(_currentValue.toInt());
            },
          ),
        ),

        //  현재 페이지 표시
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: _isEditing
                ? SizedBox(
                    width: 80,
                    child: TextField(
                      controller: _currentPageController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium,
                      autofocus: true,
                      onSubmitted: _submitPage,
                      onEditingComplete: () {
                        _submitPage(_currentPageController.text);
                      },
                    ),
                  )
                : GestureDetector(
                    onTap: _enableEditing,
                    child: Text(
                      '${_currentValue.toInt()} / ${widget.totalPage} 페이지',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  String ceilProgressPages({required int totalPage, required int currentPage}) {
    return ((currentPage / totalPage) * 100).toStringAsFixed(1);
  }
}
