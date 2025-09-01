import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/auth/provider/auth_provider.dart';
import 'package:zephyr/features/auth/registration/screens/registration_password.dart';
import 'package:zephyr/features/auth/registration/widgets/syllabus_widget.dart';

class RegistrationSyllabus extends StatefulWidget {
  const RegistrationSyllabus({super.key});

  @override
  State<RegistrationSyllabus> createState() => _RegistrationSyllabusState();
}

class _RegistrationSyllabusState extends State<RegistrationSyllabus> {
  AuthProvider authProvider = AuthProvider();

  @override
  Widget build(BuildContext context) {
    authProvider = context.watch<AuthProvider>();
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
                      child: Text(
                        "Choose the board you’re studying under to continue. ",
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      spacing: 10,
                      children: [
                        ...List.generate(
                            authProvider.syllabusDropdownOptions.length,
                            (index) => GestureDetector(
                                  onTap: () => authProvider.setSelectedSyllabus(
                                      authProvider
                                          .syllabusDropdownOptions[index].id),
                                  child: SyllabusWidget(
                                    label: authProvider
                                            .syllabusDropdownOptions[index]
                                            .title ??
                                        "Syllabus Title",
                                    index: index,
                                    color: (() {
                                      switch (authProvider
                                              .syllabusDropdownOptions[index]
                                              .id ??
                                          0) {
                                        case 1:
                                          return AppColors.primaryBlue;
                                        case 2:
                                          return AppColors.primaryGreen;
                                        case 3:
                                          return AppColors.primaryOrange;
                                        case 4:
                                          return AppColors.primaryRed;
                                        default:
                                          return AppColors.primaryBlue;
                                      }
                                    })(),
                                    selectedIndex:
                                        authProvider.selectedSyllabusId,
                                  ),
                                )),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      text: "Next",
                      color: AppColors.black,
                      textcolor: AppColors.white,
                      onPressed: authProvider.selectedSyllabusId == null
                          ? null
                          : () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationPassword()));
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
