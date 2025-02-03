import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ReadPeriod extends StatefulWidget {
  final DateTime startDate;
  final DateTime? endDate;
  final bool isDarkMode;

  ReadPeriod({
    required this.startDate,
    this.endDate,
    required this.isDarkMode,
    super.key,
  });

  @override
  State<ReadPeriod> createState() => _ReadPeriodState();
}

class _ReadPeriodState extends State<ReadPeriod> {
  late DateTime startDate;
  DateTime? endDate; // 종료일을 nullable 변수로 선언

  @override
  void initState() {
    super.initState();
    startDate = widget.startDate;
    endDate = widget.endDate; // 초기 종료일 설정
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
                            // 시작일이 바뀌면 종료일도 초기화할 수 있음 (선택 사항)
                            if (endDate != null &&
                                endDate!.isBefore(startDate)) {
                              endDate = null;
                            }
                          });
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
                          firstDate: startDate, // 시작일 이후만 선택 가능
                          lastDate: DateTime(2100),
                          initialDate: endDate ?? startDate, // 기본값 처리
                        );
                        if (pickedDate != null) {
                          setState(() {
                            endDate = pickedDate;
                          });
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
