import 'package:flutter/material.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/common/screens/splash_screen.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/assignments/screens/assignment_upload_screen.dart';
import 'package:zephyr/features/assignments/screens/assignments_screen.dart';
import 'package:zephyr/features/assignments/widgets/assignment_card.dart';
import 'package:zephyr/features/chapter_details/screens/video_play_screen.dart';
import 'package:zephyr/features/coursedetails/screens/course_details_screen.dart';
import 'package:zephyr/features/drawer/screens/drawer.dart';
import 'package:zephyr/features/live_class/screens/live_tabview_details.dart';
import 'package:zephyr/features/drawer/screens/profile_screen.dart';
import 'package:zephyr/features/notification/screens/notifications.dart';
import 'package:zephyr/features/notification/widgets/notification_card.dart';
import 'package:zephyr/features/test/screens/test_completion_screen.dart';
import 'package:zephyr/features/test/screens/test_instructions_screen.dart';

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
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryGreen, secondary: AppColors.primaryBlue),
        useMaterial3: true,
      ),
      // home: const MyHomePage(),
      // home: Login(),
      // home: ChapterDetailsScreen(),
      // home: RegistrationScreen(),
      // home: BottomNavScreen(),
      // home: StudyMaterialsScreen(),
      // home: CourseDetailsScreen(),
      // home: TestCompletionScreen(),
      // home: LiveTabviewDetails(),
      // home: AssignmentsScreen(),
      // home: VideoPlayScreen(),
      // home: AssignmentUploadScreen(),
         home: Notifications(),
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
