import 'package:flutter/material.dart';
import 'chat.dart';
import '../data/app_data.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SaarthiApp',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Color(0xff29367c),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.accessible_forward,
              color: Colors.white,
              size: 30, // 👈 Increase size here (default is 24)
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text("Patient View",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white)),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Welcome to your Dashboard!",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const Text("Manage your wheelchair and navigate your home with ease.",
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
          // Navigate to Room (inside Card)
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    "Navigate to Room",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xff29367c)),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: const [
                        RoomButton(label: "Living Room", icon: Icons.chair),
                        RoomButton(label: "Bedroom", icon: Icons.bed),
                        RoomButton(label: "Kitchen", icon: Icons.kitchen),
                        RoomButton(label: "Bathroom", icon: Icons.bathtub),
                        RoomButton(label: "Study", icon: Icons.menu_book),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text("Manual Wheelchair Control",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xff29367c))),
                  const SizedBox(height: 15),
                  const WheelchairControls(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),

          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    "🚨 Emergency Assistance",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  // 🔴 SOS Button
                  ElevatedButton.icon(
                    onPressed: () {
                      ChatScreen.addSystemMessage("🚨 SOS Alert from Patient");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("SOS Alert Sent")),
                      );
                    },
                    icon: const Icon(Icons.warning_amber_rounded),
                    label: const Text("Send SOS Alert"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 12),
                  // 📞 Emergency Call Button
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.call),
                    label: const Text("Emergency Call"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade900,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 2,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatScreen(user: "Patient"), // Or "Guardian"
            ),
          );
        },
        backgroundColor: Colors.indigo,
        child: Icon(Icons.chat),
      ),
    );
  }
}

// Reuse RoomButton and updated WheelchairControls
class RoomButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const RoomButton({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo.shade50,
        foregroundColor: Colors.indigo.shade900,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

// ✅ Updated only this widget
class WheelchairControls extends StatelessWidget {
  const WheelchairControls({super.key});

  Widget _controlButton(IconData icon, String direction) {
    return GestureDetector(
      onTap: () {
        print('Move $direction');
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.indigo.shade100,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 32, color: Colors.indigo.shade800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _controlButton(Icons.keyboard_arrow_up, "forward"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _controlButton(Icons.keyboard_arrow_left, "left"),
              const SizedBox(width: 20),
              _controlButton(Icons.radio_button_checked, "stop"),
              const SizedBox(width: 20),
              _controlButton(Icons.keyboard_arrow_right, "right"),
            ],
          ),
          const SizedBox(height: 10),
          _controlButton(Icons.keyboard_arrow_down, "backward"),
        ],
      ),
    );
  }
}
