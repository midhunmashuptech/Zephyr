import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class FeatureRowWidget extends StatelessWidget {
  final String feature;
  final Color color;
  final IconData icon;
  const FeatureRowWidget(
      {super.key,
      required this.feature,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: color),
        SizedBox(width: 4),
        Text(
          feature,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
