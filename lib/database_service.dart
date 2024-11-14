import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch courses data
  Stream<List<Course>> getCourses() {
    return _db.collection('architecture').doc('extrovert').collection('makati').snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Course.fromFirestore(doc)).toList()
    );
  }

  Stream<List<Course>> getCourses1() {
    return _db.collection('writing').doc('introvert').collection('makati').snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Course.fromFirestore(doc)).toList()
    );
  }

  // Add course data
  Future<void> addCourseData() async {
    await _db.collection('architecture')
      .doc('extrovert')
      .collection('makati city')
      .doc('course1')
      .set({
        'career': 'Residential Architect, Commercial Architect, Industrial Architect',
        'course_description': 'Focuses on designing and planning buildings and structures. Students learn about drafting, structural integrity, and aesthetics. Architects need to balance creative work, often done independently (introvert), with client communication and project collaboration (extrovert), making it suitable for ambiverts.',
        'course_name': 'Bachelor of Science in Architecture',
        'testimony': 'Philip: Studying Architecture at Assumption College has been a dream. The professors here challenge us to think creatively and practically, and they offer so much guidance in developing our design skills.',
        'tuition': '60,000 - 70,000',
        'university': 'Assumption College'
      });
  }
}

// Course model
class Course {
  final String id;
  final String career;
  final String courseDescription;
  final String courseName;
  final String testimony;
  final String tuition;
  final String university;
  final String location;

  Course({
    required this.id,
    required this.career,
    required this.courseDescription,
    required this.courseName,
    required this.testimony,
    required this.tuition,
    required this.university,
    required this.location,
  });

  factory Course.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Course(
      id: doc.id,
      career: data['career'] ?? '',
      courseDescription: data['course_description'] ?? '',
      courseName: data['course_name'] ?? '',
      testimony: data['testimony'] ?? '',
      tuition: data['tuition'] ?? '',
      university: data['university'] ?? '',
      location: data['location'] ?? 'Unknown',
    );
  }
}
