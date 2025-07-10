import 'package:flutter/material.dart';
import 'package:tugas3_kelompok/models/student.dart';

class StudentProvider with ChangeNotifier {
  List<Student> _students = [];

  List<Student> get students => _students;

  void addStudent(Student student) {
    _students.add(student);
    notifyListeners();
  }

  void updateStudent(String id, String name, String program) {
    final index = _students.indexWhere((s) => s.id == id);
    if (index != -1) {
      _students[index].name = name;
      _students[index].program = program;
      notifyListeners();
    }
  }

  void deleteStudent(String id) {
    _students.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  void registerCourses(String studentId, List<String> courseCodes) {
    final student = _students.firstWhere((s) => s.id == studentId);
    student.courses = courseCodes;
    notifyListeners();
  }

  void inputGrades(String studentId, Map<String, double> grades) {
    final student = _students.firstWhere((s) => s.id == studentId);
    student.grades = grades;
    notifyListeners();
  }
}
