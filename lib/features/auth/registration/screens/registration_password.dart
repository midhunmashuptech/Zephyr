import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';
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
  TextEditingController regOtpController = TextEditingController();
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
  void initState() {
    super.initState();
    loadRegOtp();
  }

  Future<void> loadRegOtp() async {
    final loadProvider = context.read<AuthProvider>();
    await loadProvider.sendRegOtp(context: context);
  }

  @override
  Widget build(BuildContext context) {
    authProvider = context.watch<AuthProvider>();
    return Scaffold(
      body: SafeArea(
          child: authProvider.isRegOtpSending
              ? Center(child: CircularProgressIndicator())
              : Center(
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
                            Text(
                              "We've sent an OTP to the given Mobile number",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            IntlPhoneField(
                              enabled: false,
                              initialValue: authProvider.phoneNumber,
                              decoration: InputDecoration(
                                labelText: 'Mobile Number',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                              initialCountryCode: authProvider.countryISOCode,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Pinput(
                                    enabled: !(authProvider.isRegOtpVerified),
                                    controller: regOtpController,
                                    length: 6,
                                    onChanged: (value) {
                                      debugPrint((value.length == 6).toString());
                                      authProvider.updateRegOtpfilledState(
                                          value.length == 6);
                                    },
                                    defaultPinTheme: PinTheme(
                                      width: MediaQuery.of(context).size.width *
                                              0.12 -
                                          2,
                                      height: 56,
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          color: authProvider.isRegOtpVerified
                                              ? AppColors.grey
                                              : AppColors.primaryBlue,
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
                            SizedBox(
                              height: 15,
                            ),
                            authProvider.isRegOtpVerified
                                ? SizedBox.shrink()
                                : Column(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            authProvider.resendRegOtp(
                                                context: context);
                                          },
                                          child: Text(
                                            authProvider.canRegResendOtp
                                                ? "Resend OTP"
                                                : "Resend in 00:${authProvider.regresendSeconds.toString().padLeft(2, '0')}s",
                                            style: TextStyle(
                                                color:
                                                    authProvider.canRegResendOtp
                                                        ? AppColors.primaryBlue
                                                        : AppColors.grey),
                                          )),
                                      authProvider.isRegOtpVerifying
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : CustomButton(
                                              text: "Verify",
                                              onPressed: authProvider
                                                      .isRegOtpfilled
                                                  ? () async {
                                                      await authProvider
                                                          .verifyRegOtp(
                                                        context: context,
                                                        otp: regOtpController
                                                            .text,
                                                      );
                                                    }
                                                  : null,
                                              color: authProvider.isRegOtpfilled
                                                  ? AppColors.primaryBlue
                                                  : AppColors.grey,
                                              textcolor: AppColors.white,
                                            ),
                                    ],
                                  ),
                            SizedBox(
                              height: 15,
                            ),
                            !(authProvider.isRegOtpVerified)
                                ? SizedBox.shrink()
                                : Column(
                                    children: [
                                      ValueListenableBuilder(
                                        builder: (context, pvalue, _) {
                                          return CustomTextField(
                                            hintText: "Enter your Password",
                                            obscureText: pvalue,
                                            controller: gpwdController,
                                            prefixIcon:
                                                Icon(Icons.lock_rounded),
                                            validator: _validatePassword,
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                isPwdVisible.value =
                                                    !isPwdVisible.value;
                                              },
                                              icon: pvalue
                                                  ? const Icon(
                                                      Icons.visibility_off)
                                                  : const Icon(
                                                      Icons.visibility),
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
                                            prefixIcon:
                                                Icon(Icons.lock_rounded),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Confirm Password is required';
                                              } else if (value !=
                                                  gpwdController.text) {
                                                return 'Passwords do not match';
                                              }
                                              return null;
                                            },
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isCPwdVisible.value =
                                                      !isCPwdVisible.value;
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
                                                isChecked.value =
                                                    value ?? false;
                                              },
                                              focusColor: AppColors.black,
                                              activeColor:
                                                  AppColors.primaryGreen,
                                            );
                                          },
                                          valueListenable: isChecked,
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                            'I Agree to the Terms and Conditions'),
                                      ]),
                                      authProvider.isregistered
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : CustomButton(
                                              text: "Register",
                                              color: authProvider.isRegOtpfilled
                                                  ? AppColors.primaryBlue
                                                  : AppColors.grey,
                                              textcolor: AppColors.white,
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  if (isChecked.value == true) {
                                                    authProvider.setPassword(
                                                        gcpwdController.text);
                                                    authProvider.registerUser(
                                                        context: context);
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
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
                                            ),
                                    ],
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
