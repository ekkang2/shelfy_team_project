import 'package:intl/intl.dart';

import 'book.dart';

class BookRecordDoing {
  final int recordId; // 책 기록 아이디
  final int userId; // 유저 아이디
  final DateTime startDate; // 시작일
  final int currentPage; // 현재 페이지
  final String? comment; // 코멘트

  // 책
  final Book book;

  // 생성자
  BookRecordDoing({
    required this.recordId,
    required this.userId,
    required this.startDate,
    this.currentPage = 0,
    this.comment,
    required this.book,
  });

  String ceilProgressPages() {
    return ((this.currentPage / this.book.book_page) * 100).toStringAsFixed(1);
  }

  double progressPages() {
    return (this.currentPage / this.book.book_page) * 100;
  }

  String formatSingleDateByKor(DateTime time) {
    final dateFormatter = DateFormat('yyyy년 MM월 dd일');
    return dateFormatter.format(time);
  }

  String formatSingleDate(DateTime time) {
    final dateFormatter = DateFormat('yyyy.MM.dd');
    return dateFormatter.format(time);
  }
}

List<BookRecordDoing> doingBookList = [
  BookRecordDoing(
    recordId: 1,
    userId: 101,
    startDate: DateTime(2025, 1, 10),
    currentPage: 50,
    comment: '재미있게 읽는 중!',
    book: bookList[0],
  ),
  BookRecordDoing(
    recordId: 2,
    userId: 102,
    startDate: DateTime(2025, 1, 15),
    currentPage: 300,
    comment: '프로그래밍 초보자가 읽기 좋아요!',
    book: bookList[1],
  ),
  BookRecordDoing(
    recordId: 3,
    userId: 103,
    startDate: DateTime(2025, 1, 20),
    currentPage: 80,
    comment: '우주 탐험 이야기 너무 흥미진진합니다.',
    book: bookList[2],
  ),
  BookRecordDoing(
    recordId: 4,
    userId: 104,
    startDate: DateTime(2025, 2, 1),
    currentPage: 60,
    comment: 'AI 기술에 대해 배우는 중!',
    book: bookList[3],
  ),
  BookRecordDoing(
    recordId: 5,
    userId: 105,
    startDate: DateTime(2025, 2, 5),
    currentPage: 150,
    comment: '자연과 환경 보호에 대한 중요한 메시지를 담은 책!',
    book: bookList[4],
  ),
  BookRecordDoing(
    recordId: 6,
    userId: 106,
    startDate: DateTime(2025, 2, 10),
    currentPage: 100,
    comment: '행복에 대한 새로운 통찰을 얻고 있습니다.',
    book: bookList[5],
  ),
  BookRecordDoing(
    recordId: 7,
    userId: 107,
    startDate: DateTime(2025, 2, 15),
    currentPage: 75,
    comment: '미래 직업 트렌드에 대해 공부하고 있어요.',
    book: bookList[6],
  ),
  BookRecordDoing(
    recordId: 8,
    userId: 108,
    startDate: DateTime(2025, 2, 20),
    currentPage: 130,
    comment: '창의성을 기르는 팁이 많아요!',
    book: bookList[7],
  ),
  BookRecordDoing(
    recordId: 9,
    userId: 109,
    startDate: DateTime(2025, 2, 25),
    currentPage: 200,
    comment: '모험 이야기가 정말 흥미롭습니다.',
    book: bookList[8],
  ),
  BookRecordDoing(
    recordId: 10,
    userId: 110,
    startDate: DateTime(2025, 3, 1),
    currentPage: 50,
    comment: '다가오는 미래에 대한 통찰을 얻고 있어요.',
    book: bookList[9],
  ),
  BookRecordDoing(
    recordId: 11,
    userId: 111,
    startDate: DateTime(2025, 3, 5),
    currentPage: 90,
    comment: '음악의 힘에 대해 깊이 공감하고 있습니다.',
    book: bookList[10],
  ),
  BookRecordDoing(
    recordId: 12,
    userId: 112,
    startDate: DateTime(2025, 3, 10),
    currentPage: 45,
    comment: '디지털 커뮤니케이션에 대해 배우고 있습니다.',
    book: bookList[11],
  ),
  BookRecordDoing(
    recordId: 13,
    userId: 113,
    startDate: DateTime(2025, 3, 15),
    currentPage: 70,
    comment: '미래 기술에 대해 정말 많은 인사이트를 얻고 있어요.',
    book: bookList[12],
  ),
  BookRecordDoing(
    recordId: 14,
    userId: 114,
    startDate: DateTime(2025, 3, 20),
    currentPage: 160,
    comment: '뇌와 인지 과학에 대한 새로운 지식을 배우는 중입니다.',
    book: bookList[13],
  ),
  BookRecordDoing(
    recordId: 15,
    userId: 115,
    startDate: DateTime(2025, 3, 25),
    currentPage: 110,
    comment: '지속 가능한 발전에 대해 깊이 고민하게 되네요.',
    book: bookList[14],
  ),
];
