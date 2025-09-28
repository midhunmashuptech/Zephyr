import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/icons/academicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/constants/app_constants.dart' show AppColors;
import 'package:zephyr/features/coursedetails/provider/course_provider.dart';
import 'package:zephyr/features/coursedetails/widgets/course_content_card.dart';

class CourseChapterContent extends StatefulWidget {
  const CourseChapterContent({super.key});

  @override
  State<CourseChapterContent> createState() => _CourseChapterContentState();
}

class _CourseChapterContentState extends State<CourseChapterContent> {
  CourseProvider courseProvider = CourseProvider();

  @override
  Widget build(BuildContext context) {
    courseProvider = context.watch<CourseProvider>();

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BackButton(),
                      Text(
                        courseProvider.selectedChapter.chapterTitle ??
                            "Chapter Title",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        // No Content
                        if (((courseProvider.selectedChapter.videos ?? [])
                                .isEmpty) &&
                            ((courseProvider.selectedChapter.materials ?? [])
                                .isEmpty) &&
                            ((courseProvider.selectedChapter.practiceTests ??
                                    [])
                                .isEmpty))
                          Center(
                      child: Column(
                        children: [
                          Lottie.asset("assets/lottie/nodata.json",
                              height: 150),
                          SizedBox(
                            height: 10,
                          ),
                          Text("No Course Contents Available")
                        ],
                      ),
                    ),

                        // Videos Listing
                        if ((courseProvider.selectedChapter.videos ?? [])
                                .length !=
                            0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Videos",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      CourseContentCard(
                                        type: "video",
                                        url: (courseProvider.selectedChapter
                                                        .videos ??
                                                    [])[index]
                                                .hls ??
                                            "Video Title",
                                        title: (courseProvider.selectedChapter
                                                        .videos ??
                                                    [])[index]
                                                .title ??
                                            "Video Title",
                                        subtitle: 'Tap to play the video',
                                        icon: Icons.videocam,
                                        bgcolor: AppColors.primaryBlue,
                                        isFree: (courseProvider.selectedChapter
                                                        .videos ??
                                                    [])[index]
                                                .free ??
                                            false, 
                                        content_id: (courseProvider.selectedChapter
                                                        .videos ??
                                                    [])[index].chapterContentId.toString(),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 5),
                                  itemCount:
                                      (courseProvider.selectedChapter.videos ??
                                              [])
                                          .length),
                              SizedBox(height: 10),
                            ],
                          ),

                        // Materials Listing
                        if ((courseProvider.selectedChapter.materials ?? [])
                                .length !=
                            0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Study Materials",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      CourseContentCard(
                                        type: "material",
                                        url: (courseProvider.selectedChapter.materials ?? [])[index].link ?? "https://d333c2xue188ia.cloudfront.net/assignments/vhFzVyubuJjRPqKilB0vSLEXRnYtKXNnYknZs5hA.pdf",
                                        title: (courseProvider.selectedChapter.materials ?? [])[index].title ?? "Material Title",
                                        subtitle:
                                            'Tap to see the Study Material',
                                        icon: Icons.picture_as_pdf,
                                        bgcolor: AppColors.primaryRed,
                                        isFree: (courseProvider.selectedChapter
                                                        .materials ??
                                                    [])[index]
                                                .free ??
                                            false,
                                        content_id: (courseProvider.selectedChapter
                                                        .materials ??
                                                    [])[index].chapterContentId.toString(),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 5),
                                  itemCount: (courseProvider
                                              .selectedChapter.materials ??
                                          [])
                                      .length),
                              SizedBox(height: 10),
                            ],
                          ),

                        // Practise Test Listing
                        if ((courseProvider.selectedChapter.practiceTests ?? [])
                                .length !=
                            0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Practise test",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      CourseContentCard(
                                        type: "practice_test",
                                        url: "",
                                        title: (courseProvider.selectedChapter.practiceTests ?? [])[index].title ?? "Practise Test Title",
                                        subtitle:
                                            'Tap attend the Practise Test',
                                            duration: (courseProvider.selectedChapter.practiceTests ?? [])[index].duration ?? 0,
                                            maxMark: (courseProvider.selectedChapter.practiceTests ?? [])[index].maxMarks ?? 0,
                                            questionCount: (courseProvider.selectedChapter.practiceTests ?? [])[index].questionCount ?? 0,
                                        icon: Icons.assessment,
                                        bgcolor: AppColors.primaryOrange,
                                        isFree: (courseProvider.selectedChapter
                                                        .practiceTests ??
                                                    [])[index]
                                                .free ??
                                            false, 
                                        content_id: (courseProvider.selectedChapter
                                                        .practiceTests ??
                                                    [])[index].chapterContentId.toString(),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 5),
                                  itemCount: (courseProvider
                                              .selectedChapter.practiceTests ??
                                          [])
                                      .length),
                            ],
                          ),
                      ],
                    ),
                  )

                  // CourseContentCard(
                  //   title: 'Video',
                  //   subtitle: 'Tap to see the video',
                  //   icon: Icons.videocam,
                  //   bgcolor: AppColors.primaryBlue,
                  //   lockicon: Icons.lock,
                  // ),
                  // CourseContentCard(
                  //   title: 'Image',
                  //   subtitle: 'Tap to see the image',
                  //   icon: Icons.image,
                  //   bgcolor: AppColors.primaryGreen,
                  //   lockicon: Icons.lock,
                  // ),
                  // CourseContentCard(
                  //   title: 'pdf',
                  //   subtitle: 'Tap to see the pdf',
                  //   icon: Icons.picture_as_pdf,
                  //   bgcolor: AppColors.primaryRed,
                  //   lockicon: Icons.lock,
                  // ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
