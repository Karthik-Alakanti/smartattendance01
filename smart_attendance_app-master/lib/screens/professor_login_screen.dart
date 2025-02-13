import 'package:flutter/material.dart';
import 'professor_dashboard.dart';

class ProfessorLoginScreen extends StatefulWidget {
  @override
  _ProfessorLoginScreenState createState() => _ProfessorLoginScreenState();
}

class _ProfessorLoginScreenState extends State<ProfessorLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // 🔹 Make sure these are correct
  final String professorEmail = "professor@example.com";
  final String professorPassword = "password123";

  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == professorEmail && password == professorPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfessorDashboard()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Invalid email or password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Professor Login")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}
