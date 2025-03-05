import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../data/model/monthly_reading_data.dart';

class NoteStatisticsPage extends StatefulWidget {
  const NoteStatisticsPage({super.key});

  @override
  _NoteStatisticsPageState createState() => _NoteStatisticsPageState();
}

class _NoteStatisticsPageState extends State<NoteStatisticsPage> {
  int selectedYear = 2025; // 기본값: 2025년
  final List<int> availableYears = [2023, 2024, 2025];

  //  연도별 샘플 데이터
  final Map<int, List<MonthlyReadingData>> yearlyData = {
    2023: [
      MonthlyReadingData(month: 1, bookCount: 1, pageCount: 200),
      MonthlyReadingData(month: 3, bookCount: 2, pageCount: 300),
      MonthlyReadingData(month: 5, bookCount: 3, pageCount: 450),
    ],
    2024: [
      MonthlyReadingData(month: 2, bookCount: 2, pageCount: 250),
      MonthlyReadingData(month: 4, bookCount: 1, pageCount: 150),
      MonthlyReadingData(month: 6, bookCount: 3, pageCount: 500),
    ],
    2025: [
      MonthlyReadingData(month: 1, bookCount: 3, pageCount: 450),
      MonthlyReadingData(month: 2, bookCount: 2, pageCount: 300),
      MonthlyReadingData(month: 3, bookCount: 4, pageCount: 600),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  상단 타이틀 및 연도 선택 드롭다운
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "월별 독서량",
                  style: Theme.of(context).textTheme.titleLarge, // 🔹 적용
                ),
                _buildYearDropdown(),
              ],
            ),
            const SizedBox(height: 16),

            //  권수별 그래프
            _buildSectionTitle("권수별"),
            _buildBarChart(isPageChart: false),
            const SizedBox(height: 24),

            //  페이지별 그래프
            _buildSectionTitle("페이지별"),
            _buildBarChart(isPageChart: true),
          ],
        ),
      ),
    );
  }

  //  연도 선택 드롭다운 위젯
  Widget _buildYearDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: selectedYear,
          items: availableYears.map((year) {
            return DropdownMenuItem(
              value: year,
              child: Text(
                "$year년",
                style: Theme.of(context).textTheme.bodyMedium, // 🔹 적용
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedYear = value;
              });
            }
          },
        ),
      ),
    );
  }

  //  섹션 타이틀 스타일
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium, // 🔹 적용
      ),
    );
  }

  //  막대 그래프 생성 함수 (권수별 / 페이지별)
  Widget _buildBarChart({required bool isPageChart}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100], //  그래프 배경 회색
        borderRadius: BorderRadius.circular(12),
      ),
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: _buildBarGroups(isPageChart),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40, // 왼쪽 숫자 간격
                interval: isPageChart ? 100 : 1, // 페이지는 100 단위, 권수는 1 단위
                getTitlesWidget: (value, meta) => Text(
                  value.toInt().toString(),
                  style: Theme.of(context).textTheme.bodySmall, // 🔹 적용
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  int month = value.toInt();
                  if (month % 2 == 1) {
                    //  홀수 달만 표시
                    return Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        "$month월",
                        style: Theme.of(context).textTheme.bodySmall, // 🔹 적용
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          gridData: FlGridData(show: true), //  그리드 활성화
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  //  막대 데이터 변환 함수
  List<BarChartGroupData> _buildBarGroups(bool isPageChart) {
    List<MonthlyReadingData> data = yearlyData[selectedYear] ?? [];

    return data.map((data) {
      return BarChartGroupData(
        x: data.month,
        barRods: [
          BarChartRodData(
            toY: isPageChart
                ? data.pageCount.toDouble()
                : data.bookCount.toDouble(),
            color: Theme.of(context).colorScheme.primary,
            width: 14,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }
}
