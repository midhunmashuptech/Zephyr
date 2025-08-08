import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zephyr/constants/app_constants.dart';

class PaymentSuccessful extends StatefulWidget {
  const PaymentSuccessful({super.key});

  @override
  State<PaymentSuccessful> createState() => _PaymentSuccessfulState();
}

class _PaymentSuccessfulState extends State<PaymentSuccessful> {
  @override
  void initState() {
    navigateBack();
    super.initState();
  }

  Future<void> navigateBack() async {
    await Future.delayed(Duration(seconds: 3));
   if (mounted && Navigator.canPop(context)) {
    Navigator.pop(context);
  }
  }

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
            Lottie.asset(
              "assets/lottie/payment_success.json",
                width: MediaQuery.of(context).size.width * .7, 
                repeat: false),
            Text(
              "Payment Successful",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22))
          ],
        ),
      )),
    );
  }
}
