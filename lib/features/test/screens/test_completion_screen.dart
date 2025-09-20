import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/test/screens/make_your_test_solution.dart';

class TestCompletionScreen extends StatelessWidget {
  const TestCompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                "Bravo, Kim Shin!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              Text("You did it! Your hard work paid off!"),
              Center(
                  child: Image.asset(
                "assets/images/congrats.png",
                width: MediaQuery.of(context).size.width * 0.6,
              )),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.width * 0.35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width),
                        color: AppColors.primaryBlue),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.30,
                    height: MediaQuery.of(context).size.width * 0.30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width),
                        color: AppColors.white),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.28,
                    height: MediaQuery.of(context).size.width * 0.28,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width),
                        color: AppColors.primaryBlue),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.24,
                    height: MediaQuery.of(context).size.width * 0.24,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width),
                        color: AppColors.white),
                  ),
                  Column(
                    children: [
                      Text(
                        "Your Score",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "25/30",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                text: "Show Solutions",
                color: AppColors.primaryOrange,
                textcolor: AppColors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MakeYourTestSolution()));
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                  text: "Close Test",
                  onPressed: () {
                    Get.offAll(BottomNavScreen());
                  },
                  color: AppColors.secondaryViolet,
                  textcolor: AppColors.white),
              SizedBox(height: 10),
            ],
          ),
        ),
      )),
    );
  }
}
