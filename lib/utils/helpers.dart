import 'package:flutter/material.dart';

class Helpers {
  // Menampilkan snackbar
  static void showSnackBar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? const Color.fromARGB(255, 54, 70, 244) : Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Validasi field tidak boleh kosong
  static String? validateTextField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    return null;
  }

  // Validasi nilai (0-100)
  static String? validateGrade(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Boleh kosong
    }
    final grade = double.tryParse(value);
    if (grade == null) {
      return 'Harus angka';
    }
    if (grade < 0 || grade > 100) {
      return '0-100';
    }
    return null;
  }

  // Dialog konfirmasi
  static Future<bool> showConfirmationDialog(
    BuildContext context,
    String title,
    String content,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Tidak'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ya'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  // Format nama kapital
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}
