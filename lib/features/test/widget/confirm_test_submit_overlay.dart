import 'package:flutter/material.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/test/widget/quiz_summary_item.dart';

class ConfirmTestSubmitOverlay extends StatelessWidget {
  const ConfirmTestSubmitOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          Text(
            "Are you sure you want\nEnd the test?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          QuizSummaryItem(Icons.help, "Total Questions", "10"),
          QuizSummaryItem(Icons.check_circle, "Questions Answered", "8"),
          QuizSummaryItem(Icons.cancel, "Questions Unanswered", "2"),
          QuizSummaryItem(Icons.error, "Total Questions Unattended", "1"),
          SizedBox(height: 20),
          CustomButton(
            text: "Submit Quiz",
            color: AppColors.primaryOrange,
            textcolor: AppColors.white,
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (contex) => TestCompletionScreen()));
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
