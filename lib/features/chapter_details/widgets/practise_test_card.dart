import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/healthicons.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/drawer/provider/timeline_provider.dart';
import 'package:zephyr/features/test/screens/test_instructions_screen.dart';

class PractiseTestCard extends StatelessWidget {
  final String title;
  final String chapter;
  final String uploadedDate;
  final bool isCompleted;
  final String batchId;
  const PractiseTestCard(
      {super.key,
      required this.title,
      required this.chapter,
      required this.uploadedDate,
      required this.isCompleted,
      required this.batchId
      });

  @override
  Widget build(BuildContext context) {
    final timelineProvider = context.read<TimelineProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: GestureDetector(
        onTap: () async {
        await timelineProvider.postTimelineActivity(
            context: context, contentType: "practice_test", contentId: batchId);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => TestInstructionsScreen()));
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
                      color: isCompleted 
                      ?AppColors.primaryGreen.withAlpha(20)
                       :AppColors.primaryOrange.withAlpha(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Iconify(Healthicons.i_exam_multiple_choice_outline,
                        size: 16, color: isCompleted 
                      ?AppColors.primaryGreen
                       :AppColors.primaryOrange),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            chapter,
                            style:
                                TextStyle(fontSize: 12, color: AppColors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      isCompleted
                          ? Row(
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
                          : Row(
                              children: [
                                Icon(
                                  Icons.schedule_rounded,
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text("due date on $uploadedDate",
                                    style: TextStyle(fontSize: 12))
                              ],
                            ),
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
