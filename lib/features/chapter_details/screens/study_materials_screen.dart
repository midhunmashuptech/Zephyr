import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bi.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/features/chapter_details/provider/enrolled_chapter_details_provider.dart';
import 'package:zephyr/features/chapter_details/widgets/study_material_card.dart';
import 'package:zephyr/features/enrolled_courses/provider/enrolled_course_provider.dart';

class StudyMaterialsScreen extends StatefulWidget {
  const StudyMaterialsScreen({super.key});

  @override
  State<StudyMaterialsScreen> createState() => _StudyMaterialsScreenState();
}

class _StudyMaterialsScreenState extends State<StudyMaterialsScreen> {
  EnrolledChapterDetailsProvider enrolledChapterDetailsProvider =
      EnrolledChapterDetailsProvider();

  @override
  void initState() {
    super.initState();
    // Schedule after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadEnrolledChapterMaterials();
    });
  }

  Future<void> loadEnrolledChapterMaterials() async {
    final loadProvider = context.read<EnrolledChapterDetailsProvider>();
    final enrollmentLoadProvider = context.read<EnrolledCourseProvider>();
    await loadProvider.fetchEnrolledChapterMaterials(
        enrollmentId:
            (enrollmentLoadProvider.selectedEnrollment.enrollmentId ?? "0")
                .toString(),
        courseSubjectId:
            (loadProvider.selectedSubject.courseSubjectId ?? 0).toString(),
        courseChapterId:
            (loadProvider.selectedChapter.courseChapterId ?? 0).toString());
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
            Text("Study Materials"),
          ],
        ),
        leading: BackButton(),
      ),
      body: SafeArea(
        child: enrolledChapterDetailsProvider.isMaterialLoading
            ? Center(child: CircularProgressIndicator())
            : enrolledChapterDetailsProvider.enrolledChapterMaterials.isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/lottie/empty_data.json", width: 250),
                      SizedBox(height: 10),
                      Text("No Study Materials Available"),
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
                                .enrolledChapterMaterials.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return StudyMaterialCard(
                                batchId:
                                    "${enrolledChapterDetailsProvider.enrolledChapterMaterials[index].batchMaterialId}",
                                name: enrolledChapterDetailsProvider
                                        .enrolledChapterMaterials[index]
                                        .title ??
                                    "",
                                // chapter: enrolledChapterDetailsProvider
                                //         .enrolledChapterMaterials[index]
                                //         .description ??
                                //     "",
                                // uploadedDate: enrolledChapterDetailsProvider
                                //         .enrolledChapterMaterials[index]
                                //         .description ??
                                //     "",
                                link: enrolledChapterDetailsProvider
                                        .enrolledChapterMaterials[index].link ??
                                    "",
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
