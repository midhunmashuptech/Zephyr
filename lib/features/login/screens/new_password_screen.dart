import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient for the screen
          LayoutGradient(gradient: AppColors.greenGradient),

          SingleChildScrollView(
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Create a  ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        TextSpan(
                          text: 'Secured Password',
                          style: TextStyle(
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                      "Please enter your new password below. Your password must be at least 8 characters long.", textAlign: TextAlign.center,),
                  Lottie.asset('assets/lottie/password_lottie.json',
                      height: 300, width: 300),
                  SizedBox(height: 30),
                  
                  SizedBox(height: 10),
                  
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}
