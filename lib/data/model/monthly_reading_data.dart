// 독서 통계용 임시 모델
class MonthlyReadingData {
  final int month; // 몇 월
  final int bookCount; // 읽은 권수
  final int pageCount; // 읽은 페이지 수

  MonthlyReadingData({
    required this.month,
    required this.bookCount,
    required this.pageCount,
  });
}
