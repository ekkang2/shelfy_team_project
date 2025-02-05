class RecordState {
  int? stateId;
  String? bookId;
  int? userId;
  int? stateType;

  DateTime? startDate;
  DateTime? endDate;
  String? comment;
  int? progress;
  double? rating;

  RecordState(
      {required this.stateId,
      required this.bookId,
      required this.userId,
      required this.stateType,
      required this.startDate,
      required this.endDate,
      required this.comment,
      required this.progress,
      required this.rating});
}
