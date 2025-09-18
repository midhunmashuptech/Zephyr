import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bi.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/features/chapter_details/provider/enrolled_chapter_details_provider.dart';
import 'package:zephyr/features/chapter_details/widgets/practise_test_card.dart';
import 'package:zephyr/features/enrolled_courses/provider/enrolled_course_provider.dart';

class PractiseTestScreen extends StatefulWidget {
  const PractiseTestScreen({super.key});

  @override
  State<PractiseTestScreen> createState() => _PractiseTestScreenState();
}

class _PractiseTestScreenState extends State<PractiseTestScreen> {
  EnrolledChapterDetailsProvider enrolledChapterDetailsProvider =
      EnrolledChapterDetailsProvider();

  @override
  void initState() {
    super.initState();
    // Schedule after first frame
  WidgetsBinding.instance.addPostFrameCallback((_) {
    loadTest();
  });
  }

  Future<void> loadTest() async {
    final loadProvider = context.read<EnrolledChapterDetailsProvider>();
    final enrolledCourseProvider = context.read<EnrolledCourseProvider>();
    loadProvider.fetchEnrolledChapterTest(
        context: context,
        enrollmentId: (enrolledCourseProvider.selectedEnrollment.enrollmentId ?? 0).toString(),
        courseSubjectId: (loadProvider.selectedSubject.courseSubjectId ?? 0).toString(),
        courseChapterId: (loadProvider.selectedChapter.courseChapterId ?? 0).toString()
        );
  }

  @override
  Widget build(BuildContext context) {
    enrolledChapterDetailsProvider =
        context.watch<EnrolledChapterDetailsProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Iconify(Bi.box_fill, size: 22),
            SizedBox(width: 10),
            Text("Practise Tests"),
          ],
        ),
        leading: BackButton(),
      ),
      body: SafeArea(
        child: enrolledChapterDetailsProvider.isTestsLoading
            ? Center(child: CircularProgressIndicator())
            : enrolledChapterDetailsProvider.enrolledChapterTests.isEmpty 
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/lottie/empty_data.json", width: 250),
                  SizedBox(height: 10),
                  Text("No practise tests available"),
                ],
              ))
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      ListView.builder(
                        itemCount: enrolledChapterDetailsProvider
                            .enrolledChapterTests.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return PractiseTestCard(
                            title: enrolledChapterDetailsProvider
                                    .enrolledChapterTests[index].title ??
                                "Title",
                            chapter: enrolledChapterDetailsProvider
                                    .enrolledChapterTests[index].description ??
                                "Chapter",
                            uploadedDate: "22/02/2002", 
                            isCompleted: enrolledChapterDetailsProvider.enrolledChapterTests[index].isAttended ?? false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
