import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/common/screens/splash_screen.dart';
import 'package:zephyr/common/service/notification_service.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/auth/provider/auth_provider.dart';
import 'package:zephyr/features/coursedetails/provider/course_provider.dart';
import 'package:zephyr/features/drawer/provider/edit_profile_provider.dart';
import 'package:zephyr/features/enrolled_courses/provider/enrolled_course_provider.dart';
import 'package:zephyr/features/home/provider/home_page_provider.dart';
import 'package:zephyr/features/test/provider/make_test_provider.dart';

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
    ChangeNotifierProvider(create: (_) => EnrolledCourseProvider()),
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
      home: SplashScreen(),
      // home: BottomNavScreen(),
      // home: ChapterDetailsScreen(),
      // home: ChapterAnalysisScreen(),
      // home: TestQuizScreen(),
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