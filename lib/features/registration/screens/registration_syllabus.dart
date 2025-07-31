import 'package:flutter/material.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/registration/screens/registration_password.dart';
import 'package:zephyr/features/registration/widgets/syllabus_widget.dart';

class RegistrationSyllabus extends StatefulWidget {
  const RegistrationSyllabus({super.key});

  @override
  State<RegistrationSyllabus> createState() => _RegistrationSyllabusState();
}

class Syllabus {
  final String label;
  final Color color;

  const Syllabus({required this.label, required this.color});
}

class _RegistrationSyllabusState extends State<RegistrationSyllabus> {
  int? selectedSyllabus;
  List<Syllabus> syllabusOptions = [
    Syllabus(label: "CBSE", color: AppColors.primaryBlue),
    Syllabus(label: "State", color: AppColors.primaryGreen),
    Syllabus(label: "ICSE", color: AppColors.primaryOrange),
    Syllabus(label: "Others", color: AppColors.primaryRed),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Customize ",
                            style: TextStyle(
                                fontSize: 25,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600)),
                        Text("Your Learning",
                            style: TextStyle(
                                fontSize: 25,
                                color: AppColors.primaryGreen,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text("Choose the board you’re studying under to continue. ",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                    ),
                    SizedBox(height: 20),
                    Column(
                      spacing: 10,
                      children: [
                        ...List.generate(
                        syllabusOptions.length,
                        (index) => GestureDetector(
                              onTap: () => setState(() {
                                selectedSyllabus = index;
                              }),
                              child: SyllabusWidget(
                                label: syllabusOptions[index].label,
                                index: index,
                                color: syllabusOptions[index].color,
                                selectedIndex: selectedSyllabus,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 20),
                    Builder(
                      builder: (context) {
                        return CustomButton(
                          text: "Next",
                          color: AppColors.black,
                          textcolor: AppColors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationPassword()));
                          },
                        );
                      },
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
