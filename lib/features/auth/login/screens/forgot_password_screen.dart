import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/auth/provider/auth_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;
  final String isoCode;
  const ForgotPasswordScreen(
      {required this.phoneNumber,
      required this.countryCode,
      required this.isoCode,
      super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController otpController = TextEditingController();
  AuthProvider authProvider = AuthProvider();
  @override
  void initState() {
    super.initState();
    loadSentOtp();
  }

  Future<void> loadSentOtp() async {
    final loadProvider = context.read<AuthProvider>();
    await loadProvider.resetPasswordSendOtp(context: context);
    
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20, color: AppColors.black, fontWeight: FontWeight.w600),
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
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: authProvider.isOtpsend
          ? Center(child: CircularProgressIndicator())
          : authProvider.otpStatus != "invalid"
              ? SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/lottie/login.json',
                              height: 300, width: 300),
                          Text(
                            "Trouble Logging In?",
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "We’have sent you a verification code to the given number to login",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 20),
                          IntlPhoneField(
                            enabled: false,
                            initialValue: widget.phoneNumber,
                            decoration: InputDecoration(
                              labelText: 'Mobile Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(),
                              ),
                            ),
                            initialCountryCode: widget.isoCode,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Pinput(
                                  controller: otpController,
                                  length: 6,
                                  onChanged: (value) {
                                    authProvider.updateOtpfilledState(
                                        value.length == 6);
                                  },
                                  defaultPinTheme: PinTheme(
                                    width: MediaQuery.of(context).size.width *
                                            0.12 -
                                        2,
                                    height: 56,
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: AppColors.primaryBlue,
                                        fontWeight: FontWeight.w600),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      border: Border.all(
                                          color: const Color.fromRGBO(
                                              234, 239, 243, 1)),
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
                          SizedBox(height: 10),
                          TextButton(
                              onPressed: () {
                                authProvider.resetPasswordSendOtp(
                                    context: context);
                              },
                              child: Text("Resend OTP",
                                  style: TextStyle(
                                    color: AppColors.primaryBlue,
                                  ))),
                          authProvider.isOtpVerified
                              ? Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  text: "Next",
                                  color: authProvider.isOtpfilled
                                      ? AppColors.primaryBlue
                                      : AppColors.grey,
                                  onPressed: authProvider.isOtpfilled
                                      ? () async {
                                          await authProvider.verifyPasswordOtp(
                                            context: context,
                                            otp: otpController.text,
                                          );
                                        }
                                      : null, // disables the button
                                  textcolor: AppColors.white,
                                ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/lottie/error_lottie.json"),
                      Text(
                        "Error",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                            height: 1),
                      ),
                      Text(
                        "404",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryBlue,
                            height: 1),
                      ),
                      Text("Something Went Wrong!")
                    ],
                  ),
                ),
    );
  }
}
