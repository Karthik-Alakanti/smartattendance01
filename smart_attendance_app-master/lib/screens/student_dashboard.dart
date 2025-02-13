import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'user_selection_screen.dart';  // Logout to user selection

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  bool isWifiConnected = false; // Tracks if the student is connected to the correct WiFi
  String? connectedSSID = "Checking..."; // Stores the connected WiFi SSID
  final String requiredSSID = "IIIT DHARWAD-STUDENT"; // Your classroom WiFi SSID

  @override
  void initState() {
    super.initState();
    checkWiFiConnection();
  }

  // Fetch the current WiFi SSID and check if it matches the classroom WiFi
  Future<void> checkWiFiConnection() async {
    try {
      String? ssid = await WifiInfo().getWifiName(); // Fetch current WiFi SSID
      setState(() {
        connectedSSID = ssid ?? "Not Connected"; // Store SSID in UI
        isWifiConnected = (ssid != null && ssid.contains(requiredSSID)); // Allow if SSID matches
      });
    } catch (e) {
      print("Error getting WiFi SSID: $e");
      setState(() {
        isWifiConnected = false;
        connectedSSID = "Not Connected";
      });
    }
  }

  // Dummy Join Class Logic (Now checks WiFi)
  void joinClass() {
    if (isWifiConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ You have joined the class! WiFi Verified.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Cannot join. Incorrect WiFi.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Dashboard"),
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
            const Text("Current Class", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text("WiFi Connection: ${connectedSSID ?? "Checking..."}"),
                subtitle: Text(isWifiConnected
                    ? "✅ Connected to Classroom WiFi"
                    : "❌ Not connected to Classroom WiFi"),
                trailing: ElevatedButton(
                  onPressed: isWifiConnected ? joinClass : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isWifiConnected ? Colors.green : Colors.grey,
                  ),
                  child: const Text("Join Class"),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text("Attendance Statistics", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text("85% Overall Attendance"),
                Text("24 Classes Attended"),
                Text("4 Classes Missed"),
              ],
            ),

            const SizedBox(height: 20),
            const Text("Attendance History", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            _buildAttendanceHistory("2025-01-30", "Software Engineering", "09:00 AM", "Present"),
            _buildAttendanceHistory("2025-01-29", "Linear Algebra", "11:00 AM", "Present"),
            _buildAttendanceHistory("2025-01-28", "TOC", "02:00 PM", "Absent"),
            _buildAttendanceHistory("2025-01-27", "DBMS", "09:00 AM", "Present"),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceHistory(String date, String subject, String time, String status) {
    Color statusColor = status == "Present" ? Colors.green : Colors.red;
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text("$date - $subject"),
        subtitle: Text("Time: $time"),
        trailing: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
