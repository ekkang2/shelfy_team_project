/*
     날짜 : 2025/02/05
     이름 : 박경림
     내용 : 노트 모델 추가 - 데이터 정의
*/
class Note {
  final int userId;
  final String title;
  final String content;
  final String? bookId;

  Note({
    required this.userId,
    required this.title,
    required this.content,
    this.bookId,
  });

  // JSON 변환 메서드
  Map<String, dynamic> toJson() {
    return {
      "noteUserId": userId,
      "noteTitle": title,
      "noteContents": content,
      "noteRStateId": bookId,
      "notePin": false,
    };
  }
}
