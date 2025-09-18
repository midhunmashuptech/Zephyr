import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart' show AppColors;
import 'package:zephyr/features/coursedetails/widgets/course_content_card.dart';

class CourseChapterContent extends StatefulWidget {
  const CourseChapterContent({super.key});

  @override
  State<CourseChapterContent> createState() => _CourseChapterContentState();
}

class _CourseChapterContentState extends State<CourseChapterContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // BackButton(),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        BackButton(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Trignometry",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                            Text("The Mathematics of Angles and Triangles"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                CourseContentCard(
                  title: 'Video',
                  subtitle: 'Tap to see the video',
                  icon: Icons.videocam,
                  bgcolor: AppColors.primaryBlue,
                  lockicon: Icons.lock,
                ),
                CourseContentCard(
                  title: 'Image',
                  subtitle: 'Tap to see the image',
                  icon: Icons.image,
                  bgcolor: AppColors.primaryGreen,
                  lockicon: Icons.lock,
                ),
                CourseContentCard(
                  title: 'pdf',
                  subtitle: 'Tap to see the pdf',
                  icon: Icons.picture_as_pdf,
                  bgcolor: AppColors.primaryRed,
                  lockicon: Icons.lock,
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}