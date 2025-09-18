import 'package:flutter/material.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/test_series/widgets/weekly_test_card.dart';

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
        child: Column(children: [
          WeeklyTestCard(
            date: '26/09/2025',
            duration: '1 hr',
            questionno: "2",
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              text: 'View Solution',
              color: AppColors.primaryOrange,
              onPressed: (){},
              textcolor: AppColors.white,
            ),
          ),
        ]),
      ),
    );
  }
}
