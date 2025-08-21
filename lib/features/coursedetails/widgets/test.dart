import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/enrolled_courses/widgets/course_action_card.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              // child: Row(
              //   children: [
              //     Expanded(child: CourseActionCard(title: 'Assignments', bgcolor: AppColors.orangeCourseActionGradient, icon: HugeIcons.strokeRoundedAssignments, iconColor: AppColors.primaryOrange,)),
              //     SizedBox(width: 15,),
              //     Expanded(child: CourseActionCard(title: 'Make a Test', bgcolor: AppColors.greenCourseActionGradient, icon: HugeIcons.strokeRoundedTestTube01, iconColor: AppColors.primaryGreen,)),
              //   ],
              // ),
            ),
            
          ],
        )
      ),
    );
  }
}