import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/auth/login/screens/forgot_password_screen.dart';
import 'package:zephyr/features/auth/provider/auth_provider.dart';

class Login extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;
  final String isoCode;
  const Login({
    required this.phoneNumber,
    required this.countryCode,
    required this.isoCode,
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthProvider authProvider = AuthProvider();

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    // Listener for password field
    passwordController.addListener(() {
      updatePasswordStatus();
    });
  }

  void updatePasswordStatus() {
    final providerAuth = context.read<AuthProvider>();
    providerAuth.updatePasswordStatus(
      passwordController.text.trim().isEmpty,
      passwordController.text,
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = context.watch<AuthProvider>();
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
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        AssetImage('assets/logo/zephyr_digital_logo.png'),
                  ),
                ),
                const Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Log in to continue your personalized learning experience.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                /// Phone field
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

                const SizedBox(height: 15),

                ValueListenableBuilder(
                  builder: (context, value, _) {
                    return TextFormField(
                      controller: passwordController,
                      obscureText: !value,
                      readOnly: authProvider.isLogining,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: authProvider.isPasswordEmpty
                            ? "Password is required"
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            value ? Icons.visibility : Icons.visibility_off,
                            color: value ? AppColors.primaryBlue : Colors.grey,
                          ),
                          onPressed: () {
                            isPasswordVisible.value = !isPasswordVisible.value;
                          },
                        ),
                      ),
                    );
                  },
                  valueListenable: isPasswordVisible,
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
                              isoCode: widget.isoCode,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: AppColors.primaryBlue),
                      ),
                    )
                  ],
                ),

                /// Login Button
                authProvider.isLogining
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        text: "Login",
                        color: authProvider.isPasswordEmpty
                            ? Colors.grey // Disabled color
                            : AppColors.primaryBlue,
                        onPressed: authProvider.password == ""
                            ? null // Disable button if password empty
                            : () async {
                                await authProvider.userLogin(
                                  context,
                                  passwordController.text,
                                );
                              },
                        textcolor: AppColors.white,
                      ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
