import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReadPeriod extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isDarkMode;
  final int recordState;
  final Function(DateTime, DateTime?) onDateChanged; // 🔥 콜백 추가

  ReadPeriod({
    this.startDate,
    this.endDate,
    required this.recordState,
    required this.isDarkMode,
    required this.onDateChanged, // 🔥 필수 매개변수로 추가
    super.key,
  });

  @override
  State<ReadPeriod> createState() => _ReadPeriodState();
}

class _ReadPeriodState extends State<ReadPeriod> {
  late DateTime startDate;
  late DateTime? endDate;

  @override
  void initState() {
    super.initState();
    startDate = widget.startDate ?? DateTime.now();
    endDate = widget.endDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.recordState != 0,
            child: Row(
              children: [
                Icon(
                  Icons.access_alarm,
                  color: !isDarkMode ? Color(0xFF4D77B2) : Colors.grey[500],
                  size: 20,
                ),
                const SizedBox(width: 4),
                widget.recordState == 4
                    ? Text('독서기간')
                    : Text(
                        '${dateCalculation(startDate!, endDate!)}일 동안 ${widget.recordState == 1 ? '읽었어요.' : '읽고 있어요.'} ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: !widget.isDarkMode ? Colors.grey[100] : Colors.grey[850],
              borderRadius: BorderRadius.circular(3),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // 📌 시작일 선택 버튼
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('시작일'),
                    TextButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          initialDate: startDate,
                        );
                        if (pickedDate != null) {
                          setState(() {
                            startDate = pickedDate;
                            if (endDate != null &&
                                endDate!.isBefore(startDate)) {
                              endDate = null;
                            }
                          });
                          widget.onDateChanged(
                              startDate, endDate); // 🔥 변경된 날짜 전달
                        }
                      },
                      child: Text(
                        formatSingleDate(startDate),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),

                // 📌 종료일 선택 버튼
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('종료일'),
                    TextButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: startDate,
                          lastDate: DateTime(2100),
                          initialDate: endDate ?? startDate,
                        );
                        if (pickedDate != null) {
                          setState(() {
                            endDate = pickedDate;
                          });
                          widget.onDateChanged(
                              startDate, endDate); // 🔥 변경된 날짜 전달
                        }
                      },
                      child: Text(
                        endDate != null ? formatSingleDate(endDate!) : '-',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//  날짜 포맷 함수
String formatSingleDate(DateTime time) {
  final dateFormatter = DateFormat('yyyy.MM.dd');
  return dateFormatter.format(time);
}

int dateCalculation(DateTime startDate, DateTime endDate) {
  int period = endDate.difference(startDate).inDays;
  return period + 1;
}
