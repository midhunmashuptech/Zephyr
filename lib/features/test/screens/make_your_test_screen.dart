import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/test/provider/make_test_provider.dart';
import 'package:zephyr/features/test/screens/test_loading.dart';

class MakeYourTestScreen extends StatefulWidget {
  const MakeYourTestScreen({super.key});

  @override
  State<MakeYourTestScreen> createState() => _MakeYourTestScreenState();
}

class _MakeYourTestScreenState extends State<MakeYourTestScreen> {
  MakeTestProvider makeTestProvider = MakeTestProvider();

  TextEditingController _quesCountController = TextEditingController();
  TextEditingController _sectionController = TextEditingController();
  TextEditingController _difficultyController = TextEditingController();

  Future loadClassSubjectOptions() async {
    final loadProvider = context.read<MakeTestProvider>();
    loadProvider.clearAllSelectedValues();
    await loadProvider.fetchClassSubjectsOptions();
  }

  // Future loadChapterOptions() async {
  //   final loadProvider = context.read<MakeTestProvider>();
  //   await loadProvider.fetchChapterOptions();
  // }

  // Future loadTopicOptions() async {
  //   final loadProvider = context.read<MakeTestProvider>();
  //   await loadProvider.fetchClassSubjectsOptions();
  // }

  @override
  void initState() {
    super.initState();
    loadClassSubjectOptions();
  }

  @override
  Widget build(BuildContext context) {
    makeTestProvider = context.watch<MakeTestProvider>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Lottie.asset("assets/lottie/makeYourTest.json"),
              RichText(
                  text: const TextSpan(children: [
                TextSpan(
                    text: "Make your own ",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w600)),
                TextSpan(
                    text: "TEST!",
                    style: TextStyle(
                        color: AppColors.primaryGreen,
                        fontSize: 26,
                        fontWeight: FontWeight.w600))
              ])),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Test your knowledge with a custom made set of questions according to your preferences",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              makeTestProvider.isOptionsLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        DropdownMenu(
                            hintText: "Number of questions",
                                onSelected: (value) =>
                                    makeTestProvider.setQuestionCount(int.parse(value ?? "10")),
                            width: MediaQuery.of(context).size.width * 0.8,
                            dropdownMenuEntries: [
                              DropdownMenuEntry(value: "5", label: "5"),
                              DropdownMenuEntry(value: "10", label: "10"),
                              DropdownMenuEntry(value: "15", label: "15"),
                              DropdownMenuEntry(value: "20", label: "20")
                            ]),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownMenu(
                                hintText: "Class",
                                onSelected: (value) =>
                                    makeTestProvider.setSelectedClass(value),
                                width: MediaQuery.of(context).size.width * 0.39,
                                dropdownMenuEntries: [
                                  ...List.generate(
                                    makeTestProvider.classOptions.length,
                                    (index) => DropdownMenuEntry(
                                        value:
                                            makeTestProvider.classes[index].id,
                                        label: makeTestProvider
                                                .classes[index].title ??
                                            "Option Value"),
                                  )
                                  // DropdownMenuEntry(value: "1", label: "Course 1"),
                                  // DropdownMenuEntry(value: "2", label: "Course 2"),
                                  // DropdownMenuEntry(value: "3", label: "Course 3"),
                                  // DropdownMenuEntry(value: "4", label: "Course 4")
                                ]),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.02),
                            DropdownMenu(
                                hintText: "Subject",
                                onSelected: (value) =>
                                    makeTestProvider.setSelectedSubject(value),
                                width: MediaQuery.of(context).size.width * 0.39,
                                dropdownMenuEntries: List.generate(
                                    makeTestProvider.subjectOptions.length,
                                    (index) => DropdownMenuEntry(
                                        value:
                                            makeTestProvider.subjects[index].id,
                                        label: makeTestProvider
                                                .subjects[index].title ??
                                            "Option Value"))
                                // [
                                //   DropdownMenuEntry(
                                //       value: "1", label: "Chemistry"),
                                //   DropdownMenuEntry(
                                //       value: "2", label: "Biology"),
                                //   DropdownMenuEntry(
                                //       value: "3", label: "Mathematics"),
                                //   DropdownMenuEntry(
                                //       value: "4", label: "Physics")
                                // ]
                                ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        DropdownMenu(
                            hintText: "Chapter",
                            width: MediaQuery.of(context).size.width * 0.8,
                            onSelected: (value) =>
                                makeTestProvider.setSelectedChapter(value),
                            dropdownMenuEntries: List.generate(
                                makeTestProvider.chapters.length,
                                (index) => DropdownMenuEntry(
                                    value: makeTestProvider.chapters[index].id,
                                    label: makeTestProvider
                                            .chapters[index].title ??
                                        "Option Value"))),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        DropdownMenu(
                            hintText: "Topic",
                            width: MediaQuery.of(context).size.width * 0.8,
                            onSelected: (value) =>
                                makeTestProvider.setSelectedTopic(value),
                            dropdownMenuEntries: List.generate(
                                makeTestProvider.topics.length,
                                (index) => DropdownMenuEntry(
                                    value: makeTestProvider.topics[index].id,
                                    label:
                                        makeTestProvider.topics[index].title ??
                                            "Option Value"))),
                        SizedBox(height: 10),
                        DropdownMenu(
                            hintText: "Difficulty Level",
                                onSelected: (value) =>
                                    makeTestProvider.setDifficltyevel(value),
                            width: MediaQuery.of(context).size.width * 0.8,
                            dropdownMenuEntries: [
                              DropdownMenuEntry(value: "low", label: "Low"),
                              DropdownMenuEntry(value: "medium", label: "Medium"),
                              DropdownMenuEntry(value: "high", label: "High"),
                              DropdownMenuEntry(value: "mixed", label: "Mixed")
                            ]),
                        SizedBox(height: 10),
                        CustomButton(
                          text: "Prepare Test",
                          width: MediaQuery.of(context).size.width * 0.8,
                          color: AppColors.primaryOrange,
                          textcolor: AppColors.white,
                          onPressed: () => makeTestProvider.printAllSelectedValues()
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => TestLoading())),
                        ),
                      ],
                    ),
              SizedBox(height: 30),
            ],
          ),
        ),
      )),
    );
  }
}
