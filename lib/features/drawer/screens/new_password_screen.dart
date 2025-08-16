import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';
import 'package:zephyr/features/drawer/services/drawer_service.dart';
import 'package:zephyr/features/login/widgets/custom_textfeild.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();
  bool isChecked = false;
  bool isPwdVisible = false;
  bool isCPwdVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _cPasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (!RegExp(r"[A-Z]").hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r"[a-z]").hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    } else if (!RegExp(r"[0-9]").hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient for the screen
          SizedBox(
              height: MediaQuery.of(context).size.height,
              child: LayoutGradient(gradient: AppColors.greenGradient)),

          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Create a New',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextSpan(
                            text: '\nSecured Password',
                            style: TextStyle(
                              color: AppColors.primaryGreen,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Please enter your new password below. Your password must be at least 8 characters long.",
                      textAlign: TextAlign.center,
                    ),
                    Lottie.asset('assets/lottie/password_lottie.json',
                        height: 300, width: 300),
                    SizedBox(height: 30),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Enter your New Password",
                      maxLines: 1,
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isPwdVisible = !isPwdVisible;
                            });
                          },
                          icon: isPwdVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                      ),
                      obscureText: !isPwdVisible,
                      validator: _validatePassword,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: _cPasswordController,
                      hintText: "Re-Enter your New Password",
                      prefixIcon: Icon(Icons.lock),
                      maxLines: 1,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isCPwdVisible = !isCPwdVisible;
                            });
                          },
                          icon: isCPwdVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                      ),
                      obscureText: !isCPwdVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm Password is required';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                      text: "Reset Password",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DrawerService()
                              .resetPassword(context, _passwordController.text);
                        }
                      },
                      color: AppColors.primaryGreen,
                      textcolor: AppColors.white,
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
