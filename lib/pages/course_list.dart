import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseList extends StatefulWidget {
  final String? personalityType;
  final String? selectedCourse;

  const CourseList({
    super.key,
    required this.personalityType,
    required this.selectedCourse,
  });

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  String? selectedLocation; // This will hold the selected dropdown value

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final courseContainerColor = isDarkMode ? Colors.grey[850] : Colors.grey[200];

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
          'COURSE COMPASS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              'In that case, here are the best courses that\nalign with your interests!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 77, 46, 46),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedLocation,
                      hint: Text('Any Location', style: TextStyle(color: textColor)),
                      items: <String>['Makati', 'Pasig', 'Manila', 'Quezon_city', 'Taguig']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(color: textColor)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedLocation = newValue;
                        });
                      },
                      dropdownColor: isDarkMode ? Colors.grey[800] : Colors.white,
                      style: TextStyle(color: textColor),
                      iconEnabledColor: textColor,
                      selectedItemBuilder: (BuildContext context) {
                        return <String>[
                          'makati',
                          'Pasig',
                          'Manila',
                          'Quezon_city',
                          'Taguig'
                        ].map<Widget>((String value) {
                          return Container(
                            color: Colors.transparent,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: textColor,
                              ),
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(widget.selectedCourse!)
                    .doc(widget.personalityType)
                    .collection(selectedLocation == null ? "pasig" : selectedLocation!.toLowerCase())
                    .doc("course1")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
                    return const Center(child: Text("No courses available for this interest."));
                  }
                  
                  final doc = snapshot.data!;
                  return SingleChildScrollView(
                    child: ExpansionTile(
                      title: Text(
                        "${doc['course_name']} - ${doc['university']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.blueAccent,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Course Overview: ${doc['course_description']}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Average Tuition per Sem: ${doc['tuition']}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Testimony: ${doc['testimony']}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Possible Career: ${doc['career']}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
