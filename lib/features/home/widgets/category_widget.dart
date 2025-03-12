import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/entypo.dart';
import 'package:zephyr/constants/app_constants.dart';

class CategoryWidget extends StatelessWidget {
  final String categoryName;
  const CategoryWidget({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3 - 2,
      child: Card(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryGreen,
                child: Iconify(Entypo.open_book, color: AppColors.white),
              ),
              Expanded(
                child: Text(
                  categoryName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: 10)
            ],
          ),
        ),
      ),
    );
  }
}
