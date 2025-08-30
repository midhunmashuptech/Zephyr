// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:zephyr/common/functions/common_functions.dart';
// import 'package:zephyr/common/widgets/custom_button.dart';
// import 'package:zephyr/constants/app_constants.dart';
// import 'package:zephyr/features/auth/login/screens/login.dart';
// import 'package:zephyr/features/auth/provider/auth_provider.dart';
// import 'package:zephyr/features/auth/registration/screens/registration_screen.dart';

// class MobileNumberVerification extends StatefulWidget {
//   const MobileNumberVerification({super.key});

//   @override
//   State<MobileNumberVerification> createState() =>
//       _MobileNumberVerificationState();
// }

// class _MobileNumberVerificationState extends State<MobileNumberVerification> {
//   AuthProvider authProvider = AuthProvider();

//   bool otpStatus = false;
//   String _countryISOCode = 'IN';
//   String _countryCode = '';
//   String _phoneNumber = '';
//   String _errorText = '';

//   Future<void> checkMobileNumber() async {
//     await authProvider.verifyPhoneNumber(context, _phoneNumber, _countryCode);

//     if (authProvider.userExist == "true") {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Login(
//               phoneNumber: _phoneNumber,
//               countryCode: _countryCode,
//               isoCode: _countryISOCode),
//         ),
//       );
//     } else if (authProvider.userExist == "false") {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => RegistrationScreen(
//               phoneNumber: _phoneNumber,
//               countryCode: _countryCode,
//               isoCode: _countryISOCode),
//         ),
//       );
//     } else {
//       showSnackBar("Error", "Something went wrong. Please try again");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     authProvider = context.watch<AuthProvider>();
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Lottie.asset(
//                     'assets/lottie/login.json',
//                     width: MediaQuery.of(context).size.width * 0.7,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       "Verify Your Mobile Number",
//                       style:
//                           TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   // Mobile number field
//                   IntlPhoneField(
//                     enabled: !otpStatus,
//                     decoration: InputDecoration(
//                       labelText: 'Mobile Number',
//                       errorText: _errorText.isNotEmpty ? _errorText : null,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: const BorderSide(),
//                       ),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         _countryISOCode = value.countryISOCode;
//                         _countryCode = value.countryCode;
//                         _phoneNumber = value.number;
//                         _errorText = '';
//                       });
//                     },
//                     initialCountryCode: 'IN',
//                   ),
//                   const SizedBox(height: 10),
//                   authProvider.isVerifyingPhone
//                       ? Center(child: CircularProgressIndicator())
//                       : CustomButton(
//                           text: "Verify",
//                           color: AppColors.primaryBlue,
//                           textcolor: AppColors.white,
//                           onPressed: () {
//                             checkMobileNumber();
//                             // Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //     builder: (context) => Login(
//                             //         phoneNumber: _phoneNumber,
//                             //         countryCode: _countryCode,
//                             //         isoCode: _countryISOCode),
//                             //   ),
//                             // );
//                           },
//                         ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
  // ✅ to track number validation

  Future<void> checkMobileNumber() async {
    authProvider = context.watch<AuthProvider>();
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
