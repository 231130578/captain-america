import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas3_kelompok/models/student.dart';
import 'package:tugas3_kelompok/providers/student_provider.dart';
import 'package:tugas3_kelompok/utils/helpers.dart';

class AddStudentDialog extends StatefulWidget {
  final String? studentId;
  final String? initialName;
  final String? initialProgram;

  const AddStudentDialog({
    super.key,
    this.studentId,
    this.initialName,
    this.initialProgram,
  });

  @override
  State<AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _id;
  late String _name;
  late String _program;

  @override
  void initState() {
    super.initState();
    _id = widget.studentId ?? '';
    _name = widget.initialName ?? '';
    _program = widget.initialProgram ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.studentId != null;
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          width: 360,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFc2e9fb), Color(0xFFa1c4fd)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade100.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isEdit ? 'Edit Mahasiswa' : 'Tambah Mahasiswa',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A2540),
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (!isEdit)
                      TextFormField(
                        decoration: _buildInputDecoration(
                            'ID Mahasiswa', Icons.perm_identity),
                        initialValue: _id,
                        validator: (value) =>
                            Helpers.validateTextField(value, 'ID Mahasiswa'),
                        onSaved: (value) => _id = value!,
                      ),
                    if (!isEdit) const SizedBox(height: 14),
                    TextFormField(
                      decoration:
                          _buildInputDecoration('Nama Mahasiswa', Icons.person),
                      initialValue: _name,
                      validator: (value) =>
                          Helpers.validateTextField(value, 'Nama Mahasiswa'),
                      onSaved: (value) => _name = value!,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      decoration: _buildInputDecoration(
                          'Program Studi', Icons.school_outlined),
                      initialValue: _program,
                      validator: (value) =>
                          Helpers.validateTextField(value, 'Program Studi'),
                      onSaved: (value) => _program = value!,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black54,
                    ),
                    child: const Text('Batal'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3A80BA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (isEdit) {
                          studentProvider.updateStudent(_id, _name, _program);
                          Helpers.showSnackBar(
                              context, 'Data berhasil diupdate');
                        } else {
                          studentProvider.addStudent(Student(
                            id: _id,
                            name: _name,
                            program: _program,
                          ));
                          Helpers.showSnackBar(
                              context, 'Mahasiswa berhasil ditambahkan');
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      isEdit ? 'Update' : 'Simpan',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blueGrey),
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF3A80BA), width: 1.5),
      ),
    );
  }
}
