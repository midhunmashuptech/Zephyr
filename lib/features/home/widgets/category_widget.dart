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
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryGreen : AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: AppColors.primaryGreen.withOpacity(0.18),
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          else
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
        ],
        border: Border.all(
          color: isSelected
              ? AppColors.primaryGreen
              : AppColors.primaryGreen.withOpacity(0.18),
          width: 1.2,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        splashColor: AppColors.primaryGreen.withOpacity(0.1),
        onTap: null, // tap handled by parent
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.white
                      : AppColors.primaryGreen.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Iconify(
                    Entypo.open_book,
                    color: isSelected
                        ? AppColors.primaryGreen
                        : AppColors.primaryGreen,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Text(
                categoryName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.white : AppColors.black,
                  fontSize: 12.5,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
