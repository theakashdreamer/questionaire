import 'package:dio/dio.dart';
import 'package:questionaire/mvvm_implementation/core/model/org_qual_course.dart';
import 'package:questionaire/mvvm_implementation/core/model/subject.dart';
import 'package:questionaire/mvvm_implementation/core/model/unitChapter.dart' show UnitChapter;
import 'package:retrofit/retrofit.dart';
part 'post_api.g.dart';

@RestApi()
abstract class PostApi {
  factory PostApi(Dio dio, {String baseUrl}) = _PostApi;

  @GET("SubjectLession?mode=GetClassMasterDataThreeToFive")
  Future<HttpResponse<List<OrgQualCourse>>> getClassMasterDataThreeToFive();

  @GET("SubjectLession?mode=GetSubjectsAccToClassId")
  Future<HttpResponse<List<Subject>>> getSubjectsAccToClassId(
      @Query("ClassID") String classId,
      );

  @GET("SubjectLession?mode=GetLessonAccToSubject")
  Future<HttpResponse<List<UnitChapter>>> getLessonAccToSubject(
      @Query("ClassID") String classId,@Query("SubjectID") String SubjectID,
      );
}
