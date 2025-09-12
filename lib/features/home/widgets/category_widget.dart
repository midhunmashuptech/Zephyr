import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/entypo.dart';
import 'package:zephyr/constants/app_constants.dart';

class CategoryWidget extends StatelessWidget {
  final String categoryName;
  final bool isSelected;
  const CategoryWidget({super.key, required this.categoryName, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? AppColors.primaryGreen : AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: isSelected ? AppColors.white : AppColors.primaryGreen,
              child: Iconify(Entypo.open_book, color: isSelected ? AppColors.primaryGreen : AppColors.white),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, color: isSelected ? AppColors.white : AppColors.black),
              ),
            ),
            SizedBox(width: 10)
          ],
        ),
      ),
    );
  }
}
