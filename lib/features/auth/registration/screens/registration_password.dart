import 'package:flutter/material.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/auth/login/widgets/custom_textfeild.dart';

class RegistrationPassword extends StatefulWidget {
  const RegistrationPassword({super.key});

  @override
  State<RegistrationPassword> createState() => _RegistrationPasswordState();
}

class _RegistrationPasswordState extends State<RegistrationPassword> {
  bool isChecked = false;
  bool isPwdVisible = true;
  bool isCPwdVisible = true;
  final TextEditingController gpwdController = TextEditingController();
  final TextEditingController gcpwdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Protect ",
                          style: TextStyle(
                              fontSize: 25,
                              color: AppColors.primaryGreen,
                              fontWeight: FontWeight.w600)),
                      Text("Your",
                          style: TextStyle(
                              fontSize: 25,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Learning Journey",
                          style: TextStyle(
                              fontSize: 25,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: "Enter your Password",
                    obscureText: isPwdVisible,
                    controller: gpwdController,
                    prefixIcon: Icon(Icons.lock_rounded),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPwdVisible = !isPwdVisible;
                        });
                      },
                      icon: isPwdVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    hintText: "Confirm your Password",
                    obscureText: isCPwdVisible,
                    controller: gcpwdController,
                    prefixIcon: Icon(Icons.lock_rounded),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isCPwdVisible = !isCPwdVisible;
                        });
                      },
                      icon: isCPwdVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                  ),
                  Row(children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                      focusColor: AppColors.black,
                      activeColor: AppColors.primaryGreen,
                    ),
                    const SizedBox(height: 16),
                    const Text('I Agree to the Terms and Conditions'),
                  ]),
                  CustomButton(
                    text: "Register",
                    color: AppColors.primaryGreen,
                    textcolor: AppColors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavScreen()));
                      // if (gpwdController.text != gcpwdController.text) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text("Passwords do not match"),
                      //     ),
                      //   );
                      // } else {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text("Registration Successful"),
                      //     ),
                      //   );
                      // }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
