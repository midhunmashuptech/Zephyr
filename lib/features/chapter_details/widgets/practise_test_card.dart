import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/healthicons.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/data_class/practise_test.dart';
import 'package:zephyr/features/test/screens/test_instructions_screen.dart';

class PractiseTestCard extends StatelessWidget {
  final PractiseTest practiseTest;
  const PractiseTestCard({super.key, required this.practiseTest});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: GestureDetector(
        onTap: () {
          if (practiseTest.status == "Incomplete") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => TestInstructionsScreen()));
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                    color: AppColors.black.withAlpha(20),
                    spreadRadius: 2,
                    blurRadius: 2)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.16 > 120
                      ? 120
                      : MediaQuery.of(context).size.width * 0.16,
                  height: MediaQuery.of(context).size.width * 0.16 > 120
                      ? 120
                      : MediaQuery.of(context).size.width * 0.16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: practiseTest.status == "Complete"
                        ? AppColors.primaryGreen
                        : AppColors.primaryOrange,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Iconify(
                      Healthicons.i_exam_multiple_choice_outline,
                      size: 16,
                      color: AppColors.white,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  // width: MediaQuery.of(context).size.width * 0.61,
                  // height: MediaQuery.of(context).size.width * 0.14 > 100
                  //     ? 100
                  //     : MediaQuery.of(context).size.width * 0.15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            practiseTest.name ?? "No Title",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            practiseTest.chapter ?? "No Chapter",
                            style:
                                TextStyle(fontSize: 12, color: AppColors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      if (practiseTest.status == "Incomplete")
                        Row(
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 18,
                            ),
                            SizedBox(width: 5),
                            Text("due date ${practiseTest.dueDate}",
                                style: TextStyle(fontSize: 12))
                          ],
                        )
                      else if (practiseTest.status == "Complete")
                        Row(
                          children: [
                            Text("Completed",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primaryGreen)),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(Icons.check_rounded,
                                size: 14, color: AppColors.primaryGreen)
                          ],
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
