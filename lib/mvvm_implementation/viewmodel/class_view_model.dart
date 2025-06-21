// class_view_model.dart
import 'package:flutter/material.dart';
import 'package:questionaire/mvvm_implementation/core/api/api_service.dart';
import 'package:questionaire/mvvm_implementation/core/model/org_qual_course.dart';
import 'package:questionaire/mvvm_implementation/core/model/subject.dart';
class ClassViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();

  List<OrgQualCourse> classList = [];
  List<Subject> subjectList = [];

  bool isLoading = false;

  Future<void> loadClassMasterData() async {
    isLoading = true;
    notifyListeners();
    try {
      classList = await _api.fetchClassMasterData();
    } catch (e) {
      print("Error: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadSubjects(String classId) async {
    isLoading = true;
    notifyListeners();
    try {
      subjectList = await _api.fetchSubjects(classId);
    } catch (e) {
      print("Error: $e");
    }
    isLoading = false;
    notifyListeners();
  }
}
