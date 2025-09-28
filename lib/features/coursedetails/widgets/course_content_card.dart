import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/provider/course_provider.dart';
import 'package:zephyr/features/coursedetails/screens/sample_chapter_pdf_viewer.dart';
import 'package:zephyr/features/coursedetails/screens/sample_chapter_video_player.dart';
import 'package:zephyr/features/payment/screens/checkout_screen.dart';
import 'package:zephyr/features/test_series/screens/test_instructions_screen.dart';

class CourseContentCard extends StatefulWidget {
  final String type;
  final String title;
  final String url;
  final String content_id;
  final String subtitle;
  final Color bgcolor;
  final IconData icon;
  final bool isFree;
  final int? maxMark;
  final int? questionCount;
  final int? duration;

  const CourseContentCard(
      {required this.type,
      required this.title,
      required this.url,
      required this.content_id,
      required this.subtitle,
      required this.icon,
      required this.bgcolor,
      required this.isFree,
      super.key, this.maxMark, this.questionCount, this.duration});

  @override
  State<CourseContentCard> createState() => _CourseContentCardState();
}

void _showSubscribePopup(BuildContext context) {
  final courseProvider = context.read<CourseProvider>();
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("Start Learning Today"),
      content: Text(
          "Subscribe to gain unlimited access to all lessons and resources."),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: Text("Cancel")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (contex) => CheckoutScreen(
                        courseId: "${courseProvider.courseData.id ?? 0}",
                      )));
            },
            child: Text("Subscribe")),
      ],
    ),
  );
}

class _CourseContentCardState extends State<CourseContentCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isFree) {
          if (widget.type == "video") {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (contex) => SampleChapterVideoPlayer(
                      videoUrl: widget.url,
                      videoName: widget.title,
                    )));
          } else if (widget.type == "material") {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (contex) => SampleChapterPdfViewer(
                    title: widget.title, url: widget.url)));
          } else if (widget.type == "test") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => TestInstructionsScreen(
                          testId: widget.content_id,
                          type: widget.type,
                          duration: widget.duration ?? 0,
                          maxMarks: widget.maxMark ?? 0,
                          title: widget.title,
                          totalQuestions: widget.questionCount ?? 0,
                        )));
          }
        } else {
          _showSubscribePopup(context);
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
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: widget.bgcolor.withAlpha(20),
                ),
                child: Icon(
                  widget.icon,
                  // FluentIcons.document_pdf_24_regular,
                  size: 40,
                  color: widget.bgcolor,
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
                          widget.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.subtitle,
                          style:
                              TextStyle(fontSize: 12, color: AppColors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(widget.isFree ? Icons.lock_open : Icons.lock,
                  color:
                      widget.isFree ? AppColors.primaryGreen : AppColors.grey)
            ],
          ),
        ),
      ),
    );
  }
}
