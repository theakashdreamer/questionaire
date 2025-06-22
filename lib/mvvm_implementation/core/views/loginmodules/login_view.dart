import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questionaire/mvvm_implementation/core/views/dashboardScreen.dart';
import 'package:questionaire/mvvm_implementation/core/views/loginmodules/register_view.dart' show RegisterView;
import 'package:questionaire/mvvm_implementation/viewmodel/auth_view_model.dart' show AuthViewModel;


class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
                final success = await auth.login(emailController.text, passwordController.text);
                if (success) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  DashboardScreen()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid credentials")));
                }
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterView())),
              child: const Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
