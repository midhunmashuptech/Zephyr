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
            className: "Foundation of class 10",
            tutorName: "Ankitha Sasikumar",
            imageUrl: "assets/images/course_bg1.jpg",
            imageColor: AppColors.lightGreen,
            currenttab: "Upcoming",
            startDate: '',
            enddate: '',
          ),
          LiveClassCard(
            className: "Foundation of class 10",
            tutorName: "Ankitha Sasikumar",
            imageUrl: "assets/images/course_bg1.jpg",
            imageColor: AppColors.lightGreen,
            currenttab: "Upcoming",
            startDate: '',
            enddate: '',
          ),
        ],
      )),
    );
  }
}
