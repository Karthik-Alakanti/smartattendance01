import 'package:flutter/material.dart';
import 'professor_login_screen.dart';
import 'student_login_screen.dart';

class UserSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select User Type")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfessorLoginScreen()),
                );
              },
              child: Text("Professor"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentLoginScreen()),
                );
              },
              child: Text("Student"),
            ),
          ],
        ),
      ),
    );
  }
}
