import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ci.dart';
import 'package:iconify_flutter_plus/icons/fa_solid.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/test/screens/test_completion_screen.dart';
import 'package:zephyr/features/test/widgets/instruction_card.dart';

class TestInstructionsScreen extends StatelessWidget {
  const TestInstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              Center(
                  child: Image.asset(
                "assets/images/quiz_bg.png",
                width: MediaQuery.of(context).size.width * 0.7,
              )),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                    ),
                    child: Column(
                      children: [
                        InstructionCard(
                          instext: "10 questions",
                          icon: Mdi.question_mark,
                          bgcolor: AppColors.primaryOrange,
                          instsubtext: "10 points for 1 correct answer",
                        ),
                        InstructionCard(
                          instext: "500 Points",
                          icon: FaSolid.award,
                          bgcolor: AppColors.darkBlue,
                          instsubtext: "Answer all your questions correctly",
                        ),
                        InstructionCard(
                          instext: "1 hr 30 min",
                          icon: Mdi.timer_outline,
                          bgcolor: AppColors.primaryGreen,
                          instsubtext: "Total duration of the quiz",
                        ),
                      ],
                    )),
              ),
              Text(
                "Instructions",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryGreen,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Please read the text below carefully so you can understand it",
                        style: TextStyle(
                            height: 1.2,
                            color: AppColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      Divider(
                        color: const Color.fromARGB(255, 217, 210, 210),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Iconify(
                            Ci.play_arrow,
                            size: 10,
                            color: AppColors.white,
                          ),
                          Expanded(
                            child: Text(
                              "10 point awarded for a correct answer and no marks for a incorrect answer",
                              maxLines: 2,
                              style: TextStyle(
                                  height: 1.2,
                                  color: AppColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Iconify(
                            Ci.play_arrow,
                            size: 10,
                            color: AppColors.white,
                          ),
                          Expanded(
                            child: Text(
                              "Tap on options to select the correct answer",
                              style: TextStyle(
                                  height: 1.2,
                                  color: AppColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Iconify(
                            Ci.play_arrow,
                            size: 10,
                            color: AppColors.white,
                          ),
                          Expanded(
                            child: Text(
                              "Tap on the bookmark icon to save interesting  questions.",
                              style: TextStyle(
                                  height: 1.2,
                                  color: AppColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Iconify(
                            Ci.play_arrow,
                            size: 10,
                            color: AppColors.white,
                          ),
                          Expanded(
                            child: Text(
                              "Click submit if you are sure you want to complete all the quizzes.",
                              style: TextStyle(
                                  height: 1.2,
                                  color: AppColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  text: "Start Quiz",
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TestCompletionScreen())),
                  color: AppColors.primaryOrange,
                  textcolor: AppColors.white),
            ],
          ),
        )),
      ),
    );
  }
}
