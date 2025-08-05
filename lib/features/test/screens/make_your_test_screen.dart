import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/login/widgets/custom_textfeild.dart';

class MakeYourTestScreen extends StatefulWidget {
  const MakeYourTestScreen({super.key});

  @override
  State<MakeYourTestScreen> createState() => _MakeYourTestScreenState();
}

class _MakeYourTestScreenState extends State<MakeYourTestScreen> {
  TextEditingController _quesCountController = TextEditingController();
  TextEditingController _sectionController = TextEditingController();
  TextEditingController _difficultyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/lottie/makeYourTest.json"),
            RichText(
                text: const TextSpan(children: [
              TextSpan(
                  text: "Make your own ",
                  style: TextStyle(color: AppColors.black, fontSize: 26, fontWeight: FontWeight.w600)),
              TextSpan(
                  text: "TEST!",
                  style: TextStyle(color: AppColors.primaryGreen, fontSize: 26, fontWeight: FontWeight.w600))
            ])),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Test your knowledge with a custom made set of questions according to your preferences",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            DropdownMenu(
                hintText: "Number of questions",
                width: MediaQuery.of(context).size.width * 0.8,
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: "5", label: "5"),
                  DropdownMenuEntry(value: "10", label: "10"),
                  DropdownMenuEntry(value: "15", label: "15"),
                  DropdownMenuEntry(value: "20", label: "20")
                ]),
            SizedBox(height: 10),
            DropdownMenu(
                hintText: "Section",
                width: MediaQuery.of(context).size.width * 0.8,
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: "1", label: "Mental Ability"),
                  DropdownMenuEntry(
                      value: "2", label: "Foundation of Mahematics"),
                  DropdownMenuEntry(value: "3", label: "Critical Thinking"),
                  DropdownMenuEntry(value: "4", label: "General Knowledge")
                ]),
            SizedBox(height: 10),
            DropdownMenu(
                hintText: "Difficulty Level",
                width: MediaQuery.of(context).size.width * 0.8,
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: "1", label: "Low"),
                  DropdownMenuEntry(value: "2", label: "Medium"),
                  DropdownMenuEntry(value: "3", label: "High"),
                  DropdownMenuEntry(value: "4", label: "Mixed")
                ]),
            SizedBox(height: 10),
            CustomButton(
              text: "Prepare Test",
              width: MediaQuery.of(context).size.width * 0.8,
              color: AppColors.primaryOrange,
              textcolor: AppColors.white,
            )
          ],
        ),
      )),
    );
  }
}
