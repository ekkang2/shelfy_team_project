class Note {
  final int? noteId;
  final int userId;
  final String title;
  final String content;
  final String? bookId;
  final bool notePin; // 북마크 필드 추가
  final String createdAt; // ✅ 추가 (서버에서 받아온 날짜)

  Note({
    this.noteId, // ✅ 기존 노트는 값 있음, 새 노트는 null 가능
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
      noteId: json['noteId'] as int?, // ✅ 기존 데이터에는 존재
      userId: json['noteUserId'] != null
          ? json['noteUserId'] as int
          : 0, // ✅ null 방지 (기본값 0)
      title: json['noteTitle'] ?? '제목 없음', // ✅ null 방지
      content: json['noteContents'] ?? '내용 없음', // ✅ null 방지
      bookId: json['noteRStateId'] as String?,
      notePin: json['notePin'] as bool? ?? false,
      createdAt: json['noteCreatedAt'] ?? '', // ✅ 원본 문자열 그대로 저장
    );
  }

  // ✅ Note 객체 → JSON 변환
  Map<String, dynamic> toJson() {
    return {
      "noteId": noteId,
      "noteUserId": userId,
      "noteTitle": title,
      "noteContents": content,
      "noteRStateId": bookId,
      "notePin": notePin,
      "noteCreatedAt": createdAt,
    };
  }
}
