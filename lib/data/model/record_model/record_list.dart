import 'record_response_model.dart';

class RecordList {
  bool isFirst;
  bool isLast;
  int pageNumber;
  int size;
  int totalPages;
  List<RecordResponseModel> records;

  RecordList({
    required this.isFirst,
    required this.isLast,
    required this.pageNumber,
    required this.size,
    required this.totalPages,
    required this.records,
  });

  factory RecordList.fromMap(Map<String, dynamic> map) {
    return RecordList(
      isFirst: map['isFrist'] ?? false,
      isLast: map['isLast'] ?? false,
      pageNumber: map['pageNumber'] ?? 0,
      size: map['size'] ?? 10,
      totalPages: map['totalPage'] ?? 1,
      records: (map['contents'] as List<dynamic>? ?? [])
          .map((e) => RecordResponseModel.fromMap(e))
          .toList(),
    );
  }

  // 깊은 복사 (객체 변경 시 활용)
  RecordList copyWith({
    bool? isFirst,
    bool? isLast,
    int? pageNumber,
    int? size,
    int? totalPage,
    List<RecordResponseModel>? records,
  }) {
    return RecordList(
      isFirst: isFirst ?? this.isFirst,
      isLast: isLast ?? this.isLast,
      pageNumber: pageNumber ?? this.pageNumber,
      size: size ?? this.size,
      totalPages: totalPage ?? this.totalPages,
      records:
          records ?? List<RecordResponseModel>.from(this.records), // 리스트 깊은 복사
    );
  }
}
