import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class OrgQualCourse {
  @JsonKey(name: 'OrgQualCourse_Id')
  final String? id;

  @JsonKey(name: 'OrgQualCourse_Title')
  final String? title;

  @JsonKey(name: 'OrgQualCourse_HName')
  final String? hindiName;

  @JsonKey(name: 'OrgQualCourse_Description')
  final String? description;

  @JsonKey(name: 'Class_Name')
  final String? className;

  @JsonKey(name: 'ULP_ClassName')
  final String? ulpClassName;

  OrgQualCourse({
    required this.id,
    required this.title,
    required this.hindiName,
    required this.description,
    required this.className,
    required this.ulpClassName,
  });

  factory OrgQualCourse.fromJson(Map<String, dynamic> json) {
    return OrgQualCourse(
      id: json['OrgQualCourse_Id'].toString(),
      title: json['OrgQualCourse_Title'] ?? '',
      hindiName: json['OrgQualCourse_HName'] ?? '',
      description: json['OrgQualCourse_Description'] ?? '',
      className: json['Class_Name'] ?? '',
      ulpClassName: json['ULP_ClassName'] ?? '',
    );
  }
}
