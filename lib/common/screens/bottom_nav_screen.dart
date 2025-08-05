import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/fa.dart';
import 'package:iconify_flutter_plus/icons/ic.dart';
import 'package:iconify_flutter_plus/icons/ri.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/assignments/screens/assignments_screen.dart';
import 'package:zephyr/features/enrolled_courses/screens/my_course_screen.dart';
import 'package:zephyr/features/home/screens/home_screen.dart';
import 'package:zephyr/features/live_class/screens/live_tabview_details.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  var _currentIndex = 0;

  final _pages = [
    HomeScreen(),
    MyCourseScreen(),
    LiveTabviewDetails(),
    AssignmentsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        backgroundColor: AppColors.lightOrange,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Iconify(
              Fa.home,
              size: 16,
              color: AppColors.primaryGreen,
            ),
            title: Text("Home"),
            selectedColor: AppColors.primaryGreen,
          ),

          /// Courses
          SalomonBottomBarItem(
            icon: Iconify(
              Fa.graduation_cap,
              size: 18,
              color: AppColors.primaryOrange,
            ),
            title: Text("Enrolled Courses"),
            selectedColor: AppColors.primaryOrange,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Iconify(
              Ri.live_fill,
              size: 24,
              color: AppColors.primaryBlue,
            ),
            title: Text("Live"),
            selectedColor: AppColors.primaryBlue,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Iconify(
              Ic.assignment,
              size: 24,
              color: AppColors.primaryRed,
            ),
            title: Text("Assignments"),
            selectedColor: AppColors.primaryRed,
          ),
        ],
      ),
      
    );
  }
}
