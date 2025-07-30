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
  const Login({
    required this.phoneNumber,
    required this.countryCode,
    super.key});

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
            SizedBox(
                height: MediaQuery.of(context).size.height,
                child: LayoutGradient(gradient: AppColors.blueGradient)),
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Pinput(
                            length: 6,
                            defaultPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: AppColors.primaryBlue,
                                  fontWeight: FontWeight.w600),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(234, 239, 243, 1)),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(25, 0, 0, 0),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(-2, 3),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 20),

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
                                    ForgotPasswordScreen(phoneNumber: _phoneNumber, countryCode: _countryCode,)));
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
