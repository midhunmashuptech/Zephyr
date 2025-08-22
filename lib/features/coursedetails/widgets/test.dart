import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/widgets/course_content_card.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
          
              CourseContentCard(
                title: 'Video', 
                subtitle: 'Tap to see the video',
                icon: Icons.videocam, 
                bgcolor: AppColors.primaryBlue, 
                lockicon: Icons.lock,
                ),
                CourseContentCard(
                title: 'Image', 
                subtitle: 'Tap to see the image',
                icon: Icons.image, 
                bgcolor: AppColors.primaryGreen,
                lockicon: Icons.lock,
                ),CourseContentCard(
                title: 'pdf', 
                subtitle: 'Tap to see the pdf',
                icon: Icons.picture_as_pdf, 
                bgcolor: AppColors.primaryRed,
                lockicon: Icons.lock,
                ),
            ],
          ),
        )
      ),
    );
  }
}