import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bxs.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/chapter_details/provider/enrolled_chapter_details_provider.dart';
import 'package:zephyr/features/chapter_details/screens/chapter_analysis_screen.dart';
import 'package:zephyr/features/chapter_details/screens/practise_test_screen.dart';
import 'package:zephyr/features/chapter_details/screens/study_materials_screen.dart';
import 'package:zephyr/features/chapter_details/screens/video_play_screen.dart';
import 'package:zephyr/features/chapter_details/screens/youtube_video_player.dart';
import 'package:zephyr/features/chapter_details/widgets/chapter_video_card.dart';
import 'package:zephyr/features/chapter_details/widgets/content_card.dart';
import 'package:zephyr/features/enrolled_courses/provider/enrolled_course_provider.dart';

class ChapterDetailsScreen extends StatefulWidget {
  const ChapterDetailsScreen({super.key});

  @override
  State<ChapterDetailsScreen> createState() => _ChapterDetailsScreenState();
}

class Content {
  String label;
  IconData icon;
  Color color;
  Function() onpressed;

  Content(
      {required this.label,
      required this.icon,
      required this.color,
      required this.onpressed});
}

class _ChapterDetailsScreenState extends State<ChapterDetailsScreen> {
  List<Content> content = [];
  EnrolledChapterDetailsProvider enrolledChapterDetailsProvider =
      EnrolledChapterDetailsProvider();

  @override
  void initState() {
    super.initState();
    loadVideos();
    content = [
      Content(
          label: "Study\nMaterials",
          icon: HugeIcons.strokeRoundedStudyLamp,
          color: AppColors.primaryGreen,
          onpressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StudyMaterialsScreen()));
          }),
      Content(
          label: "Practice\nTests",
          icon: HugeIcons.strokeRoundedTestTube01,
          color: AppColors.primaryBlue,
          onpressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PractiseTestScreen()));
          }),
      Content(
          label: "Chapter\nAnalysis",
          icon: HugeIcons.strokeRoundedPieChart,
          color: AppColors.primaryRed,
          onpressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChapterAnalysisScreen()));
          }),
    ];
  }

  Future<void> loadVideos() async {
    final loadProvider = context.read<EnrolledChapterDetailsProvider>();
    final enrollmentLoadProvider = context.read<EnrolledCourseProvider>();
    await loadProvider.getChapterVideos(
        context: context,
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
      body: SafeArea(
          child: enrolledChapterDetailsProvider.isVideosLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 300,
                            width: double.infinity,
                            child: CachedNetworkImage(
                              imageUrl: enrolledChapterDetailsProvider
                                      .selectedChapter.chapterThumbnail ??
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8hrpymVlFVUacFKLqwlFhCNnu2hVBhAeXQ&usqp=CAU",
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: AppColors.grey,
                                highlightColor: AppColors.lightGrey,
                                child: Container(
                                  height: 300,
                                  width: double.infinity,
                                  color: AppColors.white,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: BackButton(),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                enrolledChapterDetailsProvider
                                        .selectedChapter.chapterTitle ??
                                    "Chapter Name",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                            Text(
                              "${(enrolledChapterDetailsProvider.selectedSubject.subject ?? "Subject Name")} | ${(enrolledChapterDetailsProvider.selectedSubject.className ?? "Class Name")}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryBlue),
                            )
                          ],
                        ),
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemCount: content.length,
                          padding: EdgeInsets.all(10),
                          itemBuilder: (context, index) => ContentCard(
                              icon: content[index].icon,
                              label: content[index].label,
                              color: content[index].color,
                              onPressed: content[index].onpressed)),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Iconify(Bxs.videos, size: 20),
                            SizedBox(width: 10),
                            Text(
                              'Videos',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      enrolledChapterDetailsProvider.chapterVideos.isEmpty
                          ? Center(
                              child: Column(
                                children: [
                                  Lottie.asset("assets/lottie/nodata.json",
                                      height: 150),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("No Videos Found"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: enrolledChapterDetailsProvider
                                    .chapterVideos.length,
                                itemBuilder: (context, index) {
                                  return ChapterVideoCard(
                                    onPressed: () {
                                      enrolledChapterDetailsProvider
                                          .setCurrentVideo(index);
                                      enrolledChapterDetailsProvider
                                                  .currentlyPlayingVideo
                                                  .source ==
                                              "youtube"
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const YoutubeVideoPlayer(),
                                              ),
                                            )
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const VideoPlayScreen(),
                                              ),
                                            );
                                    },
                                    videoTitle: enrolledChapterDetailsProvider
                                            .chapterVideos[index].title ??
                                        "Video Title",
                                    thumbnail: enrolledChapterDetailsProvider
                                            .chapterVideos[index].thumbnail ??
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8hrpymVlFVUacFKLqwlFhCNnu2hVBhAeXQ&usqp=CAU",
                                    videoUrl: '',
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                )),
    );
  }
}
