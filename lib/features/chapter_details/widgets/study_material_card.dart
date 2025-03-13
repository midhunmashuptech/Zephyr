import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/data_class/study_material.dart';
import 'package:zephyr/features/chapter_details/screens/pdf_viewer.dart';

class StudyMaterialCard extends StatelessWidget {
  final StudyMaterial studyMaterial;
  const StudyMaterialCard({super.key, required this.studyMaterial});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PdfViewer())
        );
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
                    color: studyMaterial.type == "image"
                        ? AppColors.primaryBlue
                        : AppColors.primaryRed,
                  ),
                  child: Icon(
                    studyMaterial.type == "image"
                        ? FluentIcons.image_28_regular
                        : FluentIcons.document_pdf_24_regular,
                    size: MediaQuery.of(context).size.width * 0.1 > 70
                        ? 70
                        : MediaQuery.of(context).size.width * 0.1,
                    color: AppColors.white,
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
                            studyMaterial.name ?? "No Title",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            studyMaterial.chapter ?? "No Chapter",
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
                          Text("uploaded on ${studyMaterial.uploadDate}",
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
