import 'package:flutter/material.dart';
import 'package:zephyr/common/screens/splash_screen.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/drawer/screens/profile_screen.dart';

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
      // home: BottomNavScreen(),
      // home: StudyMaterialsScreen(),
      // home: CourseDetailsScreen(),
      home: ProfileScreen(),
      // home: LiveOngoing(),
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
