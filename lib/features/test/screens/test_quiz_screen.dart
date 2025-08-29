import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/test/provider/make_test_provider.dart';

class TestQuizScreen extends StatefulWidget {
  const TestQuizScreen({super.key});

  @override
  State<TestQuizScreen> createState() => _TestQuizScreenState();
}

// class TestQuiz {
//   String title;
//   String description;
//   String correctOption;
//   List<String> options;
//   TestQuiz({
//     required this.title,
//     required this.description,
//     required this.correctOption,
//     required this.options,
//   });
// }

class _TestQuizScreenState extends State<TestQuizScreen> {
  MakeTestProvider makeTestProvider = MakeTestProvider();
  bool isOpen = false;
  // List<TestQuiz> testquiz = [
  //   TestQuiz(
  //       title:
  //           "Which gas is primarily responsible for the greenhouse effect on Earth?",
  //       description:
  //           "The greenhouse effect is the process by which certain gases in Earth’s atmosphere trap heat, keeping the planet warm enough to support life. Among these gases, carbon dioxide (CO₂) is one of the most significant contributors, along with methane and water vapor.",
  //       options: [
  //         "Oxygen (O₂)",
  //         "Carbon dioxide (CO₂)",
  //         "Nitrogen (N₂)",
  //         "Argon (Ar)",

  //       ],
  //       correctOption: 'Carbon dioxide (CO₂)')
  // ];
  String? _selectedOption;
  @override
  Widget build(BuildContext context) {
    makeTestProvider = context.watch<MakeTestProvider>();
    return Scaffold(
      // backgroundColor: AppColors.grey,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Question ${makeTestProvider.currentQuestion + 1} of ${makeTestProvider.aiGeneratedQuiz.length}",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 234, 234),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        makeTestProvider
                                .aiGeneratedQuiz[
                                    makeTestProvider.currentQuestion]
                                .questionText ??
                            "Question",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //     makeTestProvider
                      //             .aiGeneratedQuiz[
                      //                 makeTestProvider.currentQuestion]
                      //             .explanation ??
                      //         "Explanation",
                      //     style: TextStyle(fontWeight: FontWeight.w400))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: (makeTestProvider
                                .aiGeneratedQuiz[
                                    makeTestProvider.currentQuestion]
                                .options ??
                            [])
                        .length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                                  print(index);
                                  _selectedOption = index.toString();
                                });
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: _selectedOption == null
                                    ? AppColors.grey
                                    : (_selectedOption == index.toString())
                                        ? (makeTestProvider.correctOption
                                                    .toString() ==
                                                _selectedOption)
                                            ? AppColors.primaryGreen
                                            : AppColors.primaryRed
                                        : AppColors.grey),
                            borderRadius: BorderRadius.circular(10),
                            color: _selectedOption == null
                                    ? AppColors.white
                                    : (_selectedOption == index.toString())
                                        ? (makeTestProvider.correctOption
                                                    .toString() ==
                                                _selectedOption)
                                            ? AppColors.primaryGreen.withAlpha(40)
                                            : AppColors.primaryRed.withAlpha(40)
                                        : AppColors.white),
                        child: Row(
                          children: [
                            Radio<String>(
                              value: index.toString(),
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  print(value);
                                  _selectedOption = value;
                                });
                              },
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                                child: Text(
                                  (makeTestProvider
                                          .aiGeneratedQuiz[
                                              makeTestProvider.currentQuestion]
                                          .options ??
                                      [])[index],
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     ElevatedButton(
                  //         onPressed: makeTestProvider.currentQuestion == 0
                  //             ? null
                  //             : () {
                  //                 setState(() {
                  //                   isOpen = false;
                  //                 });
                  //                 makeTestProvider.previousQuestion();
                  //               },
                  //         style: ElevatedButton.styleFrom(
                  //             backgroundColor: AppColors.primaryOrange,
                  //             textStyle: TextStyle(
                  //                 fontSize: 16, fontWeight: FontWeight.w400)),
                  //         child: Text(
                  //           "Previous",
                  //           style: TextStyle(color: AppColors.white),
                  //         )),
                  //     ElevatedButton(
                  //         onPressed: makeTestProvider.currentQuestion ==
                  //                 (makeTestProvider.aiGeneratedQuiz.length - 1)
                  //             ? null
                  //             : () {
                  //                 setState(() {
                  //                   isOpen = false;
                  //                 });
                  //                 makeTestProvider.nextQuestion();
                  //               },
                  //         style: ElevatedButton.styleFrom(
                  //             backgroundColor: AppColors.primaryOrange,
                  //             textStyle: TextStyle(
                  //                 fontSize: 16, fontWeight: FontWeight.w400)),
                  //         child: Text(
                  //           "Next",
                  //           style: TextStyle(color: AppColors.white),
                  //         )),
                  //   ],
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: "Previous",
                          color: AppColors.primaryOrange,
                          textcolor: AppColors.white,
                          onPressed: makeTestProvider.currentQuestion == 0
                              ? null
                              : () {
                                  setState(() {
                                    _selectedOption = null;
                                    isOpen = false;
                                  });
                                  makeTestProvider.previousQuestion();
                                },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: CustomButton(
                          text: "Next",
                          color: AppColors.primaryOrange,
                          textcolor: AppColors.white,
                          onPressed: makeTestProvider.currentQuestion ==
                                  (makeTestProvider.aiGeneratedQuiz.length - 1)
                              ? null
                              : () {
                                  setState(() {
                                    isOpen = false;
                                    _selectedOption = null;
                                  });
                                  makeTestProvider.nextQuestion();
                                },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "Submit Quiz",
                    color: AppColors.primaryBlue,
                    onPressed: () {
                      showSnackBar("Hurray!",
                          "You have succesfully completed the quiz!");
                      Get.offAll(BottomNavScreen());
                    },
                    textcolor: AppColors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => setState(() {
                  isOpen = !isOpen;
                }),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: isOpen
                          ? const Color.fromARGB(255, 247, 255, 226)
                          : const Color.fromARGB(255, 238, 234, 234),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Solution",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        isOpen
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      makeTestProvider
                                              .aiGeneratedQuiz[makeTestProvider
                                                  .currentQuestion]
                                              .explanation ??
                                          "Explanation",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400)),
                                ],
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
