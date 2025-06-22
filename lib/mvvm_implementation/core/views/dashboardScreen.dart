import 'package:flutter/material.dart';
import 'package:questionaire/mvvm_implementation/core/constants/shared_pref_helper.dart' show SharedPrefHelper;
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
    {'icon': Icons.face_retouching_natural, 'title': 'FaceWork'},
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
            child: GestureDetector(
              onTap: () => _showUserDetailsBottomSheet(context),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
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

  void handleMenuTap(BuildContext context, String title) {
    switch (title) {
      case 'MVVM':
        Navigator.pushNamed(context, RoutePaths.mvvmScreen);
        break;
    // Add other routes here if needed
    }
  }

  void _showUserDetailsBottomSheet(BuildContext context) async {
    final email = await SharedPrefHelper().getUserEmail();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person, size: 40, color: Colors.blue),
              const SizedBox(height: 8),
              Text(email ?? "Unknown User", style: const TextStyle(fontSize: 16)),
              const Divider(height: 20),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Logout"),
                onTap: () async {
                  await SharedPrefHelper().logout();
                  if (context.mounted) {
                    Navigator.pop(context); // Close bottom sheet
                    Navigator.pushReplacementNamed(context, RoutePaths.login);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
