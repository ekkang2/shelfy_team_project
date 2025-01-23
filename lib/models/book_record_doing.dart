class BookRecordDoing {
  final int recordId; // 책 기록 아이디
  final int userId; // 유저 아이디
  final DateTime startDate; // 시작일
  final int currentPage; // 현재 페이지
  final String? comment; // 코멘트

  // 책
  final int bookId;
  final int totalPage;
  final String book_image;
  final String book_title;
  final String book_author;

  // 생성자
  BookRecordDoing({
    required this.recordId,
    required this.userId,
    required this.startDate,
    this.currentPage = 0,
    this.comment,
    required this.bookId,
    required this.book_image,
    required this.book_title,
    required this.book_author,
    required this.totalPage,
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

List<BookRecordDoing> bookRecordDoingList = [
  BookRecordDoing(
    recordId: 1,
    userId: 1,
    startDate: DateTime(2025, 1, 1),
    currentPage: 50,
    bookId: 1,
    book_image:
        'https://image.aladin.co.kr/product/35548/1/coversum/k402036379_1.jpg',
    book_title: '내일은 한강 - 본격 소녀 성장만화',
    book_author: '별미디어 지음',
    totalPage: 260,
  ),
  BookRecordDoing(
    recordId: 2,
    userId: 2,
    startDate: DateTime(2025, 1, 5),
    currentPage: 120,
    bookId: 2,
    book_image:
        'https://image.aladin.co.kr/product/35422/9/coversum/894608362x_1.jpg',
    book_title: '모두가 사랑하는 프로그래밍',
    book_author: '홍길동 지음',
    totalPage: 320,
  ),
  BookRecordDoing(
    recordId: 3,
    userId: 3,
    startDate: DateTime(2025, 1, 10),
    currentPage: 70,
    bookId: 3,
    book_image:
        'https://image.aladin.co.kr/product/35642/39/coversum/8957945792_1.jpg',
    book_title: '우주 탐험의 역사',
    book_author: '김宇성 지음',
    totalPage: 280,
  ),
  BookRecordDoing(
    recordId: 4,
    userId: 1,
    startDate: DateTime(2025, 2, 1),
    currentPage: 200,
    bookId: 4,
    book_image:
        'https://image.aladin.co.kr/product/35348/3/coversum/8967998635_1.jpg',
    book_title: '인공지능 시대의 생존 전략',
    book_author: '이상훈 지음',
    totalPage: 240,
  ),
  BookRecordDoing(
    recordId: 5,
    userId: 2,
    startDate: DateTime(2025, 3, 1),
    currentPage: 100,
    bookId: 5,
    book_image:
        'https://image.aladin.co.kr/product/35490/34/coversum/k122035558_1.jpg',
    book_title: '자연의 비밀을 탐험하다',
    book_author: '최지우 지음',
    totalPage: 300,
  ),
  BookRecordDoing(
    recordId: 6,
    userId: 3,
    startDate: DateTime(2025, 3, 20),
    currentPage: 80,
    bookId: 6,
    book_image:
        'https://image.aladin.co.kr/product/35146/12/coversum/k142934914_3.jpg',
    book_title: '행복한 삶을 위한 심리학',
    book_author: '이정민 지음',
    totalPage: 220,
  ),
  BookRecordDoing(
    recordId: 7,
    userId: 1,
    startDate: DateTime(2025, 4, 5),
    currentPage: 150,
    bookId: 7,
    book_image:
        'https://image.aladin.co.kr/product/35474/30/coversum/895794575x_1.jpg',
    book_title: '2025년, 미래의 직업',
    book_author: '강성민 지음',
    totalPage: 250,
  ),
  BookRecordDoing(
    recordId: 8,
    userId: 2,
    startDate: DateTime(2025, 5, 1),
    currentPage: 200,
    bookId: 8,
    book_image:
        'https://image.aladin.co.kr/product/35473/92/coversum/8957945776_1.jpg',
    book_title: '창의성을 키우는 방법',
    book_author: '박지윤 지음',
    totalPage: 270,
  ),
  BookRecordDoing(
    recordId: 9,
    userId: 3,
    startDate: DateTime(2025, 6, 15),
    currentPage: 250,
    bookId: 9,
    book_image:
        'https://image.aladin.co.kr/product/35273/82/coversum/8957945741_1.jpg',
    book_title: '모험과 탐험의 세계',
    book_author: '손민재 지음',
    totalPage: 330,
  ),
  BookRecordDoing(
    recordId: 10,
    userId: 1,
    startDate: DateTime(2025, 7, 1),
    currentPage: 60,
    bookId: 10,
    book_image:
        'https://image.aladin.co.kr/product/35144/68/coversum/8932043337_1.jpg',
    book_title: '내일의 세상',
    book_author: '윤하 지음',
    totalPage: 190,
  ),
  BookRecordDoing(
    recordId: 11,
    userId: 2,
    startDate: DateTime(2025, 7, 15),
    currentPage: 100,
    bookId: 11,
    book_image:
        'https://image.aladin.co.kr/product/35289/81/coversum/896554307x_1.jpg',
    book_title: '음악의 힘',
    book_author: '김수연 지음',
    totalPage: 240,
  )
];
