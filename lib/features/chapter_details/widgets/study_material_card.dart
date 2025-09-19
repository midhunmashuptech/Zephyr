import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/chapter_details/screens/pdf_viewer.dart';
import 'package:zephyr/features/drawer/provider/timeline_provider.dart';

class StudyMaterialCard extends StatelessWidget {
  final String name;
  final String batchId;
  final String chapter;
  final String uploadedDate;
  final String link;

  const StudyMaterialCard({
    required this.name,
    required this.chapter,
    required this.uploadedDate,
    required this.link,
    required this.batchId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final timelineProvider = context.read<TimelineProvider>();
    return GestureDetector(
      onTap: () async {
        await timelineProvider.postTimelineActivity(
            context: context, contentType: "material", contentId: batchId);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PdfViewer(url: link)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
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
                    color: AppColors.primaryRed.withAlpha(20),
                  ),
                  child: Icon(FluentIcons.document_pdf_24_regular,
                      size: MediaQuery.of(context).size.width * 0.1 > 70
                          ? 70
                          : MediaQuery.of(context).size.width * 0.1,
                      color: AppColors.primaryRed),
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
                            name,
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
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_rounded,
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          Text("uploaded on $uploadedDate",
                              style: TextStyle(fontSize: 12))
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
