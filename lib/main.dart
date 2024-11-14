import 'package:course_compass/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';  // Make sure you have the Firebase options properly set

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Make sure firebase_options.dart exists
  );
  runApp(const ThemeToggleWrapper());
}

class ThemeToggleWrapper extends StatefulWidget {
  const ThemeToggleWrapper({super.key});

  @override
  _ThemeToggleWrapperState createState() => _ThemeToggleWrapperState();
}

class _ThemeToggleWrapperState extends State<ThemeToggleWrapper> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Compass',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              textTheme: ThemeData.dark().textTheme.apply(
                    fontFamily: 'Times New Roman',
                    bodyColor: Colors.white,
                    displayColor: Colors.white,
                  ),
            )
          : ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'Times New Roman',
              textTheme: ThemeData.light().textTheme.apply(
                    bodyColor: Colors.black,
                    displayColor: Colors.black,
                  ),
            ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 21, 46, 78),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(26),
              bottomRight: Radius.circular(26),
            ),
          ),
          title: const Text(
            'Course Compass',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            ThemeToggle(
              isDarkMode: _isDarkMode,
              onToggle: _toggleTheme,
            ),
          ],
        ),
        body: const WelcomePage(), // Make sure WelcomePage() is properly defined and works
      ),
    );
  }
}

class ThemeToggle extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggle;

  const ThemeToggle({super.key, required this.isDarkMode, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
      onPressed: onToggle,
      color: Colors.white,
    );
  }
}
