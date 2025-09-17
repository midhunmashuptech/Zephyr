import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/assignments/provider/assignment_provider.dart';
import 'package:zephyr/features/assignments/widgets/assignment_card.dart';

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

AssignmentProvider assignmentProvider = AssignmentProvider();

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  String formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    String formatted = DateFormat("MMMM d, yyyy | hh:mm a").format(dateTime);
    return formatted;
  }

  @override
  void initState() {
    super.initState();
    loadAssignments();
  }

  Future<void> loadAssignments() async {
    final loadProvider = context.read<AssignmentProvider>();
    await loadProvider.fetchAssignments(context: context);
  }

  @override
  Widget build(BuildContext context) {
    assignmentProvider = context.watch<AssignmentProvider>();
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
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              assignmentProvider.isAssignmentsLoading
                  ? Center(child: CircularProgressIndicator())
                  : assignmentProvider.assignmentList.isEmpty
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40.0),
                          child: Column(
                            children: [
                              Lottie.asset("assets/lottie/nodata.json",
                                  height: 200),
                              Text("No Assignments Found"),
                            ],
                          ),
                        ))
                      : Expanded(
                          child: ListView.builder(
                              itemCount:
                                  assignmentProvider.assignmentList.length,
                              itemBuilder: (context, index) => AssignmentCard(
                                    heading: assignmentProvider
                                            .assignmentList[index].title ??
                                        "Title",
                                    type: assignmentProvider
                                            .assignmentList[index].type ??
                                        "",
                                    date: formatDateTime(assignmentProvider
                                            .assignmentList[index].endTime ??
                                        "Time"),
                                  )),
                        )
            ],
          ),
        ),
      ),
    );
  }
}
