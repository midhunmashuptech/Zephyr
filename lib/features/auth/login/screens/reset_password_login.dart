import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/auth/login/widgets/custom_textfeild.dart';
import 'package:zephyr/features/auth/provider/auth_provider.dart';

class ResetPasswordLogin extends StatefulWidget {
  const ResetPasswordLogin({super.key});

  @override
  State<ResetPasswordLogin> createState() => _ResetPasswordLoginState();
}

class _ResetPasswordLoginState extends State<ResetPasswordLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();
  ValueNotifier isChecked = ValueNotifier<bool>(false);
  ValueNotifier isPwdVisible = ValueNotifier<bool>(false);
  ValueNotifier isCPwdVisible = ValueNotifier<bool>(false);
  AuthProvider authProvider = AuthProvider();

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
    final authprovider = context.watch<AuthProvider>();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Please enter your new password below. Your password must be at least 8 characters long.",
                  textAlign: TextAlign.center,
                ),
                Lottie.asset('assets/lottie/reset_pwd.json',
                    height: 300, width: 300),
                SizedBox(height: 30),
                ValueListenableBuilder(
                    valueListenable: isPwdVisible,
                    builder: (context, pvalue, _) {
                      return CustomTextField(
                        controller: _passwordController,
                        hintText: "Enter your New Password",
                        maxLines: 1,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: IconButton(
                            onPressed: () {
                              isPwdVisible.value = !isPwdVisible.value;
                            },
                            icon: pvalue
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),
                        obscureText: !pvalue,
                        validator: _validatePassword,
                      );
                    }),
                SizedBox(height: 10),
                ValueListenableBuilder(
                    valueListenable: isCPwdVisible,
                    builder: (context, cvalue, _) {
                      return CustomTextField(
                        controller: _cPasswordController,
                        hintText: "Re-Enter your New Password",
                        prefixIcon: Icon(Icons.lock),
                        maxLines: 1,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: IconButton(
                            onPressed: () {
                              isCPwdVisible.value = !isCPwdVisible.value;
                            },
                            icon: cvalue
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),
                        obscureText: !cvalue,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password is required';
                          } else if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      );
                    }),
                SizedBox(height: 10),
                CustomButton(
                  text: "Reset Password",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      authprovider.resetPassword(
                          context: context, password: _passwordController.text);

                      // remove setstate and use value notifier for password visible
                      // make provider and call function in provider
                      // make efunctions in service and provider
                    }
                  },
                  color: AppColors.primaryBlue,
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
    );
  }
}
