import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas3_kelompok/providers/auth_provider.dart';
import 'package:tugas3_kelompok/providers/student_provider.dart';
import 'package:tugas3_kelompok/widgets/add_student_dialog.dart';
import 'package:tugas3_kelompok/widgets/student_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Sistem Akademik',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF64b5f6),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddStudentDialog(),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF74ebd5), Color(0xFFACB6E5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  color: Colors.white.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Row(
                      children: [
                        const Text(
                          'Daftar Mahasiswa',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0A2540),
                          ),
                        ),
                        const Spacer(),
                        Consumer<StudentProvider>(
                          builder: (context, studentProvider, _) {
                            return Text(
                              'Total: ${studentProvider.students.length}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF555555),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Card(
                    color: Colors.white.withOpacity(0.95),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: StudentList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
