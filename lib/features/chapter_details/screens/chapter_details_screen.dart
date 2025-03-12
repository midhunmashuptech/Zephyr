import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bxs.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/chapter_details/screens/video_play_screen.dart';
import 'package:zephyr/features/chapter_details/widgets/chapter_video_card.dart';
import 'package:zephyr/features/chapter_details/widgets/content_card.dart';

class ChapterDetailsScreen extends StatefulWidget {
  const ChapterDetailsScreen({super.key});

  @override
  State<ChapterDetailsScreen> createState() => _ChapterDetailsScreenState();
}

class _ChapterDetailsScreenState extends State<ChapterDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                    child: ContentCard(
                  color: AppColors.primaryBlue,
                  icon: HugeIcons.strokeRoundedStudyLamp,
                  label: "Study Materials",
                )),
                SizedBox(width: 20),
                Expanded(
                    child: ContentCard(
                  color: AppColors.primaryOrange,
                  icon: HugeIcons.strokeRoundedTestTube,
                  label: "Practice Tests",
                ))
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 10),
                Iconify(Bxs.videos, size: 20),
                SizedBox(width: 10),
                Text(
                  'Chapter Videos',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ChapterVideoCard(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideoPlayScreen()));
                      },
                    );
                  }),
            )
          ],
        ),
      )),
    );
  }
}
