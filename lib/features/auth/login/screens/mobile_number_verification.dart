import 'package:zephyr/features/auth/login/screens/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';

import 'package:zephyr/features/auth/provider/auth_provider.dart';
import 'package:zephyr/features/auth/registration/screens/registration_screen.dart';

class MobileNumberVerification extends StatefulWidget {
  const MobileNumberVerification({super.key});

  @override
  State<MobileNumberVerification> createState() =>
      _MobileNumberVerificationState();
}

class _MobileNumberVerificationState extends State<MobileNumberVerification> {
  @override
  void initState() {
    super.initState();
    passwordController.addListener(_onPasswordChanged);
  }

  void _onPasswordChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    passwordController.removeListener(_onPasswordChanged);
    passwordController.dispose();
    super.dispose();
  }

  // Helper to get current phone/country/iso for forgot password
  String get currentPhone => authProvider.phoneNumber;
  String get currentCountry => authProvider.countryCode;
  String get currentIso => authProvider.countryISOCode;
  AuthProvider authProvider = AuthProvider();
  final TextEditingController passwordController = TextEditingController();
  ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);
  bool showPasswordField = false;
  bool isLoading = false;
  String loginError = '';

  Future<void> checkMobileNumber() async {
    if (!authProvider.isValidNumber) return;
    setState(() {
      isLoading = true;
    });
    await authProvider.verifyPhoneNumber(
        context, authProvider.phoneNumber, authProvider.countryCode);
    setState(() {
      isLoading = false;
    });
    if (authProvider.userExist == "true") {
      setState(() {
        showPasswordField = true;
      });
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

  Future<void> handleLogin() async {
    setState(() {
      isLoading = true;
      loginError = '';
    });
    await authProvider.userLogin(
      context,
      passwordController.text,
    );
    setState(() {
      isLoading = false;
    });
    if (authProvider.isPasswordEmpty) {
      setState(() {
        loginError = "Password is required";
      });
    }
    // If userLogin shows error via snackbar, we don't need to handle it here
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Image.asset("assets/logo/zephyr_logo_app.png")),
                  const SizedBox(height: 30),
                  Text(
                    showPasswordField
                        ? "Login to your account"
                        : "Verify Your Mobile Number",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 28),
                  IntlPhoneField(
                    enabled: !showPasswordField,
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
                    initialValue: authProvider.phoneNumber,
                    onChanged: showPasswordField
                        ? null
                        : (value) {
                            context
                                .read<AuthProvider>()
                                .updatePhoneNumber(value);
                          },
                  ),
                  if (showPasswordField) ...[
                    const SizedBox(height: 28),
                    ValueListenableBuilder(
                      valueListenable: isPasswordVisible,
                      builder: (context, value, _) {
                        return TextFormField(
                          controller: passwordController,
                          obscureText: !value,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            errorText:
                                loginError.isNotEmpty ? loginError : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                value ? Icons.visibility : Icons.visibility_off,
                                color:
                                    value ? AppColors.primaryBlue : Colors.grey,
                              ),
                              onPressed: () {
                                isPasswordVisible.value =
                                    !isPasswordVisible.value;
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen(
                                  phoneNumber: currentPhone,
                                  countryCode: currentCountry,
                                  isoCode: currentIso,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: AppColors.primaryBlue),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 28),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: showPasswordField ? "Login" : "Verify",
                          color: (showPasswordField
                                  ? passwordController.text.isNotEmpty
                                  : authProvider.isValidNumber)
                              ? AppColors.primaryBlue
                              : Colors.grey,
                          textcolor: AppColors.white,
                          onPressed: showPasswordField
                              ? (passwordController.text.isNotEmpty
                                  ? () async {
                                      await handleLogin();
                                    }
                                  : null)
                              : (authProvider.isValidNumber
                                  ? () => checkMobileNumber()
                                  : null),
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
