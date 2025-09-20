import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/entypo.dart';
import 'package:zephyr/constants/app_constants.dart';

class CategoryWidget extends StatelessWidget {
  final String categoryName;
  final bool isSelected;
  const CategoryWidget(
      {super.key, required this.categoryName, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? AppColors.primaryGreen : AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28), // reduced from 35
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0), // reduced from 5.0
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 15, // reduced from 18
              backgroundColor:
                  isSelected ? AppColors.white : AppColors.primaryGreen,
              child: Iconify(
                Entypo.open_book,
                color: isSelected ? AppColors.primaryGreen : AppColors.white,
                size: 18, // set icon size smaller
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 6.0), // reduced from 8.0
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13, // reduced font size
                  color: isSelected ? AppColors.white : AppColors.black,
                ),
              ),
            ),
            SizedBox(width: 6) // reduced from 10
          ],
        ),
      ),
    );
  }
}
