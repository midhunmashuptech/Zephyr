import 'package:flutter/material.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/common/screens/splash_screen.dart';
import 'package:zephyr/common/service/notification_service.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/assignments/screens/assignment_upload_screen.dart';
import 'package:zephyr/features/coursedetails/screens/course_details_screen.dart';
import 'package:zephyr/features/coursedetails/screens/course_reviews.dart';
import 'package:zephyr/features/drawer/screens/edit_profile.dart';
import 'package:zephyr/features/enrolled_courses/screens/enrolled_courses_review.dart';
import 'package:zephyr/features/enrolled_courses/screens/my_course_screen.dart';
import 'package:zephyr/features/enrolled_courses/screens/test_review.dart';
import 'package:zephyr/features/home/screens/home_screen.dart';
import 'package:zephyr/features/payment/screens/apply_coupon.dart';
import 'package:zephyr/features/payment/screens/payment_successful.dart';
import 'package:zephyr/features/payment/screens/test.dart';

void main() async {
  print("App starting");
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notification service (it handles timezone setup internally)
  await NotificationService().initNotification();
  print("App started");
  
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
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryGreen,
            secondary: AppColors.primaryBlue),
        useMaterial3: true,
      ),
      home: BottomNavScreen(),
      // home: AssignmentUploadScreen(),
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