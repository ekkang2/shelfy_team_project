import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shelfy_team_project/data/gvm/record_view_model/record_view_model.dart';

class ReadPeriod extends ConsumerStatefulWidget {
  final int? recordId;
  final int? recordType;
  final DateTime? startDate;
  final DateTime? endDate;
  final int recordState;
  final Function(DateTime, DateTime?) onDateChanged;

  const ReadPeriod({
    Key? key,
    this.recordId,
    this.recordType,
    this.startDate,
    this.endDate,
    required this.recordState,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  _ReadPeriodState createState() => _ReadPeriodState();
}

class _ReadPeriodState extends ConsumerState<ReadPeriod> {
  late DateTime _startDate;
  late DateTime? _endDate;
  late RecordViewModel _recordViewModel;

  @override
  void initState() {
    super.initState();
    _startDate = widget.startDate ?? DateTime.now();
    _endDate = widget.endDate;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _recordViewModel = ref.read(recordViewModelProvider.notifier);
  }

  void _updateDate({DateTime? startDate, DateTime? endDate}) {
    if (widget.recordId == null || widget.recordType == null) {
      debugPrint('레코드 ID나 타입이 null입니다.');
      return;
    }

    _recordViewModel.updateRecordAttribute(
      recordType: widget.recordType!,
      recordId: widget.recordId!,
      type: 3,
      startDate: startDate,
      endDate: endDate,
    );

    widget.onDateChanged(startDate ?? _startDate, endDate);
  }

  Future<void> _selectStartDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _startDate) {
      setState(() {
        _startDate = pickedDate;
        if (_endDate != null && _endDate!.isBefore(_startDate)) {
          _endDate = null;
        }
      });
      _updateDate(startDate: _startDate, endDate: _endDate);
    }
  }

  Future<void> _selectEndDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate,
      firstDate: _startDate,
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _endDate) {
      setState(() {
        _endDate = pickedDate;
      });
      _updateDate(startDate: _startDate, endDate: _endDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.recordState != 0)
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: isDarkMode ? Colors.grey[500] : const Color(0xFF4D77B2),
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                widget.recordState == 4
                    ? '독서기간'
                    : '${dateCalculation(_startDate, _endDate)}일 동안 ${widget.recordState == 1 ? '읽었어요.' : '읽고 있어요.'}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.only(top: 16.0, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDateSelector(
                label: '시작일',
                date: _startDate,
                onTap: _selectStartDate,
              ),
              _buildDateSelector(
                label: '종료일',
                date: _endDate,
                onTap: widget.recordState != 2 ? _selectEndDate : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector({
    required String label,
    required DateTime? date,
    required VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        TextButton(
          onPressed: onTap,
          child: Text(
            date != null ? formatSingleDate(date) : '-',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  String formatSingleDate(DateTime time) {
    return DateFormat('yyyy.MM.dd').format(time);
  }

  int dateCalculation(DateTime startDate, DateTime? endDate) {
    if (endDate == null) return 0;
    return endDate.difference(startDate).inDays + 1;
  }
}
