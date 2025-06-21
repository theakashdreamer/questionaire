// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:questionaire/mvvm_implementation/core/model/org_qual_course.dart';
import 'package:questionaire/mvvm_implementation/core/model/subject.dart';


class ApiService {
  final String baseUrl = "https://spassess.technosysservicesdemos.com/api/";

  Future<List<OrgQualCourse>> fetchClassMasterData() async {
    final response = await http.get(Uri.parse("${baseUrl}SubjectLession?mode=GetClassMasterDataThreeToFive"));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => OrgQualCourse.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load class data');
    }
  }

  Future<List<Subject>> fetchSubjects(String classId) async {
    final response = await http.get(Uri.parse("${baseUrl}SubjectLession?mode=GetSubjectsAccToClassId&ClassID=$classId"));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Subject.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load subjects');
    }
  }
}
