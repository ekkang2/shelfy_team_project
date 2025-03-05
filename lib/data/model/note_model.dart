class Note {
  final int? noteId;
  final int userId;
  final String title;
  final String content;
  final int? bookId; // String? → int? 로 변경
  final bool notePin; // 북마크 필드 추가
  final String createdAt;
  final String? updatedAt;

  Note({
    this.noteId, //  기존 노트는 값 있음, 새 노트는 null 가능
    required this.userId,
    required this.title,
    required this.content,
    this.bookId,
    this.notePin = false, // 기본값 설정
    required this.createdAt,
    this.updatedAt,
  });

  //  JSON → Note 객체 변환 (fromJson 추가)
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      noteId: json['noteId'] as int?, // 기존 데이터에는 존재
      userId: json['noteUserId'] != null
          ? json['noteUserId'] as int
          : 0, //  null 방지 (기본값 0)
      title: json['noteTitle'] ?? '제목 없음', // null 방지
      content: json['noteContents'] ?? '내용 없음', // null 방지
      bookId: json['noteRStateId'] != null
          ? int.tryParse(json['noteRStateId'].toString())
          : null,
      notePin: json['notePin'] as bool? ?? false,
      createdAt: json['noteCreatedAt'] ?? '', // 원본 문자열 그대로 저장
      updatedAt: json['noteUpdatedAt'], // 수정 날짜 추가 (서버에서 받아옴)
    );
  }

  //  Note 객체 → JSON 변환
  Map<String, dynamic> toJson() {
    return {
      "noteId": noteId,
      "noteUserId": userId,
      "noteTitle": title,
      "noteContents": content,
      "noteRStateId": bookId, // int? 그대로 저장
      "notePin": notePin,
      "noteCreatedAt": createdAt,
      "noteUpdatedAt": updatedAt,
    };
  }

  //  copyWith 함수 추가 (새로운 값만 업데이트)
  Note copyWith({
    int? noteId,
    int? userId,
    String? title,
    String? content,
    int? bookId, //  기존 String? → int? 변경
    bool? notePin,
    String? createdAt,
    String? updatedAt,
  }) {
    return Note(
      noteId: noteId ?? this.noteId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      bookId: bookId ?? this.bookId, //  타입 일치
      notePin: notePin ?? this.notePin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
