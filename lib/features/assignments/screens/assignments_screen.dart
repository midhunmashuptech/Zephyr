import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/assignments/widgets/assignment_card.dart';

class AssignmentsScreen extends StatelessWidget {
  const AssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedAssignments,
                    color: AppColors.black,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Live Classes',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              AssignmentCard(
                  heading:
                      "Write note on Photosynthesis Write note on Photosynthesis",
                  author: "By Athulya Ajay",
                  dateText: "Duedate",
                  date: " August 27, 2025",
                  time: "10:00PM "),
            ],
          ),
        )),
      ),
    );
  }
}
