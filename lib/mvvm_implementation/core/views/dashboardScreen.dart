import 'package:camera/camera.dart' show availableCameras;
import 'package:flutter/material.dart';
import 'package:questionaire/camera/camera_x_view.dart' show CameraXView;
import 'package:questionaire/mvvm_implementation/core/constants/shared_pref_helper.dart' show SharedPrefHelper;
import 'package:questionaire/mvvm_implementation/core/views/loginmodules/user_details_drawer.dart';
import 'package:questionaire/styles/appTextStyles.dart' show AppTextStyles;
import '../constants/app_constants.dart';
import 'mvvm_provider_view.dart';
import 'package:flutter/material.dart';
 // adjust path as needed

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.architecture, 'title': 'MVVM'},
    {'icon': Icons.camera_alt_outlined, 'title': 'Camera'},
    {'icon': Icons.miscellaneous_services, 'title': 'Service'},
    {'icon': Icons.notifications_active, 'title': 'Notification'},
    {'icon': Icons.flutter_dash, 'title': 'GetX'},
    {'icon': Icons.settings_suggest, 'title': 'State management'},
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
            child: Builder(
              builder: (context) => GestureDetector(
                onTap: () => Scaffold.of(context).openEndDrawer(),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
      endDrawer: const UserDetailsDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: menuItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    const SizedBox(height: 10),
                    Text(
                      menuItems[index]['title'],
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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

  Future<void> handleMenuTap(BuildContext context, String title) async {
    switch (title) {
      case 'MVVM':
        Navigator.pushNamed(context, RoutePaths.mvvmScreen);
        break;
      case 'Camera':
        Navigator.pushNamed(context, RoutePaths.CameraXView);
        break;
      default:
        debugPrint('No matching route for $title');

    }
  }

}
