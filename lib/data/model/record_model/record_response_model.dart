import 'package:intl/intl.dart';

class RecordResponseModel {
  int? stateId;
  String? bookId;
  int? userId;
  int? stateType;

  // User? user;

  DateTime? startDate;
  DateTime? endDate;
  String? comment;
  int? progress;
  double? rating;

  int? recordId;
  String? bookImage;
  String? bookTitle;
  String? bookAuthor;
  String? bookPublisher;

  RecordResponseModel.fromMap(Map<String, dynamic> map)
      : stateId = map["stateId"],
        recordId = map["recordId"],
        userId = map["userId"],
        bookId = map["bookId"],
        bookImage = map["bookImage"],
        bookTitle = map["bookTitle"],
        bookAuthor = map["bookAuthor"],
        bookPublisher = map["bookPublisher"],
        stateType = map["stateType"],
        startDate = DateFormat("yyyy-mm-dd").parse(map["startDate"]),
        endDate = DateFormat("yyyy-mm-dd").parse(map["endDate"]),
        comment = map["comment"],
        progress = map["progress"],
        rating = map["rating"];
}
