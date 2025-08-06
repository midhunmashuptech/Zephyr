import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class RedeemCouponCard extends StatelessWidget {
  const RedeemCouponCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.lightBlue.withAlpha(50),
      ),
      child: DottedBorder(
        color: AppColors.grey,
        strokeWidth: 2,
        dashPattern: const [6, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Redeem Coupon",
                  style: TextStyle(color: AppColors.primaryBlue, fontSize: 16),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.add_circle_outline_rounded,
                  color: AppColors.primaryBlue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
