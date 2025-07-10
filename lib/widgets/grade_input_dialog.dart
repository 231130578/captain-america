import 'package:flutter/material.dart';
import 'package:tugas3_kelompok/providers/student_provider.dart';
import 'package:tugas3_kelompok/providers/course_provider.dart';
import 'package:tugas3_kelompok/utils/constants.dart';
import 'package:tugas3_kelompok/utils/helpers.dart';
import 'package:provider/provider.dart';

class GradeInputDialog extends StatefulWidget {
  final String studentId;
  final List<String> courses;
  final Map<String, double> currentGrades;

  const GradeInputDialog({
    super.key,
    required this.studentId,
    required this.courses,
    required this.currentGrades,
  });

  @override
  State<GradeInputDialog> createState() => _GradeInputDialogState();
}

class _GradeInputDialogState extends State<GradeInputDialog> {
  final Map<String, TextEditingController> _gradeControllers = {};
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    for (var courseCode in widget.courses) {
      _gradeControllers[courseCode] = TextEditingController(
        text: widget.currentGrades[courseCode]?.toString() ?? '',
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _gradeControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.borderRadius),
      ),
      title: const Text('Input Nilai Mahasiswa', style: AppTextStyles.header2),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text('Masukkan nilai untuk setiap mata kuliah:'),
                const SizedBox(height: AppDimens.paddingSmall),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.courses.length,
                  itemBuilder: (context, index) {
                    final courseCode = widget.courses[index];
                    final course = courseProvider.courses.firstWhere(
                      (c) => c.code == courseCode,
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('${course.code} - ${course.name}',
                                style: AppTextStyles.bodyText),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 80,
                            child: TextFormField(
                              controller: _gradeControllers[courseCode],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Nilai',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) =>
                                  Helpers.validateGrade(value),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final grades = <String, double>{};

              for (var entry in _gradeControllers.entries) {
                final gradeText = entry.value.text;
                final grade = double.tryParse(gradeText);
                grades[entry.key] = grade!;
              }

              studentProvider.inputGrades(widget.studentId, grades);
              Helpers.showSnackBar(context, 'Nilai berhasil disimpan');
              Navigator.pop(context);
            } else {
              Helpers.showSnackBar(
                context,
                'Masukkan nilai yang valid (0-100)',
                isError: true,
              );
            }
          },
          child: const Text('Simpan', style: AppTextStyles.buttonText),
        ),
      ],
    );
  }
}
