// lib/widgets/course_registration_dialog.dart

import 'package:flutter/material.dart';
import 'package:tugas3_kelompok/providers/student_provider.dart';
import 'package:tugas3_kelompok/providers/course_provider.dart';
import 'package:tugas3_kelompok/utils/constants.dart';
import 'package:tugas3_kelompok/utils/helpers.dart';
import 'package:provider/provider.dart';

class CourseRegistrationDialog extends StatefulWidget {
  final String studentId;
  final List<String> registeredCourses;

  const CourseRegistrationDialog({
    super.key,
    required this.studentId,
    required this.registeredCourses,
  });

  @override
  State<CourseRegistrationDialog> createState() =>
      _CourseRegistrationDialogState();
}

class _CourseRegistrationDialogState extends State<CourseRegistrationDialog> {
  late List<String> _selectedCourses;

  @override
  void initState() {
    super.initState();
    _selectedCourses = List.from(widget.registeredCourses);
  }

  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<CourseProvider>(context).courses;
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.borderRadius),
      ),
      title:
          const Text('Pendaftaran Mata Kuliah', style: AppTextStyles.header2),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Pilih mata kuliah yang akan diambil:'),
              const SizedBox(height: AppDimens.paddingSmall),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return CheckboxListTile(
                    value: _selectedCourses.contains(course.code),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _selectedCourses.add(course.code);
                        } else {
                          _selectedCourses.remove(course.code);
                        }
                      });
                    },
                    title: Text('${course.code} - ${course.name}',
                        style: AppTextStyles.bodyText),
                    subtitle: Text('${course.credits} SKS'),
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                },
              ),
            ],
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
            backgroundColor: AppColors.secondary,
          ),
          onPressed: () {
            studentProvider.registerCourses(widget.studentId, _selectedCourses);
            Helpers.showSnackBar(context, 'KRS berhasil disimpan');
            Navigator.pop(context);
          },
          child: const Text('Simpan', style: AppTextStyles.buttonText),
        ),
      ],
    );
  }
}
