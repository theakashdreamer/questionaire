import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:questionaire/mvvm_implementation/core/constants/app_constants.dart';
import 'package:questionaire/mvvm_implementation/core/views/dashboardScreen.dart';
import 'package:questionaire/mvvm_implementation/core/views/loginmodules/login_view.dart' show LoginView;
import 'package:questionaire/mvvm_implementation/core/views/loginmodules/register_view.dart';
import 'package:questionaire/mvvm_implementation/core/views/mvvm_provider_view.dart';


class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.register:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case RoutePaths.login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RoutePaths.mvvmScreen:
        return MaterialPageRoute(builder: (_) => MvvmProviderView());
      case RoutePaths.DashboardScreen:
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
