import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/auth/login/widgets/custom_textfeild.dart';
import 'package:zephyr/features/auth/provider/auth_provider.dart';

class RegistrationPassword extends StatefulWidget {
  const RegistrationPassword({super.key});

  @override
  State<RegistrationPassword> createState() => _RegistrationPasswordState();
}

class _RegistrationPasswordState extends State<RegistrationPassword> {
  AuthProvider authProvider = AuthProvider();
  // bool isChecked = false;
  final TextEditingController gpwdController = TextEditingController();
  final TextEditingController gcpwdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ValueNotifier isPwdVisible = ValueNotifier<bool>(true);
  ValueNotifier isCPwdVisible = ValueNotifier<bool>(true);
  ValueNotifier isChecked = ValueNotifier<bool>(false);

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
    authProvider = context.watch<AuthProvider>();
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
                  ValueListenableBuilder(
                    builder: (context, pvalue, _) {
                      return CustomTextField(
                        hintText: "Enter your Password",
                        obscureText: pvalue,
                        controller: gpwdController,
                        prefixIcon: Icon(Icons.lock_rounded),
                        validator: _validatePassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            isPwdVisible.value = !isPwdVisible.value;
                          },
                          icon: pvalue
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                      );
                    },
                    valueListenable: isPwdVisible,
                  ),
                  SizedBox(height: 5),
                  ValueListenableBuilder(
                    builder: (context, cvalue, _) {
                      return CustomTextField(
                        hintText: "Confirm your Password",
                        obscureText: cvalue,
                        controller: gcpwdController,
                        prefixIcon: Icon(Icons.lock_rounded),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password is required';
                          } else if (value != gpwdController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isCPwdVisible.value = !isCPwdVisible.value;
                            });
                          },
                          icon: cvalue
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      );
                    },
                    valueListenable: isCPwdVisible,
                  ),
                  Row(children: [
                    ValueListenableBuilder(
                      builder: (context, checkvalue, _) {
                        return Checkbox(
                          value: checkvalue,
                          onChanged: (bool? value) {
                            isChecked.value = value ?? false;
                          },
                          focusColor: AppColors.black,
                          activeColor: AppColors.primaryGreen,
                        );
                      },
                      valueListenable: isChecked,
                    ),
                    const SizedBox(height: 16),
                    const Text('I Agree to the Terms and Conditions'),
                  ]),
                  authProvider.isregistered 
                  ? Center(child: CircularProgressIndicator())
                  : CustomButton(
                    text: "Register",
                    color: AppColors.primaryGreen,
                    textcolor: AppColors.white,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (isChecked.value == true) {
                          authProvider.setPassword(gcpwdController.text);
                          authProvider.registerUser(context: context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Please agree to the terms and conditions")),
                          );
                        }
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => BottomNavScreen()));
                      }
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
