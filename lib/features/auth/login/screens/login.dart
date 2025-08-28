import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';
import 'package:zephyr/features/auth/login/screens/forgot_password_screen.dart';
import 'package:zephyr/features/auth/provider/auth_provider.dart';
import 'package:zephyr/features/auth/service/login_service.dart';

class Login extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;
  final String isoCode;
  const Login(
      {required this.phoneNumber,
      required this.countryCode,
      required this.isoCode,
      super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthProvider authProvider = AuthProvider();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool otpStatus = false;
  String _countryCode = '';
  String _phoneNumber = '';
  String _errorText = '';

  @override
  void initState() {
    _countryCode = widget.countryCode;
    _phoneNumber = widget.phoneNumber;
    super.initState();
  }

  // Future<void> loginUser() async {
  //   await LoginService().login(context,
  //       countryCode: _countryCode,
  //       phone: _phoneNumber,
  //       password: passwordController.text);
  // }

  @override
  Widget build(BuildContext context) {
    authProvider = context.read<AuthProvider>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset('assets/lottie/login.json',
                      height: 300, width: 300),
                ),
                Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Log in to continue your personalized learning experience.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
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
                  initialCountryCode: widget.isoCode,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: passwordController,
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
                  onPressed: () async {
                    // loginUser();
                    await authProvider.userLogin(context, _phoneNumber, _countryCode,
                        passwordController.text);
                  },
                  textcolor: AppColors.white,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
