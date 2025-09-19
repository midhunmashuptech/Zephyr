import 'package:flutter/material.dart';
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
                    SizedBox(width: 20),

            //Test Score Details
            Column(
              children: [
                Row(
                  children: [
                    Expanded(child: TestDetailWidget()),
                    SizedBox(width: 10),
                    Expanded(child: TestDetailWidget()),
                  ],
                ),
                    SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: TestDetailWidget()),
                    SizedBox(width: 10),
                    Expanded(child: TestDetailWidget()),
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
