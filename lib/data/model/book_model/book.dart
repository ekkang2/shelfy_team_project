/**
 * 2025/02/05 강은경
 * book model 생성
 */

class Book {
  String? bookId;
  String? bookImage;
  String? bookTitle;
  String? bookDesc;
  String? bookAuthor;
  String? bookPublisher;
  String? bookIsbn;
  int? bookPage;
  String? bookPublishedAt;

  Book({
    required this.bookId,
    required this.bookImage,
    required this.bookTitle,
    required this.bookDesc,
    required this.bookAuthor,
    required this.bookPublisher,
    required this.bookIsbn,
    required this.bookPage,
    required this.bookPublishedAt,
  });

  // JSON 데이터를 Book 객체로 변환하는 메서드
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bookId: json['bookId'],
      bookImage: json['bookImage'],
      bookTitle: json['bookTitle'],
      bookDesc: json['bookDesc'],
      bookAuthor: json['bookAuthor'],
      bookPublisher: json['bookPublisher'],
      bookIsbn: json['bookIsbn'],
      bookPage: json['bookPage'],
      bookPublishedAt: json['bookPublishedAt'],
    );
  }
}
