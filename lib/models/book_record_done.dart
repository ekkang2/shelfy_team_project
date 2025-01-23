class BookRecordDone {
  final int recordId; // 책 기록 아이디
  final int bookId; // 책 아이디
  final int userId; // 유저 아이디
  final DateTime startDate; // 시작일
  final DateTime? endDate; // 종료일
  final int currentPage; // 현재 페이지
  final double rating; // 별점
  final String? comment; // 코멘트

  // 생성자
  BookRecordDone({
    required this.recordId,
    required this.bookId,
    required this.userId,
    required this.startDate,
    this.endDate,
    required this.currentPage,
    required this.rating,
    this.comment,
  });
  //
  // // 진행도 계산 (퍼센트)
  // double get progress {
  //   if (totalPage == 0) return 0.0;
  //   return (currentPage / totalPage) * 100;
  // }
  //
  // // JSON 직렬화
  // Map<String, dynamic> toJson() {
  //   return {
  //     'recordId': recordId,
  //     'bookId': bookId,
  //     'userId': userId,
  //     'startDate': startDate.toIso8601String(),
  //     'endDate': endDate.toIso8601String(),
  //     'currentPage': currentPage,
  //     'totalPage': totalPage,
  //     'rating': rating,
  //     'comment': comment,
  //   };
  // }
  //
  // // JSON 역직렬화
  // factory BookRecord.fromJson(Map<String, dynamic> json) {
  //   return BookRecord(
  //     recordId: json['recordId'],
  //     bookId: json['bookId'],
  //     userId: json['userId'],
  //     startDate: DateTime.parse(json['startDate']),
  //     endDate: DateTime.parse(json['endDate']),
  //     currentPage: json['currentPage'],
  //     totalPage: json['totalPage'],
  //     rating: json['rating'].toDouble(),
  //     comment: json['comment'],
  //   );
  // }
  //
  // // toString() 메서드
  // @override
  // String toString() {
  //   return 'BookRecord(recordId: $recordId, bookId: $bookId, userId: $userId, startDate: $startDate, endDate: $endDate, currentPage: $currentPage, totalPage: $totalPage, progress: ${progress.toStringAsFixed(2)}%, rating: $rating, comment: $comment)';
  // }
}
