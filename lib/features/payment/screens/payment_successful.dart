import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zephyr/constants/app_constants.dart';

class PaymentSuccessful extends StatelessWidget {
  const PaymentSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottie/payment_success.json",
              width: MediaQuery.of(context).size.width *.7
              ),
              Text("Payment Successful",
              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22))
            ],
          ),
        )
      ),
    );
  }
}
