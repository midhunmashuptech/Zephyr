import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/common/screens/splash_screen.dart';
import 'package:zephyr/common/screens/test_screen.dart';
import 'package:zephyr/common/service/notification_service.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/assignments/provider/assignment_provider.dart';
import 'package:zephyr/features/auth/provider/auth_provider.dart';
import 'package:zephyr/features/chapter_details/provider/enrolled_chapter_details_provider.dart';
import 'package:zephyr/features/coursedetails/provider/course_provider.dart';
import 'package:zephyr/features/drawer/provider/edit_profile_provider.dart';
import 'package:zephyr/features/drawer/provider/timeline_provider.dart';
import 'package:zephyr/features/enrolled_courses/provider/enrolled_course_provider.dart';
import 'package:zephyr/features/home/provider/home_page_provider.dart';
import 'package:zephyr/features/live_class/provider/live_provider.dart';
import 'package:zephyr/features/test/provider/make_test_provider.dart';
import 'package:zephyr/features/test_series/screens/test_review_screen.dart';
import 'package:zephyr/features/test_series/testetutor.dart';

void main() async {
  // print("App starting");
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notification service (it handles timezone setup internally)
  await NotificationService().initNotification();
  // print("App started");

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
    ChangeNotifierProvider(create: (_) => EnrolledCourseProvider()),
    ChangeNotifierProvider(create: (_) => MakeTestProvider()),
    ChangeNotifierProvider(create: (_) => EditProfileProvider()),
    ChangeNotifierProvider(create: (_) => CourseProvider()),
    ChangeNotifierProvider(create: (_) => HomePageProvider()),
    ChangeNotifierProvider(create: (_) => EnrolledChapterDetailsProvider()),
    ChangeNotifierProvider(create: (_) => LiveProvider()),
    ChangeNotifierProvider(create: (_) => AssignmentProvider()),
    ChangeNotifierProvider(create: (_) => TimelineProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Poppins',
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.white),
      // home: SplashScreen(),
      // home: BottomNavScreen(),
      // home: ChapterDetailsScreen(),
      // home: ChapterAnalysisScreen(),
      // home: PieChartDemo(),
      // home: TestQuizScreen(),
      // home: Testetutor(),
      home:  TestReviewScreen(),
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