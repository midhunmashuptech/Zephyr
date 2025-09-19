import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/icons/ion.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:iconify_flutter_plus/icons/mingcute.dart';
import 'package:iconify_flutter_plus/icons/ph.dart';
import 'package:iconify_flutter_plus/icons/tabler.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/test_series/widgets/test_detail_widget.dart';
import 'package:zephyr/features/test_series/widgets/test_report_card.dart';

class TestReviewScreen extends StatefulWidget {
  const TestReviewScreen({super.key});

  @override
  State<TestReviewScreen> createState() => _TestReviewScreenState();
}

class _TestReviewScreenState extends State<TestReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Test Review"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            TestReportCard(
              date: '26/09/2025',
              duration: '1 hr',
              questionno: "2",
            ),
            SizedBox(height: 10),
            CustomButton(
              text: 'View Solution',
              color: AppColors.primaryOrange,
              onPressed: () {},
              textcolor: AppColors.white,
            ),
            SizedBox(height: 20),

            //Test Score Details
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: TestDetailWidget(
                            label: "Score",
                            value: '4/100',
                            icon: Ph.star_fill,
                            size: 80,
                            color: AppColors.primaryBlue)),
                    SizedBox(width: 10),
                    Expanded(
                        child: TestDetailWidget(
                            label: "Average Time",
                            value: '1.64s',
                            icon: Ph.clock_fill,
                            size: 80,
                            color: AppColors.primaryGreen))
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: TestDetailWidget(
                            label: "Accuracy",
                            value: '25%',
                            icon: Ph.target_bold,
                            size: 100,
                            color: AppColors.primaryOrange)),
                    SizedBox(width: 10),
                    Expanded(
                        child: TestDetailWidget(
                            label: "Rank",
                            value: '6',
                            icon: Ion.md_trophy,
                            size: 100,
                            color: AppColors.primaryRed))
                  ],
                ),
              ],
            )

            // Score Analysis
          ]),
        ),
      ),
    );
  }
}
