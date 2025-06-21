import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:questionaire/mvvm_implementation/core/api/post_api.dart';


List<SingleChildWidget> providers = <SingleChildWidget>[
  ...apiServices,
];

List<SingleChildWidget> apiServices = <SingleChildWidget>[
  Provider<PostApi>(
    create: (_) => PostApi(
      Dio(
        BaseOptions(
          contentType: "application/json",
          baseUrl: 'https://spassess.technosysservicesdemos.com/api/',
        ),
      ),
    ),
  )
];
