import 'package:course_compass/pages/interest_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCourse;
  final List<String> courses = [
    'Writing',
    'Teaching',
    'Cooking',
    'Medicine',
    'Theater',
    'Graphic Arts',
    'Technology',
    'Architecture',
    'Engineering',
    'Business',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          IconButton(
            icon: Icon(
              Brightness.dark == MediaQuery.of(context).platformBrightness
                  ? Icons.wb_sunny
                  : Icons.nights_stay,
            ),
            color: Theme.of(context).iconTheme.color, // Use theme's icon color
            onPressed: () {
              _toggleTheme(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What are your interests?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select a course you\'re interested in:',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: courses.map((course) {
                return SizedBox(
                  width: (MediaQuery.of(context).size.width - 50) / 3,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: selectedCourse == course ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color,
                      backgroundColor: selectedCourse == course ? const Color.fromARGB(255, 111, 190, 236) : Theme.of(context).buttonTheme.colorScheme?.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8.0),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedCourse = course.toLowerCase();
                      });
                      print(selectedCourse);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InterestPage(selectedCourse: selectedCourse!)),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lightbulb_outline_rounded, // Generic icon for courses
                          color: selectedCourse == course ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          course,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleTheme(BuildContext context) {
    final newTheme = Theme.of(context).brightness == Brightness.dark ? ThemeData.light() : ThemeData.dark();
    newTheme.copyWith(
      textTheme: newTheme.textTheme.apply(
        fontFamily: 'Times New Roman',
      ),
    );
    // ... (rest of your theme toggling logic)
  }
}