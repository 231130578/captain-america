import 'package:flutter/material.dart';
import 'package:tugas3_kelompok/providers/course_provider.dart';
import 'package:tugas3_kelompok/providers/student_provider.dart';
import 'package:tugas3_kelompok/widgets/course_registration_dialog.dart';
import 'package:tugas3_kelompok/widgets/grade_input_dialog.dart';
import 'package:provider/provider.dart';

class StudentDetailScreen extends StatelessWidget {
  final String studentId;

  const StudentDetailScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<StudentProvider>(context)
        .students
        .firstWhere((s) => s.id == studentId);
    final courses = Provider.of<CourseProvider>(context).courses;

    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID: ${student.id}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Program Studi: ${student.program}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'IPK: ${student.gpa.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CourseRegistrationDialog(
                        studentId: student.id,
                        registeredCourses: student.courses,
                      ),
                    );
                  },
                  child: const Text('Daftar Mata Kuliah'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => GradeInputDialog(
                        studentId: student.id,
                        courses: student.courses,
                        currentGrades: student.grades,
                      ),
                    );
                  },
                  child: const Text('Input Nilai'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Mata Kuliah Diambil:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: student.courses.length,
                itemBuilder: (context, index) {
                  final courseCode = student.courses[index];
                  final course =
                      courses.firstWhere((c) => c.code == courseCode);
                  final grade = student.grades[courseCode];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(course.name),
                      subtitle: Text('${course.code} - ${course.credits} SKS'),
                      trailing: grade != null
                          ? Chip(
                              label: Text(
                                'Nilai: ${grade.toStringAsFixed(1)}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.blue,
                            )
                          : const Text('Belum dinilai'),
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
