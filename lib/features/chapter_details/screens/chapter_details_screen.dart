import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bxs.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/chapter_details/screens/chapter_analysis_screen.dart';
import 'package:zephyr/features/chapter_details/screens/practise_test_screen.dart';
import 'package:zephyr/features/chapter_details/screens/study_materials_screen.dart';
import 'package:zephyr/features/chapter_details/screens/video_play_screen.dart';
import 'package:zephyr/features/chapter_details/widgets/chapter_video_card.dart';
import 'package:zephyr/features/chapter_details/widgets/content_card.dart';

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

  @override
  void initState() {
    super.initState();
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
          label: "Practical\nTests",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/course_bg1.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Trignometry',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      Text(
                        "Class:7",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryBlue),
                      )
                    ],
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ChapterVideoCard(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VideoPlayScreen(),
                        ),
                      );
                    },
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
