import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';
import 'package:zephyr/features/login/screens/forgot_password_screen.dart';
import 'package:zephyr/features/login/widgets/custom_textfeild.dart';
import 'package:zephyr/features/registration/screens/registration_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LayoutGradient(gradient: AppColors.blueGradient),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Lottie.asset('assets/lottie/login.json',
                        height: 300, width: 300),
                  ),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  /// Mobile Number Field
                  CustomTextField(
                    hintText: 'Enter your mobile number',
                    controller: mobileController,
                  ),
                  SizedBox(height: 10),

                  /// Password Field
                  CustomTextField(
                    hintText: 'Enter your password',
                    obscureText: true,
                    controller: passwordController,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen()));
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: AppColors.primaryBlue),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  /// Login Button
                  CustomButton(
                    text: "Next",
                    color: AppColors.primaryBlue,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavScreen()));
                    },
                    textcolor: AppColors.white,
                  ),
                  SizedBox(height: 20),

                  /// Sign Up Option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account?  ",
                        style: TextStyle(color: AppColors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()));
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationScreen()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
