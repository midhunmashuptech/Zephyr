import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class RatingWidget extends StatelessWidget {
  final String number;
  final double value;
  const RatingWidget({super.key, required this.number, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 7),
        Text(number),
        SizedBox(width: 7),
        const Icon(
          Icons.star,
          color: AppColors.primaryOrange,
          size: 15,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: LinearProgressIndicator(
            borderRadius: BorderRadius.circular(10),
            value: value,
            backgroundColor: AppColors.grey,
            color: AppColors.primaryGreen,
            minHeight: 7,
          ),
        )
      ],
    );
  }
}
