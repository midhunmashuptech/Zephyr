import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class GradeCard extends StatefulWidget {
  const GradeCard({super.key});

  @override
  State<GradeCard> createState() => _GradeCardState();
}

class _GradeCardState extends State<GradeCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.primaryOrange
          ),
        ), 
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.primaryBlue
          ),
        ),
      ],
    );
  }
}