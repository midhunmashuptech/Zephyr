import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/fa.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';
import 'package:zephyr/features/assignments/widgets/assignment_card.dart';

class AssignmentsScreen extends StatelessWidget {
  const AssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: LayoutGradient(gradient: AppColors.redGradient)
            ),
            SingleChildScrollView(
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
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
            
                  // Row(
                  //   children: [
                  //     SizedBox(width: 10),
                  //     HugeIcon(
                  //       icon: HugeIcons.strokeRoundedAssignments,
                  //       color: AppColors.black,
                  //     ),
                  //     SizedBox(width: 10),
                  //     Text(
                  //       'Assignments',
                  //       style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                  //     ),
                  //   ],
                  // ),
            
                  AssignmentCard(
                      heading: "Write note on Photosynthesis",
                      author: "By Athulya Ajay",
                      date: " August 27, 2025",
                      time: "10:00PM "),
                  AssignmentCard(
                      heading: "Upload your CV",
                      author: "By Athulya Ajay",
                      date: " August 27, 2025",
                      time: "12:00PM "),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
