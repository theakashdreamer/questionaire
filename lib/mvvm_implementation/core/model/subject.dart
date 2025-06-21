import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class Subject {
  @JsonKey(name: 'Subjects_Id')
  final String? id;

  @JsonKey(name: 'Subjects_Name')
  final String? name;

  @JsonKey(name: 'Subjects_HName')
  final String? hindiName;

  @JsonKey(name: 'ClassId')
  final String? classId;

  Subject({
    required this.id,
    required this.name,
    required this.hindiName,
    this.classId,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['Subjects_Id']?.toString(),
      name: json['Subjects_Name'] ?? '',
      hindiName: json['Subjects_HName'] ?? '',
      classId: json['ClassId']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'Subjects_Id': id,
    'Subjects_Name': name,
    'Subjects_HName': hindiName,
    'ClassId': classId,
  };
}

