import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class RatingStarWidget extends StatefulWidget {
  final double rating;
  const RatingStarWidget({required this.rating, super.key});

  @override
  State<RatingStarWidget> createState() => _RatingStarWidgetState();
}

class _RatingStarWidgetState extends State<RatingStarWidget> {
  int fullStarCount = 0;
  int halfStarCount = 0;
  int emptyStarCount = 0;

  @override
  void initState() {
    calculateStarCounts();
    super.initState();
  }

  void calculateStarCounts() {
    setState(() {
      fullStarCount = widget.rating.toInt();
      double decimalPart = widget.rating - fullStarCount;
      halfStarCount = decimalPart >= 0.5 ? 1 : 0;
      emptyStarCount = 5 - halfStarCount - fullStarCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
            fullStarCount,
            (index) => Icon(
                  Icons.star,
                  color: AppColors.primaryOrange,
                  size: 15,
                )),
        ...List.generate(
            halfStarCount,
            (index) => Icon(
                  Icons.star_half,
                  color: AppColors.primaryOrange,
                  size: 15,
                )),
        ...List.generate(
            emptyStarCount,
            (index) => Icon(
                  Icons.star,
                  color: AppColors.grey,
                  size: 15,
                )),
      ],
    );
  }
}
