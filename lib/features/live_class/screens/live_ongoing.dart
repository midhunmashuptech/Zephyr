import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/live_class/widgets/live_class_card.dart' show LiveClassCard;

class LiveOngoing extends StatefulWidget {
  const LiveOngoing({super.key});

  @override
  State<LiveOngoing> createState() => _LiveOngoingState();
}

class _LiveOngoingState extends State<LiveOngoing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LiveClassCard(
              className: "Foundation of class 10",    
              tutorName: "By Ankitha Sasikumar",
              date: "Feb 20",
              year: "2025",
              duration: "10:00 AM - 11:00 AM",
              imageUrl: "assets/images/course_bg1.jpg",
              imageColor: AppColors.lightGreen, 
              currenttab: "Ongoing",
            ),
            LiveClassCard(
              className: "Foundation of class 10",    
              tutorName: "By Ankitha Sasikumar",
              date: "Feb 20",
              year: "2025",
              duration: "10:00 AM - 11:00 AM",
              imageUrl: "assets/images/course_bg3.jpg",
              imageColor: AppColors.lightGreen,
              currenttab: "Ongoing",
            ),
          ],
        )
      ),
    );
  }
}