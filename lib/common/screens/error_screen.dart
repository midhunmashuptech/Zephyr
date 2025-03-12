import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zephyr/constants/app_constants.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/lottie/error_lottie.json"),
            Text("Error", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.black, height: 1),),
            Text("404", style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600, color: AppColors.primaryBlue, height: 1),),
            Text("Oops Page Not Found!")
          ],
        ),
      ),
    );
  }
}