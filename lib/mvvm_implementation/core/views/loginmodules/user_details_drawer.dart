import 'package:flutter/material.dart';
import 'package:questionaire/mvvm_implementation/core/constants/app_constants.dart' show RoutePaths;
import 'package:questionaire/mvvm_implementation/core/database/user_dao.dart' show UserDAO;
import 'package:questionaire/mvvm_implementation/core/model/user_model.dart' show UserModel;

import '../../constants/shared_pref_helper.dart';


class UserDetailsDrawer extends StatelessWidget {
  const UserDetailsDrawer({super.key});

  Future<UserModel?> _loadUserFromDB() async {
    final email = await SharedPrefHelper().getUserEmail();
    if (email != null) {
      return await UserDAO().getUserByEmail(email);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<UserModel?>(
        future: _loadUserFromDB(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data;
          if (user == null) {
            return const Center(child: Text("User not found"));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  user.email,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Password: ${user.password}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              const Divider(height: 32),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Logout'),
                onTap: () async {
                  await SharedPrefHelper().logout();
                  Navigator.pop(context); // Close drawer
                  Navigator.pushReplacementNamed(context, RoutePaths.login);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
