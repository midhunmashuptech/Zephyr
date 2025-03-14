import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class QuizSummaryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  QuizSummaryItem(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryBlue),
              SizedBox(width: 10),
              Text(label, style: TextStyle(fontSize: 16)),
            ],
          ),
          Text(value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}