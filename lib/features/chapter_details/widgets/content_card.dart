import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/chapter_details/screens/practise_test_screen.dart';
import 'package:zephyr/features/chapter_details/screens/study_materials_screen.dart';

class ContentCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const ContentCard(
      {super.key,
      required this.icon,
      required this.label,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => switch (label) {
                      "Study Materials" => StudyMaterialsScreen(),
                      "Practice Tests" => PractiseTestScreen(),
                      // TODO: Handle this case.
                      String() => StudyMaterialsScreen(),
                    }));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 0.5 - 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HugeIcon(
              icon: icon,
              size: MediaQuery.of(context).size.width * 0.15,
              color: AppColors.white,
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: AppColors.white),
            )
          ],
        ),
      ),
    );
  }
}
