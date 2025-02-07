import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ReadPeriod extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isDarkMode;
  final Function(DateTime, DateTime?) onDateChanged; // 🔥 콜백 추가

  ReadPeriod({
    this.startDate,
    this.endDate,
    required this.isDarkMode,
    required this.onDateChanged, // 🔥 필수 매개변수로 추가
    super.key,
  });

  @override
  State<ReadPeriod> createState() => _ReadPeriodState();
}

class _ReadPeriodState extends State<ReadPeriod> {
  late DateTime startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    startDate = widget.startDate ?? DateTime.now();
    endDate = widget.endDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
