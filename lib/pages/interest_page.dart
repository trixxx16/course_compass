import 'package:course_compass/pages/course_list.dart';
import 'package:flutter/material.dart';

class InterestPage extends StatefulWidget {
  final String selectedCourse;

  const InterestPage({super.key, required this.selectedCourse});
  @override
  _InterestPageState createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  String? personalityType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 111, 190, 236),
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selected Course:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.selectedCourse,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            const Text(
              'How would you describe yourself?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            RadioListTile<String>(
              title: const Text("I prefer to work independently! It's not my forte to interact with others daily."),
              value: 'introvert',
              groupValue: personalityType,
              onChanged: (value) {
                setState(() {
                  personalityType = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text("I'm a bit of an outgoing person! I like to socialize."),
              value: 'extrovert',
              groupValue: personalityType,
              onChanged: (value) {
                setState(() {
                  personalityType = value;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: personalityType != null
                  ? () {
                      print(personalityType);
                      // Navigate back to the home screen
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => CourseList(personalityType: personalityType, selectedCourse: widget.selectedCourse,)),
                        (Route<dynamic> route) => false,
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor:  const Color.fromARGB(255, 111, 190, 236),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}