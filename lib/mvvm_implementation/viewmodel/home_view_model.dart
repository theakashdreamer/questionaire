import 'package:questionaire/mvvm_implementation/core/api/post_api.dart';
import 'package:questionaire/mvvm_implementation/core/model/org_qual_course.dart';
import 'package:questionaire/mvvm_implementation/core/model/subject.dart';
import 'package:questionaire/mvvm_implementation/core/model/unitChapter.dart' show UnitChapter;
import 'package:questionaire/mvvm_implementation/viewmodel/base_view_model.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
class HomeViewModel extends BaseModel {
  HomeViewModel({required this.postApi});

  final PostApi postApi;
  bool busy = false;
  List<OrgQualCourse> classList = [];
  List<Subject> subjectList = [];
  List<UnitChapter> unitChapterList = [];
  @override
  Future<void> initModel() async {
    // Optional: fetch data on screen load
    // You can comment this out if you only want data on button click
    await fetchClassMasterData();
  }


  Future<void> fetchClassMasterData() async {
    print('🔄 API CALL: Fetching Class Master Data...');
    try {
      setBusy(true); // ⬅️ Sets busy = true + notifyListeners()

      final response = await postApi.getClassMasterDataThreeToFive();
      final code = response.response.statusCode ?? 0;

      if (code >= 200 && code < 300) {
        classList = response.data;
        print('✅ Class Master Data Fetched: ${classList.length} items');
      } else {
        print('⚠️ API failed with status: $code');
      }
    } catch (e) {
      print('❌ Error: $e');
    } finally {
      setBusy(false); // ⬅️ Sets busy = false + notifyListeners()
    }
  }

  Future<void> fetchSubjectsByClassId(String classId) async {
    print('🔄 API CALL: Fetching subjects for class ID $classId...');
    try {
      final response = await postApi.getSubjectsAccToClassId(classId);
      final code = response.response.statusCode ?? 0;

      if (code >= 200 && code < 300) {
        subjectList = response.data;
        print('✅ Subjects fetched: ${subjectList.length}');
        notifyListeners(); // 🔔 Ensure the UI gets updated
      } else {
        print('⚠️ API failed with status: $code');
      }
    } catch (e) {
      print('❌ Error fetching subjects: $e');
    }
  }

  Future<void> fetchLessonAccToSubject(String classId,String subject) async {
    print('🔄 API CALL: Fetching subjects for class ID $classId...');
    try {
      final response = await postApi.getLessonAccToSubject(classId,subject);
      final code = response.response.statusCode ?? 0;

      if (code >= 200 && code < 300) {
        unitChapterList = response.data;
        print('✅ Subjects fetched: ${unitChapterList.length}');
        notifyListeners(); // 🔔 Ensure the UI gets updated
      } else {
        print('⚠️ API failed with status: $code');
      }
    } catch (e) {
      print('❌ Error fetching subjects: $e');
    }
  }




  void setBusy(bool value) {
    busy = value;
    notifyListeners(); // 🔔 this is the key to updating the UI
  }
}


