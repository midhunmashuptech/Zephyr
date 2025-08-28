import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/features/enrolled_courses/provider/enrolled_course_provider.dart';
import 'package:zephyr/features/enrolled_courses/widgets/enrolled_chapter_card.dart';

class EnrolledCourseChapter extends StatefulWidget {
  const EnrolledCourseChapter({super.key});

  @override
  State<EnrolledCourseChapter> createState() => _EnrolledCourseChapterState();
}

class _EnrolledCourseChapterState extends State<EnrolledCourseChapter> {
  int? expandedSectionIndex;
  EnrolledCourseProvider enrolledCourseProvider = EnrolledCourseProvider();
  @override
  void initState() {
    super.initState();
    loadChapters();
  }

  Future<void> loadChapters() async {
    final loadProvider = context.read<EnrolledCourseProvider>();
    await loadProvider.fetchEnrolledChapter(context, "1", "1");
  }

  @override
  Widget build(BuildContext context) {
    enrolledCourseProvider = context.watch<EnrolledCourseProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              EnrolledChapterCard(
                title: "Physics",
                items: enrolledCourseProvider.chapterList,
                onSelected: (value) {},
                onTap: () {
                  setState(() {
                    expandedSectionIndex = expandedSectionIndex == 0 ? null : 0;
                  });
                },
                isExpanded: expandedSectionIndex == 0,
                subtitle: 'Class 7',
              ),
              // EnrolledChapterCard(
              //   title: "Mathematics",
              //   items: ["Chapter 1", "Chapter 2", "Chapter 3"],
              //   onSelected: (value) {},
              //   onTap: () {
              //     setState(() {
              //       expandedSectionIndex = expandedSectionIndex == 1 ? null : 1;
              //     });
              //   },
              //   isExpanded: expandedSectionIndex == 1,
              //   subtitle: 'Class 7',
              // ),
              // EnrolledChapterCard(
              //   title: "Biology",
              //   items: ["Chapter 1", "Chapter 2", "Chapter 3"],
              //   onSelected: (value) {},
              //   onTap: () {
              //     setState(() {
              //       expandedSectionIndex = expandedSectionIndex == 2 ? null : 2;
              //     });
              //   },
              //   isExpanded: expandedSectionIndex == 2,
              //   subtitle: 'Class 7',
              // ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
