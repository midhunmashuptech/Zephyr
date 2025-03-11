import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/live_class/widgets/live_class_card.dart';

class LiveUpcoming extends StatefulWidget {
  
  const LiveUpcoming({super.key});

  @override
  State<LiveUpcoming> createState() => _LiveUpcomingState();
}

class _LiveUpcomingState extends State<LiveUpcoming> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LiveClassCard(
              className: "Maths",    
              tutorName: "John Doe",
              date: "12/12/2021",
              duration: "2 hours",
              imageUrl: "assets/images/course_bg1.jpg",
              imageColor: AppColors.grey,
            ),
            LiveClassCard(
              className: "Maths",    
              tutorName: "John Doe",
              date: "12/12/2021",
              duration: "2 hours",
              imageUrl: "assets/images/course_bg2.jpg",
              imageColor: AppColors.grey,
            ),
          ],
        )
      ),
    );
  }
}