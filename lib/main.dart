import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/common/screens/splash_screen.dart';
import 'package:zephyr/common/service/notification_service.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/chapter_details/screens/chapter_analysis_screen.dart';
import 'package:zephyr/features/chapter_details/screens/chapter_details_screen.dart';
void main() async {
  // print("App starting");
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notification service (it handles timezone setup internally)
  await NotificationService().initNotification();
  // print("App started");
  
  runApp(const MyApp());
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
        scaffoldBackgroundColor: AppColors.white
      ),
      home: SplashScreen(),
      // home: BottomNavScreen(),
      // home: ChapterDetailsScreen(),
      // home: ChapterAnalysisScreen()
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