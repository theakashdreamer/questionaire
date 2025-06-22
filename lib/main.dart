import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questionaire/mvvm_implementation/core/api/post_api.dart';
import 'package:questionaire/mvvm_implementation/core/constants/app_constants.dart';
import 'package:questionaire/mvvm_implementation/core/constants/shared_pref_helper.dart' show SharedPrefHelper;
import 'package:questionaire/mvvm_implementation/core/router/router.dart' as router;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:questionaire/mvvm_implementation/viewmodel/auth_view_model.dart' show AuthViewModel;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isLoggedIn = await SharedPrefHelper().getLoginStatus();

  final dio = Dio(BaseOptions(baseUrl: 'https://spassess.technosysservicesdemos.com/api/'));
  final postApi = PostApi(dio);

  runApp(
    MultiProvider(
      providers: [
        Provider<PostApi>.value(value: postApi),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter MVVM Auth',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: isLoggedIn ? RoutePaths.DashboardScreen : RoutePaths.login,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}



