part of 'post_api.dart';
class _PostApi implements PostApi {
  _PostApi(this._dio, {this.baseUrl});

  final Dio _dio;
  String? baseUrl;
  @override
  Future<HttpResponse<List<OrgQualCourse>>> getClassMasterDataThreeToFive() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};

    final _result = await _dio.fetch<List<dynamic>>(
      _setStreamType<HttpResponse<List<OrgQualCourse>>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(
          _dio.options,
          'SubjectLession?mode=GetClassMasterDataThreeToFive',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
      ),
    );

    final value = _result.data!
        .map((dynamic i) => OrgQualCourse.fromJson(i as Map<String, dynamic>))
        .toList();

    return HttpResponse(value, _result);
  }

  @override
  Future<HttpResponse<List<Subject>>> getSubjectsAccToClassId(String classId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'ClassID': classId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};

    final _result = await _dio.fetch<List<dynamic>>(
      _setStreamType<HttpResponse<List<Subject>>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(
          _dio.options,
          'SubjectLession?mode=GetSubjectsAccToClassId',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
      ),
    );

    final value = _result.data!
        .map((dynamic i) => Subject.fromJson(i as Map<String, dynamic>))
        .toList();

    return HttpResponse(value, _result);
  }
  @override
  Future<HttpResponse<List<UnitChapter>>> getLessonAccToSubject(String classId, String SubjectID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'ClassID': classId,
      'SubjectID': SubjectID
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};

    final _result = await _dio.fetch<List<dynamic>>(
      _setStreamType<HttpResponse<List<UnitChapter>>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(
          _dio.options,
          'SubjectLession?mode=GetLessonAccToSubject',
          queryParameters: queryParameters,
          data: _data,
        ).copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
      ),
    );

    final value = _result.data!
        .map((dynamic i) => UnitChapter.fromJson(i as Map<String, dynamic>))
        .toList();

    return HttpResponse(value, _result);
  }
  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }


}