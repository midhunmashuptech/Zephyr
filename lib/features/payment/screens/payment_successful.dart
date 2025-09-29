import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/payment/provider/payment_provider.dart';

class PaymentSuccessful extends StatefulWidget {
  const PaymentSuccessful({super.key});

  @override
  State<PaymentSuccessful> createState() => _PaymentSuccessfulState();
}

class _PaymentSuccessfulState extends State<PaymentSuccessful> {
  PaymentProvider paymentProvider = PaymentProvider();
  @override
  void initState() {
    navigateBack();
    super.initState();
  }

  Future<void> navigateBack() async {
    await Future.delayed(Duration(seconds: 3)).then((_) => Get.offAll(BottomNavScreen()));
  }

  @override
  Widget build(BuildContext context) {
    paymentProvider = context.watch<PaymentProvider>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: (paymentProvider.razorpayModel.isActive ?? false)
              ? Center(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/lottie/payment_success.json",
                        width: MediaQuery.of(context).size.width * .7,
                        repeat: false),
                    Text("Payment Successful",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 22))
                  ],
                ))

                // Center(
                //   child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Lottie.asset("assets/lottie/payment_failed.json",
                //         width: MediaQuery.of(context).size.width * .7,
                //         repeat: false),
                //     Text("Payment Unsuccessful",
                //         style: TextStyle(
                //             fontWeight: FontWeight.w600, fontSize: 22))
                //   ],
                // ))

              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/lottie/plane.json",
                          width: MediaQuery.of(context).size.width * .7,
                          repeat: false),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        child: Text(
                            "Currently not accepting any course enrollment at the moment. Please Try agin Later or We will notify you once it become ready!",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                      )
                    ],
                  ),
                )),
    );
  }
}
