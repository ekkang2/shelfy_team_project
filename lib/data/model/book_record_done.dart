import 'book.dart';

class BookRecordDone {
  final int recordId; // 책 기록 아이디
  final int userId; // 유저 아이디
  final DateTime startDate; // 시작일
  final DateTime endDate; // 종료일
  final double rating; // 별점
  final Book book;
  final String? comment; // 코멘트

  // 생성자
  BookRecordDone({
    required this.recordId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    this.rating = 0,
    required this.book,
    this.comment,
  });
}

List<BookRecordDone> doneBookList = [
  BookRecordDone(
    recordId: 1,
    userId: 101,
    startDate: DateTime(2025, 1, 10),
    endDate: DateTime(2025, 1, 20),
    rating: 4.5,
    comment: '재미있게 읽었습니다!',
    book: bookList[0],
  ),
  BookRecordDone(
    recordId: 2,
    userId: 102,
    startDate: DateTime(2025, 1, 15),
    endDate: DateTime(2025, 1, 30),
    rating: 3.5,
    comment: '프로그래밍 초보자가 읽기 딱 좋아요!',
    book: bookList[1],
  ),
  BookRecordDone(
    recordId: 3,
    userId: 103,
    startDate: DateTime(2025, 1, 20),
    endDate: DateTime(2025, 1, 25),
    rating: 5.0,
    comment: '우주 탐험 이야기 정말 멋집니다!',
    book: bookList[2],
  ),
  BookRecordDone(
    recordId: 4,
    userId: 104,
    startDate: DateTime(2025, 2, 1),
    endDate: DateTime(2025, 2, 10),
    rating: 2.0,
    comment: 'AI 기술에 대해 많이 배웠습니다.',
    book: bookList[3],
  ),
  BookRecordDone(
    recordId: 5,
    userId: 105,
    startDate: DateTime(2025, 2, 5),
    endDate: DateTime(2025, 2, 15),
    rating: 3.0,
    comment: '자연 보호에 대한 귀중한 메시지를 주네요.',
    book: bookList[4],
  ),
  BookRecordDone(
    recordId: 6,
    userId: 106,
    startDate: DateTime(2025, 2, 10),
    endDate: DateTime(2025, 2, 20),
    rating: 4.0,
    comment: '행복에 대해 다시 생각해보는 계기가 되었습니다.',
    book: bookList[5],
  ),
  BookRecordDone(
    recordId: 7,
    userId: 107,
    startDate: DateTime(2025, 2, 15),
    endDate: DateTime(2025, 2, 25),
    rating: 3.5,
    comment: '미래 직업 트렌드에 대해 알 수 있어요.',
    book: bookList[6],
  ),
  BookRecordDone(
    recordId: 8,
    userId: 108,
    startDate: DateTime(2025, 2, 20),
    endDate: DateTime(2025, 3, 1),
    rating: 4.5,
    comment: '창의성을 기르기 좋은 팁이 많습니다!',
    book: bookList[7],
  ),
  BookRecordDone(
    recordId: 9,
    userId: 109,
    startDate: DateTime(2025, 2, 25),
    endDate: DateTime(2025, 3, 5),
    rating: 4.0,
    comment: '모험 이야기가 정말 흥미롭습니다!',
    book: bookList[8],
  ),
  BookRecordDone(
    recordId: 10,
    userId: 110,
    startDate: DateTime(2025, 3, 1),
    endDate: DateTime(2025, 3, 10),
    rating: 5.0,
    comment: '다가오는 미래에 대해 통찰을 얻었어요.',
    book: bookList[9],
  ),
  BookRecordDone(
    recordId: 11,
    userId: 111,
    startDate: DateTime(2025, 3, 5),
    endDate: DateTime(2025, 3, 15),
    rating: 2.5,
    comment: '음악의 힘을 느낄 수 있는 책입니다.',
    book: bookList[10],
  ),
  BookRecordDone(
    recordId: 12,
    userId: 112,
    startDate: DateTime(2025, 3, 10),
    endDate: DateTime(2025, 3, 20),
    rating: 3.0,
    comment: '디지털 커뮤니케이션의 미래를 알 수 있어요.',
    book: bookList[11],
  ),
  BookRecordDone(
    recordId: 13,
    userId: 113,
    startDate: DateTime(2025, 3, 15),
    endDate: DateTime(2025, 3, 25),
    rating: 4.0,
    comment: '미래 기술에 대한 통찰을 얻었습니다.',
    book: bookList[12],
  ),
  BookRecordDone(
    recordId: 14,
    userId: 114,
    startDate: DateTime(2025, 3, 20),
    endDate: DateTime(2025, 3, 30),
    rating: 4.5,
    comment: '뇌와 인지 과학에 대해 배울 수 있어요.',
    book: bookList[13],
  ),
  BookRecordDone(
    recordId: 15,
    userId: 115,
    startDate: DateTime(2025, 3, 25),
    endDate: DateTime(2025, 4, 5),
    rating: 3.5,
    comment: '지속 가능한 발전에 대해 생각하게 되네요.',
    book: bookList[14],
  ),
];
