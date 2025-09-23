import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/healthicons.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/test_series/screens/test_instructions_screen.dart';
import 'package:zephyr/features/test_series/screens/test_review_screen.dart';

class TestSeriesCard extends StatelessWidget {
  final String title;
  final String submissionDate;
  final String startDate;
  final String endDate;
  final String duration;
  final String questions;
  final bool isOngoing;
  final bool isUpcoming;
  final bool isAttended;
  final String testid;
  final String type;
  final String maxMarks;
  const TestSeriesCard(
      {super.key,
      this.isOngoing = false,
      this.isUpcoming = false,
      this.isAttended = false,
      required this.title,
      this.submissionDate = "",
      this.startDate = "",
      this.endDate = "",
      this.duration = "",
      required this.testid,
      required this.type,
      required this.maxMarks,
      required this.questions});

  @override
  Widget build(BuildContext context) {
    final Color mainColor = isAttended
        ? AppColors.primaryBlue
        : isUpcoming
            ? const Color.fromARGB(255, 239, 140, 0)
            : isOngoing
                ? AppColors.primaryGreen
                : AppColors.primaryBlue;
    final Color lightColor = isAttended
        ? AppColors.lightBlue
        : isUpcoming
            ? AppColors.lightOrange
            : isOngoing
                ? AppColors.lightGreen
                : AppColors.lightBlue;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: DottedBorder(
            color: mainColor,
            strokeWidth: 1.5,
            borderType: BorderType.RRect,
            radius: const Radius.circular(15),
            dashPattern: const [6, 3],
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: mainColor,
                                  foregroundColor: AppColors.white,
                                  child: Icon(Icons.architecture_rounded),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    child: Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                              ],
                            ),
                          ),
                          if (isOngoing)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TestInstructionsScreen(
                                              testId: testid,
                                              type: type,
                                              title: title,
                                              totalQuestions:
                                                  int.parse(questions),
                                              maxMarks: int.parse(maxMarks),
                                              duration: int.parse(
                                                  duration.split(" ")[0]),
                                            )));
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.rocket,
                                    color: mainColor,
                                  ),
                                  Text("Attend")
                                ],
                              ),
                            ),
                          if (isAttended)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TestReviewScreen(
                                              type: type,
                                              testid: testid,
                                            )));
                              },
                              child: Column(
                                children: [
                                  Iconify(
                                    Healthicons.magnifying_glass,
                                    color: mainColor,
                                  ),
                                  Text("Review")
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                    // SizedBox(height: 10),
                    Row(children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: lightColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: isAttended
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Submitted Time",
                                            style: TextStyle(
                                                color: mainColor, fontSize: 12),
                                          ),
                                          Text(
                                            submissionDate,
                                            style: TextStyle(
                                                color: mainColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Duration",
                                            style: TextStyle(
                                                color: mainColor, fontSize: 12),
                                          ),
                                          Text(
                                            duration,
                                            style: TextStyle(
                                                color: mainColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Start Time",
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                startDate,
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Questions",
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                questions,
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "End Time",
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                endDate,
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Duration",
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                duration,
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ])
                  ],
                ))));
  }
}
