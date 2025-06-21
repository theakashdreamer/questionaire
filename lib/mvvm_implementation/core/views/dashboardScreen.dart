import 'package:flutter/material.dart';
import 'package:questionaire/styles/appTextStyles.dart' show AppTextStyles;

import '../constants/app_constants.dart';
import 'mvvm_provider_view.dart';
class DashboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.architecture, 'title': 'MVVM'},               // MVVM => Architecture/design pattern
    {'icon': Icons.face_retouching_natural, 'title': 'FaceWork'}, // FaceWork => Face icon
    {'icon': Icons.miscellaneous_services, 'title': 'Service'},   // Service => Services icon
    {'icon': Icons.notifications_active, 'title': 'Notification'},// Notification => Active bell icon
    {'icon': Icons.flutter_dash, 'title': 'GetX'},                // GetX => Flutter mascot (if using Flutter's icon)
    {'icon': Icons.settings_suggest, 'title': 'State management'},// State Management => Gear/settings icon
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basic TO Advance", style: AppTextStyles.appBarTitle),
        backgroundColor: Colors.blue[800],
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blue),
            )
            ,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: menuItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: InkWell(
                  onTap: () => handleMenuTap(context, menuItems[index]['title']),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(menuItems[index]['icon'], size: 40, color: Colors.blue),
                    SizedBox(height: 10),
                    Text(
                      menuItems[index]['title'],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void handleMenuTap(BuildContext context, String title) {
    // Navigate using named routes
    switch (title) {
      case 'MVVM':
        Navigator.pushNamed(context, RoutePaths.mvvmScreen);
        break;
/*      case 'FaceWork':
        Navigator.pushNamed(context, RoutePaths.faceWorkScreen);
        break;
      case 'Service':
        Navigator.pushNamed(context, RoutePaths.serviceScreen);
        break;
      case 'Notification':
        Navigator.pushNamed(context, RoutePaths.notificationScreen);
        break;
      case 'GetX':
        Navigator.pushNamed(context, RoutePaths.getxScreen);
        break;
      case 'State management':
        Navigator.pushNamed(context, RoutePaths.stateManagementScreen);
        break;*/
      default:
        break;
    }
  }

}