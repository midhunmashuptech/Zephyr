import 'package:flutter/material.dart';
import 'package:zephyr/common/screens/splash_screen.dart';
import 'package:zephyr/features/chapter_details/screens/chapter_details_screen.dart';
import 'package:zephyr/features/chapter_details/screens/study_materials_screen.dart';
import 'package:zephyr/features/coursedetails/screens/course_chapters.dart';
import 'package:zephyr/features/coursedetails/screens/course_details_screen.dart';
import 'package:zephyr/features/login/screens/forgot_password_screen.dart';
import 'package:zephyr/features/live_class/screens/live_ongoing.dart';
import 'package:zephyr/features/live_class/screens/live_tabview_details.dart';
import 'package:zephyr/constants/app_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryGreen, secondary: AppColors.primaryBlue),
        useMaterial3: true,
      ),
      // home: const MyHomePage(),
      // home: Login(),
      // home: ChapterDetailsScreen(),
      // home: RegistrationScreen(),
      // home: BottomNavScreen()
      // home: StudyMaterialsScreen(),
      // home: CourseDetailsScreen(),
      // home: LiveTabviewDetails(),
      home: LiveOngoing(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
