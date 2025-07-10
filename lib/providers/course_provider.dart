import 'package:flutter/material.dart';
import 'package:tugas3_kelompok/models/course.dart';

class CourseProvider with ChangeNotifier {
  final List<Course> _courses = [
    Course(code: 'MK001', name: 'Pemrograman Dart', credits: 3),
    Course(code: 'MK002', name: 'Flutter Lanjutan', credits: 3),
    Course(code: 'MK003', name: 'Basis Data', credits: 2),
    Course(code: 'MK004', name: 'Algoritma', credits: 3),
    Course(code: 'MK005', name: 'Struktur Data', credits: 3),
  ];

  List<Course> get courses => _courses;
}
