import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class UnitChapter {
  @JsonKey(name: 'Unit_Id')
  final String? unitId;

  @JsonKey(name: 'Class_Id')
  final String? classId;

  @JsonKey(name: 'Subject_Id')
  final String? subjectId;

  @JsonKey(name: 'Book_Id')
  final String? bookId;

  @JsonKey(name: 'ChapterNameOrLessionName')
  final String? chapterNameOrLessonName;

  UnitChapter({
    required this.unitId,
    required this.classId,
    required this.subjectId,
    required this.bookId,
    required this.chapterNameOrLessonName,
  });

  factory UnitChapter.fromJson(Map<String, dynamic> json) {
    return UnitChapter(
      unitId: json['Unit_Id']?.toString(),
      classId: json['Class_Id']?.toString(),
      subjectId: json['Subject_Id']?.toString(),
      bookId: json['Book_Id']?.toString(),
      chapterNameOrLessonName: json['ChapterNameOrLessionName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'Unit_Id': unitId,
    'Class_Id': classId,
    'Subject_Id': subjectId,
    'Book_Id': bookId,
    'ChapterNameOrLessionName': chapterNameOrLessonName,
  };
}
