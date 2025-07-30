import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;
  const ForgotPasswordScreen({
    required this.phoneNumber,
    required this.countryCode,
    super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var _otpStatus = false;
  final String _otp = "123456";
  String _countryCode = '';
  String _phoneNumber = '';
  String _errorText = '';

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
                      "Forgot Password",
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
                              width: MediaQuery.of(context).size.width * 0.12 - 2,
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
