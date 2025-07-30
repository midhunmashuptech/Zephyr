import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';
import 'package:zephyr/features/login/screens/login.dart';
import 'package:zephyr/features/registration/screens/registration_screen.dart';

class MobileNumberVerification extends StatefulWidget {
  const MobileNumberVerification({super.key});

  @override
  State<MobileNumberVerification> createState() =>
      _MobileNumberVerificationState();
}

class _MobileNumberVerificationState extends State<MobileNumberVerification> {
  bool otpStatus = false;
  String _countryCode = '';
  String _phoneNumber = '';
  String _errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                child: LayoutGradient(gradient: AppColors.blueGradient)),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Lottie.asset('assets/lottie/login.json',
                        height: 300, width: 300),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Mobile Number Verification",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  //mobile number feild
                  IntlPhoneField(
                    enabled: !otpStatus,
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
                        _countryCode = value.countryISOCode;
                        _phoneNumber = value.number;
                        _errorText = '';
                      });
                    },
                    initialCountryCode: 'IN',
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "Verify",
                    color: AppColors.primaryBlue,
                    textcolor: AppColors.white,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login(phoneNumber: _phoneNumber, countryCode: _countryCode)));
                    },
                  ),
                  SizedBox(height: 20,),
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
                                    builder: (context) =>
                                        RegistrationScreen()));
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
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
