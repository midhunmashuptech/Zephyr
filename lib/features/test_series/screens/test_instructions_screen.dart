import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/fa_solid.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/test/screens/attend_test_screen.dart';

class TestInstructionsScreen extends StatelessWidget {
  final String testId;
  final String type;
  final int totalQuestions;
  final int maxMarks;
  final int duration;
  final String title;
  TestInstructionsScreen(
      {super.key,
      required this.testId,
      required this.type,
      required this.totalQuestions,
      required this.maxMarks,
      required this.title,
      required this.duration});

  UserDetailsProvider userDetailsProvider = UserDetailsProvider();

  @override
  Widget build(BuildContext context) {
    userDetailsProvider = context.watch<UserDetailsProvider>();
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Modern AppBar
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_rounded,
                          color: AppColors.primaryOrange),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    Text(
                      "Test Instructions",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
                const SizedBox(height: 24),
                // Modern Illustration
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryOrange.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Image.asset(
                      "assets/images/quiz_bg.png",
                      width: MediaQuery.of(context).size.width * 0.55,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                // Modern Info Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _ModernInfoCard(
                        icon: Mdi.question_mark,
                        label: totalQuestions.toString(),
                        subLabel: "Questions",
                        color: AppColors.primaryOrange,
                      ),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: _ModernInfoCard(
                        icon: FaSolid.award,
                        label: maxMarks.toString(),
                        subLabel: "Max Marks",
                        color: AppColors.darkBlue,
                      ),
                    ),SizedBox(width: 5,),
                    Expanded(
                      child: _ModernInfoCard(
                        icon: Mdi.timer_outline,
                        label: "${duration ~/ 60}h ${duration % 60}m",
                        subLabel: "Duration",
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Instructions Title
                Text(
                  "Instructions",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkBlue,
                  ),
                ),
                const SizedBox(height: 14),
                // Modern Instructions Card
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGreen.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Please read the instructions carefully before starting the quiz.",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 18),
                      ..._modernInstructions.map((text) => Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Iconify(
                                  FaSolid.star,
                                  size: 16,
                                  color: AppColors.lightOrangeGradient,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    text,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: AppColors.black.withOpacity(0.85),
                                      fontWeight: FontWeight.w400,
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                // Start Button
                Center(
                  child: CustomButton(
                    text: "Start Test",
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestAttendScreen(
                          testid: testId.toString(),
                          type: type,
                          title: title,
                          userid: userDetailsProvider.userDetails.id.toString(),
                        ),
                        // builder: (context) => const TestCompletionScreen(),
                      ),
                    ),
                    color: AppColors.primaryOrange,
                    textcolor: AppColors.white,
                    // borderRadius: 14,
                    // elevation: 2,
                    // fontSize: 18,
                    // padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModernInfoCard extends StatelessWidget {
  final String icon;
  final String label;
  final String subLabel;
  final Color color;

  const _ModernInfoCard({
    required this.icon,
    required this.label,
    required this.subLabel,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.09),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 20,
            child: Iconify(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            subLabel,
            style: TextStyle(
              color: color.withOpacity(0.7),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

const List<String> _modernInstructions = [
  "Correct and incorrect marks are shown for each and every questions.",
  "Tap on Options to select the correct answers.",
  "Save each exam answers before submitting (press save button).",
  "Once saved cannot be changed.",
  "Press submit after saving the answers to complete exam (Press submit and end button).",
  "You can end the exam at any time by pressing the end exam button.",
];
