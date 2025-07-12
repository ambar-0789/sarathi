import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SaarthiApp',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
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
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Saarthi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                ),
                const SizedBox(height: 10),
                const Text('Welcome! Please select your role to continue.',
                    textAlign: TextAlign.center),
                const SizedBox(height: 30),

                // Patient View Button
                ElevatedButton.icon(
                  icon: const Icon(Icons.person),
                  label: const Text('Patient View →'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.indigo, // or conditionally colored
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    elevation: 3,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/patient');
                  },
                ),
                const SizedBox(height: 15),

                // Guardian View Button
                ElevatedButton.icon(
                  icon: const Icon(Icons.people),
                  label: const Text('Guardian View →'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.indigo.shade100,
                    foregroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/guardian');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
