import 'package:course_compass/pages/database_service.dart';
import 'package:flutter/material.dart';
// Import the DatabaseService

class DescriptionPage extends StatelessWidget {
  final String courseId;
  
  const DescriptionPage({super.key, required this.courseId, required String course});

  @override
  Widget build(BuildContext context) {
    final DatabaseService db = DatabaseService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Description"),
      ),
      body: StreamBuilder<Course>(
        stream: db.getCourseById(courseId), // Assume you have a method to fetch a course by ID
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          
          Course course = snapshot.data!;
          
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course.courseName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(course.university, style: const TextStyle(fontSize: 18, color: Colors.grey)),
                const SizedBox(height: 16),
                Text(course.courseDescription),
                const SizedBox(height: 16),
                const Text("Career Opportunities:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(course.career),
                const SizedBox(height: 16),
                const Text("Testimony:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(course.testimony),
                const SizedBox(height: 16),
                Text("Tuition: ${course.tuition}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
