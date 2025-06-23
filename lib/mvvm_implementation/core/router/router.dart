import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:questionaire/camera/camera_x_view.dart' show CameraXView;
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
      case RoutePaths.CameraXView:
        return MaterialPageRoute(builder: (_) => CameraXView());
      default:
        return _errorRoute('No route defined for ${settings.name}');
    }
  }
  static Route<dynamic> _errorRoute([String? message]) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text(
            message ?? 'Unknown error occurred!',
            style: const TextStyle(fontSize: 18, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

}
