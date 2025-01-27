import 'book.dart';

class BookRecordStop {
  final int recordId; // 책 기록 아이디
  final int userId; // 유저 아이디
  final DateTime startDate; // 기록일
  final DateTime endDate; // 중단일
  final double rating; // 별점
  final Book book;
  final String? comment; // 코멘트

  // 생성자
  BookRecordStop({
    required this.recordId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    this.rating = 0,
    required this.book,
    this.comment,
  });
}

List<BookRecordStop> stopBookList = [
  BookRecordStop(
    recordId: 1,
    userId: 201,
    startDate: DateTime(2025, 1, 5),
    endDate: DateTime(2025, 1, 10),
    rating: 2.5,
    book: bookList[0],
    comment: '내용이 조금 지루해서 중단했습니다.',
  ),
  BookRecordStop(
    recordId: 2,
    userId: 202,
    startDate: DateTime(2025, 1, 12),
    endDate: DateTime(2025, 1, 15),
    rating: 3.0,
    book: bookList[1],
    comment: '생각보다 흥미롭지 않았어요.',
  ),
  BookRecordStop(
    recordId: 3,
    userId: 203,
    startDate: DateTime(2025, 1, 20),
    endDate: DateTime(2025, 1, 25),
    rating: 1.5,
    book: bookList[2],
    comment: '기대와 많이 달라서 아쉽습니다.',
  ),
  BookRecordStop(
    recordId: 4,
    userId: 204,
    startDate: DateTime(2025, 2, 1),
    endDate: DateTime(2025, 2, 5),
    rating: 2.0,
    book: bookList[3],
    comment: '중반부가 너무 어렵게 느껴졌어요.',
  ),
  BookRecordStop(
    recordId: 5,
    userId: 205,
    startDate: DateTime(2025, 2, 10),
    endDate: DateTime(2025, 2, 15),
    rating: 3.5,
    book: bookList[4],
    comment: '일부분은 재미있었지만 끝까지 읽지 못했어요.',
  ),
  BookRecordStop(
    recordId: 6,
    userId: 206,
    startDate: DateTime(2025, 2, 20),
    endDate: DateTime(2025, 2, 25),
    rating: 4.0,
    book: bookList[5],
  ),
  BookRecordStop(
    recordId: 7,
    userId: 207,
    startDate: DateTime(2025, 3, 1),
    endDate: DateTime(2025, 3, 5),
    rating: 2.0,
    book: bookList[6],
    comment: '소재는 좋았지만 다소 단조로웠어요.',
  ),
  BookRecordStop(
    recordId: 8,
    userId: 208,
    startDate: DateTime(2025, 3, 10),
    endDate: DateTime(2025, 3, 15),
    rating: 3.0,
    book: bookList[7],
  ),
  BookRecordStop(
    recordId: 9,
    userId: 209,
    startDate: DateTime(2025, 3, 20),
    endDate: DateTime(2025, 3, 25),
    rating: 1.0,
    book: bookList[8],
    comment: '이야기의 전개가 너무 느렸습니다.',
  ),
  BookRecordStop(
    recordId: 10,
    userId: 210,
    startDate: DateTime(2025, 3, 25),
    endDate: DateTime(2025, 3, 30),
    rating: 2.5,
    book: bookList[9],
    comment: '아이디어는 좋았으나 끌리진 않았어요.',
  ),
];
