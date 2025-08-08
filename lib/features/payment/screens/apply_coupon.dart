import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/common/widgets/custom_search_bar.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/payment/widgets/coupon_card_widget.dart';

class ApplyCoupon extends StatefulWidget {
  const ApplyCoupon({super.key});

  @override
  State<ApplyCoupon> createState() => _ApplyCouponState();
}

class Coupons {
  final String couponText;
  final String couponCode;
  Coupons({required this.couponText, required this.couponCode});
}

class _ApplyCouponState extends State<ApplyCoupon> {
  TextEditingController searchController = TextEditingController();
  List<Coupons> coupons = [
    Coupons(couponText: "Flat 149/- OFF", couponCode: "#FLAT50OF"),
    Coupons(couponText: "Flat 299/- OFF", couponCode: "#FLAT299OF"),
    Coupons(couponText: "Flat 99/- OFF", couponCode: "#FLAT99OF"),
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 13),
        child: Column(
          children: [
            Row(
              children: [
                BackButton(),
                SizedBox(width: 10),
                Text(
                  'Profile Page',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Got a Coupon?",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                          "Use your code here and save on your learning journey!",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
                Lottie.asset("assets/lottie/coupon.json",
                    width: MediaQuery.of(context).size.width * .3)
              ],
            ),
            SizedBox(height: 50),
            CustomSearchBar(color: AppColors.primaryBlue, 
                        onChanged: (value) {
                          setState(() {
                            searchController.text = value ?? "";
                          });
                        },),
            SizedBox(height: 15),
            Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.all(8),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: coupons.length,
                  itemBuilder: (context, index) => CouponCard(
                        couponText: coupons[index].couponText,
                        couponCode: coupons[index].couponCode,
                        radioValue: index.toString(),
                        radioGroupValue: selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                        onTap: () {
                          setState(() {
                            selectedValue = index.toString();
                          });
                        },
                      )),
            ),
            // SizedBox(height: 15),
            CustomButton(
              text: "Apply Coupon",
              color: AppColors.primaryBlue,
              onPressed: selectedValue == null
                  ? null
                  : () {
                      Navigator.pop(context, coupons[int.parse(selectedValue ?? "")].couponText);
                    },
              textcolor: AppColors.white,
            )
          ],
        ),
      )),
    );
  }
}
