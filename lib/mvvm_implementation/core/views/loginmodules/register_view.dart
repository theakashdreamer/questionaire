import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questionaire/mvvm_implementation/core/constants/logger.dart';
import 'package:questionaire/mvvm_implementation/viewmodel/auth_view_model.dart' show AuthViewModel;


class RegisterView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: auth.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                AppLogger.i("📭 No users found.");
                // 🔍 Print all users before attempting registration
                await auth.printUsers(); // Ensure this is implemented in your AuthViewModel

                final success = await auth.register(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );

                if (success) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User already exists or registration failed")),
                  );
                }
              },
              child: const Text('Register'),
            ),

          ],
        ),
      ),
    );
  }
}
