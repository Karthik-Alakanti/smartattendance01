import 'dart:async';
import 'package:flutter/material.dart';
import 'user_selection_screen.dart';  // Logout to user selection

class ProfessorDashboard extends StatefulWidget {
  @override
  _ProfessorDashboardState createState() => _ProfessorDashboardState();
}

class _ProfessorDashboardState extends State<ProfessorDashboard> {
  Map<String, Timer?> timers = {}; // Stores running timers
  Map<String, int> elapsedTimes = {}; // Stores elapsed time in seconds
  Map<String, bool> isClassRunning = {}; // Tracks class state (running or not)

  void toggleClass(String subject) {
    if (isClassRunning[subject] == true) {
      // End Class
      setState(() {
        isClassRunning[subject] = false;
        timers[subject]?.cancel();
      });
      print("Class '$subject' duration: ${elapsedTimes[subject]} seconds");
    } else {
      // Start Class
      setState(() {
        isClassRunning[subject] = true;
        elapsedTimes[subject] = 0; // Reset timer
      });

      timers[subject] = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          elapsedTimes[subject] = (elapsedTimes[subject] ?? 0) + 1;
        });
      });
    }
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Professor Dashboard"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => UserSelectionScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Class Management",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildClassManagementCard("Software Engineering"),
            _buildClassManagementCard("Algorithm Design"),
            _buildClassManagementCard("EG101"),
            const SizedBox(height: 20),

            const Text(
              "Courses",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildCourseCard("Software Engineering", "23bcs001 - 23bcs070"),
            _buildCourseCard("DAA", "24bcs001 - 24bcs070"),
            _buildCourseCard("Engineering 101", "24bcs070 - 24bcs140"),
          ],
        ),
      ),
    );
  }

  /// Class Management Card (With Start/End Toggle Button)
  Widget _buildClassManagementCard(String subject) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("Time Elapsed: ${formatTime(elapsedTimes[subject] ?? 0)}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
                Text(
                  "Status: ${isClassRunning[subject] == true ? 'In Session' : 'Not in Session'}",
                  style: TextStyle(
                    fontSize: 14,
                    color: isClassRunning[subject] == true ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => toggleClass(subject),
              style: ElevatedButton.styleFrom(
                backgroundColor: isClassRunning[subject] == true ? Colors.red : Colors.green,
              ),
              child: Text(isClassRunning[subject] == true ? "End Class" : "Start Class"),
            ),
          ],
        ),
      ),
    );
  }

  /// Course Card
  Widget _buildCourseCard(String courseName, String rollNumbers) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(courseName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Roll Nos: $rollNumbers"),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Text("View Attendance"),
        ),
      ),
    );
  }
}
