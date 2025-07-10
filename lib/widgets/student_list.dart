import 'package:flutter/material.dart';
import 'package:tugas3_kelompok/providers/student_provider.dart';
import 'package:tugas3_kelompok/screens/student_detail_screen.dart';
import 'package:tugas3_kelompok/utils/helpers.dart';
import 'package:tugas3_kelompok/widgets/add_student_dialog.dart';
import 'package:provider/provider.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    final students = Provider.of<StudentProvider>(context).students;

    if (students.isEmpty) {
      return const Center(
        child: Text('Belum ada data mahasiswa'),
      );
    }

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ListTile(
            title: Text(student.name),
            subtitle: Text('${student.id} - ${student.program}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddStudentDialog(
                        studentId: student.id,
                        initialName: student.name,
                        initialProgram: student.program,
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    final confirm = await Helpers.showConfirmationDialog(
                      context,
                      'Hapus Mahasiswa',
                      'Yakin ingin menghapus ${student.name}?',
                    );
                    if (confirm) {
                      Provider.of<StudentProvider>(context, listen: false)
                          .deleteStudent(student.id);
                      Helpers.showSnackBar(
                          context, 'Mahasiswa berhasil dihapus');
                    }
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      StudentDetailScreen(studentId: student.id),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
