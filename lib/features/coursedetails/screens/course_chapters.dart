import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/features/coursedetails/provider/course_provider.dart';
import 'package:zephyr/features/coursedetails/screens/course_chapter_content.dart';
import 'package:zephyr/features/coursedetails/widgets/course_chapter_card.dart';
import 'package:zephyr/features/payment/screens/checkout_screen.dart';

class CourseChapters extends StatefulWidget {
  const CourseChapters({super.key});

  @override
  State<CourseChapters> createState() => _CourseChaptersState();
}

class _CourseChaptersState extends State<CourseChapters> {
  CourseProvider courseDetailProvider = CourseProvider();
  int? expandedSectionIndex;

  void _showSubscribePopup(BuildContext context) {
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
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(
                        builder: (contex) => CheckoutScreen(
                              courseId: "1",
                            )));
              },
              child: Text("Subscribe")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    courseDetailProvider = context.watch<CourseProvider>();
    return Scaffold(
      body: courseDetailProvider.isLoading
          ? CircularProgressIndicator()
          : (courseDetailProvider.courseData.subjects ?? []).isEmpty
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Column(
                    children: [
                      Lottie.asset("assets/lottie/nodata.json", height: 200),
                      Text("No Chapters Available!"),
                    ],
                  ),
                ))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => CourseChapterCard(
                                  title: (courseDetailProvider
                                                  .courseData.subjects ??
                                              [])[index]
                                          .subject ??
                                      "Subject Name",
                                  subtitle: (courseDetailProvider
                                                  .courseData.subjects ??
                                              [])[index]
                                          .className ??
                                      "Class Name",
                                  items: ((courseDetailProvider
                                                      .courseData.subjects ??
                                                  [])[index]
                                              .chapters ??
                                          [])
                                      .map((chapter) =>
                                          chapter.chapterTitle ??
                                          "Chapter Title")
                                      .toList(),
                                  onSelected: (value) {},
                                  onTap: () {
                                    setState(() {
                                      expandedSectionIndex =
                                          expandedSectionIndex == index
                                              ? null
                                              : index;
                                    });
                                  },
                                  isExpanded: expandedSectionIndex == index,
                                  onFreeItemTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              CourseChapterContent()),
                                    );
                                  },
                                  onLockedTap: (index) =>
                                      _showSubscribePopup(context),
                                ),
                            // separatorBuilder: (context, index) => SizedBox(height: 5),
                            itemCount:
                                (courseDetailProvider.courseData.subjects ?? [])
                                    .length),
                      ],
                    ),
                  ),
                ),
    );
  }
}
