import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/assignments/widgets/assignment_card.dart';

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class Assignments {
  String heading;
  String author;
  String date;
  String time;

  Assignments(
      {required this.heading,
      required this.author,
      required this.date,
      required this.time});
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  List<Assignments> assignments = [
    Assignments(
        heading: "Write note on Photosynthesis",
        author: "By Athulya Ajay",
        date: " August 15, 2025",
        time: "10:00PM "),
    Assignments(
        heading: "Upload your CV",
        author: "By Athulya Ajay",
        date: "August 15, 2025",
        time: "12:00PM "),
    Assignments(
        heading: "Write note on Photosynthesis",
        author: "By Athulya Ajay",
        date: " August 15, 2025",
        time: "10:00PM "),
    Assignments(
        heading: "Upload your CV",
        author: "By Athulya Ajay",
        date: " August 15, 2025",
        time: "12:00PM "),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(width: 10),
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedAssignments,
                    color: AppColors.black,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Assignments',
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: assignments.length,
                    itemBuilder: (context, index) => AssignmentCard(
                        heading: assignments[index].heading,
                        author: assignments[index].author,
                        date: assignments[index].date,
                        time: assignments[index].time,
                        type: "image",)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
