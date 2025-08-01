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
  String _countryCode = 'IN';
  String _phoneNumber = '';
  String _errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/login.json',
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Verify Your Mobile Number",
                      style: TextStyle(
                          fontSize: 23, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Mobile number field
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
                  const SizedBox(height: 10),
                  CustomButton(
                    text: "Verify",
                    color: AppColors.primaryBlue,
                    textcolor: AppColors.white,
                    onPressed: () {
                      _phoneNumber == "9496370108"
                      ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(
                            phoneNumber: _phoneNumber,
                            countryCode: _countryCode,
                          ),
                        ),
                      )
                      : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(
                            phoneNumber: _phoneNumber,
                            countryCode: _countryCode,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
