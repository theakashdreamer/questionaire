import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questionaire/mvvm_implementation/core/api/post_api.dart';
import 'package:questionaire/mvvm_implementation/core/constants/app_constants.dart';
import 'package:questionaire/mvvm_implementation/core/router/router.dart' as router;
import 'package:provider/provider.dart';
void main() {
  final dio = Dio(BaseOptions(baseUrl: 'https://spassess.technosysservicesdemos.com/api/'));
  final postApi = PostApi(dio);
  runApp(
    MultiProvider(
      providers: [
        Provider<PostApi>.value(value: postApi),
      ],
      child: MyApp(),
    )
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RoutePaths.DashboardScreen,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}



