class Note {
  final int userId;
  final String title;
  final String content;
  final String? bookId;
  final bool notePin; // 북마크 필드 추가
  final String createdAt; // ✅ 추가 (서버에서 받아온 날짜)

  Note({
    required this.userId,
    required this.title,
    required this.content,
    this.bookId,
    this.notePin = false, // 기본값 설정
    required this.createdAt,
  });

  // ✅ JSON → Note 객체 변환 (fromJson 추가)
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      userId: json['noteUserId'] as int,
      title: json['noteTitle'] as String,
      content: json['noteContents'] as String,
      bookId: json['noteRStateId'] as String?,
      notePin: json['notePin'] as bool? ?? false, // null이면 기본값 false
      createdAt: json['noteCreatedAt'] as String,
    );
  }

  // ✅ Note 객체 → JSON 변환
  Map<String, dynamic> toJson() {
    return {
      "noteUserId": userId,
      "noteTitle": title,
      "noteContents": content,
      "noteRStateId": bookId,
      "notePin": notePin,
      "noteCreatedAt": createdAt,
      "noteCreatedAt": createdAt
    };
  }
}
