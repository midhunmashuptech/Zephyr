import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/auth/login/screens/login.dart';
import 'package:zephyr/features/auth/provider/auth_provider.dart';
import 'package:zephyr/features/auth/registration/screens/registration_screen.dart';

class MobileNumberVerification extends StatefulWidget {
  const MobileNumberVerification({super.key});

  @override
  State<MobileNumberVerification> createState() =>
      _MobileNumberVerificationState();
}

class _MobileNumberVerificationState extends State<MobileNumberVerification> {
  AuthProvider authProvider = AuthProvider();

  Future<void> checkMobileNumber() async {
    if (!authProvider.isValidNumber) return; // prevent call if invalid

    await authProvider.verifyPhoneNumber(
        context, authProvider.phoneNumber, authProvider.countryCode);

    if (authProvider.userExist == "true") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(
              phoneNumber: authProvider.phoneNumber,
              countryCode: authProvider.countryCode,
              isoCode: authProvider.countryISOCode),
        ),
      );
    } else if (authProvider.userExist == "false") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegistrationScreen(
              phoneNumber: authProvider.phoneNumber,
              countryCode: authProvider.countryCode,
              isoCode: authProvider.countryISOCode),
        ),
      );
    } else {
      showSnackBar("Error", "Something went wrong. Please try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    authProvider = context.watch<AuthProvider>();

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
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Mobile number field
                  IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      errorText: authProvider.errorText.isNotEmpty
                          ? authProvider.errorText
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (value) {
                      context.read<AuthProvider>().updatePhoneNumber(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  authProvider.isVerifyingPhone
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: "Verify",
                          color: authProvider.isValidNumber
                              ? AppColors.primaryBlue
                              : Colors.grey,
                          textcolor: AppColors.white,
                          onPressed: authProvider.isValidNumber
                              ? () {
                                  checkMobileNumber();
                                }
                              : null,
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
