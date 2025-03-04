import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/common/widgets/phone_textfield.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';
import 'package:zephyr/features/login/screens/login.dart';
import 'package:zephyr/features/login/screens/new_password_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var _otpStatus = false;
  final String _otp = "123456";

  void otpSent() {
    setState(() {
      _otpStatus = true;
    });
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: AppColors.black,
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: AppColors.white,
      border: Border.all(color: AppColors.primaryGreen),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(25, 0, 0, 0),
          spreadRadius: 2,
          blurRadius: 3,
          offset: Offset(-2, 3),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LayoutGradient(gradient: AppColors.greenGradient),
          SingleChildScrollView(
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Trouble  ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        TextSpan(
                          text: 'Logging In?',
                          style: TextStyle(
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                      "Enter your Phone Number and we'll send you an OTP to reset your password.", textAlign: TextAlign.center),
                  Lottie.asset('assets/lottie/forget_password.json',
                      height: 300, width: 300),
                  SizedBox(height: 30),
                  PhoneTextfield(),
                  SizedBox(height: 10),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child:
                  _otpStatus
                      ? Column(
                          children: [
                            Text("Provide the OTP send to your mobile number"),
                            SizedBox(height: 10),
                            Pinput(
                              length: 6,
                              keyboardType: TextInputType.number,
                              defaultPinTheme: defaultPinTheme,
                              validator: (value) {
                                // print(value ?? "Nil");
                                return value == _otp ? null : "Invalid OTP";
                              },
                              onCompleted: (value) {
                                if (value == _otp) {
                                  //print("OTP Verified");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()));
                                }
                              },
                              errorBuilder: (errorText, pin) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      errorText ?? "",
                                      style: const TextStyle(
                                          color: AppColors.primaryBlue),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 15),
                            CustomButton(
                              text: "Verify OTP",
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const NewPasswordScreen()
                                  )
                                );
                              },
                              color: AppColors.primaryGreen,
                              textcolor: AppColors.white,
                            ),
                          ],
                        )
                      : CustomButton(
                          text: "Send OTP",
                          onPressed: otpSent,
                          color: AppColors.primaryGreen,
                          textcolor: AppColors.white,
                        ),
                  )
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}
