import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/data/gvm/record_view_model/record_view_model.dart';

class AdjustableProgressBar extends ConsumerStatefulWidget {
  final int? recordId;
  final int totalPage;
  final int? currentPage;
  final bool iconVisible;
  final Function(int) onProgressChanged;

  const AdjustableProgressBar({
    Key? key,
    required this.totalPage,
    required this.iconVisible,
    this.currentPage,
    this.recordId,
    required this.onProgressChanged,
  }) : super(key: key);

  @override
  _AdjustableProgressBarState createState() => _AdjustableProgressBarState();
}

class _AdjustableProgressBarState extends ConsumerState<AdjustableProgressBar> {
  late double _currentValue;
  late TextEditingController _currentPageController;
  bool _isEditing = false;
  Timer? _debounce;
  late RecordViewModel _recordViewModel;

  @override
  void initState() {
    super.initState();
    _currentValue = (widget.currentPage ?? 0).toDouble();
    _currentPageController =
        TextEditingController(text: _currentValue.toInt().toString());
    _recordViewModel = ref.read(recordViewModelProvider.notifier);
  }

  @override
  void dispose() {
    _currentPageController.dispose();
    _debounce?.cancel();
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
    if (newValue != null &&
        newValue >= 0 &&
        newValue <= widget.totalPage &&
        newValue != _currentValue.toInt()) {
      _updateProgress(newValue);
    }
    setState(() {
      _isEditing = false;
    });
  }

  void _onSliderChanged(double value) {
    if (_currentValue != value) {
      setState(() {
        _currentValue = value;
        _currentPageController.text = _currentValue.toInt().toString();
      });

      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        _updateProgress(_currentValue.toInt());
      });
    }
  }

  void _updateProgress(int newProgress) {
    if (newProgress != widget.currentPage) {
      widget.onProgressChanged(newProgress);
      if (widget.recordId != null) {
        _recordViewModel.updateRecordAttribute(
          recordType: 2,
          recordId: widget.recordId!,
          type: 1,
          progress: newProgress,
        );
      }
    }
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
              if (widget.iconVisible)
                Row(
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
              Text(
                '${ceilProgressPages(currentPage: _currentValue.toInt(), totalPage: widget.totalPage)}%',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
        ),
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
            onChanged: _onSliderChanged,
          ),
        ),
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
                      onEditingComplete: () =>
                          _submitPage(_currentPageController.text),
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
