class RecordData {
  DateTime? startDate;
  DateTime? endDate;
  String? comment;
  int? progress;
  double? rating;

  RecordData(
      {required this.startDate,
      required this.endDate,
      required this.comment,
      required this.progress,
      required this.rating});
}
