import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';
import 'package:zephyr/features/login/screens/forgot_password_screen.dart';

class Login extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;
  const Login(
      {required this.phoneNumber, required this.countryCode, super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool otpStatus = false;
  String _countryCode = '';
  String _phoneNumber = '';
  String _errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: LayoutGradient(gradient: AppColors.blueGradient),
            ),
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
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20),

                    IntlPhoneField(
                      enabled: false,
                      initialValue: widget.phoneNumber,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        errorText: _errorText.isNotEmpty ? _errorText : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _countryCode = value.countryCode;
                          _phoneNumber = value.number;
                          _errorText = '';
                        });
                      },
                      initialCountryCode: widget.countryCode,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: _errorText.isNotEmpty ? _errorText : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPasswordScreen(
                                          phoneNumber: widget.phoneNumber,
                                          countryCode: widget.countryCode,
                                        )));
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: AppColors.primaryBlue),
                          ),
                        )
                      ],
                    ),

                    /// Login Button
                    CustomButton(
                      text: "Login",
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
