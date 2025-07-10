import 'package:flutter/material.dart';
import 'package:tugas3_kelompok/providers/auth_provider.dart';
import 'package:tugas3_kelompok/providers/course_provider.dart';
import 'package:tugas3_kelompok/providers/student_provider.dart';
import 'package:tugas3_kelompok/screens/auth_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => StudentProvider()),
        ChangeNotifierProvider(create: (_) => CourseProvider()),
      ],
      child: MaterialApp(
        title: 'Captain Academic System',
        theme: ThemeData(
          primaryColor: Colors.blue,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.blue,
            secondary: Colors.red,
          ),
          scaffoldBackgroundColor: const Color(0xFFF6F6F6),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontFamily: 'Roboto', fontSize: 16),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const AuthScreen(),
      ),
    );
  }
}
