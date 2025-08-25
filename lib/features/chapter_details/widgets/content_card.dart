import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zephyr/constants/app_constants.dart';

class ContentCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Function() onPressed;
  const ContentCard(
      {super.key,
      required this.icon,
      required this.label,
      required this.color,
      required this.onPressed
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.width * 0.5 - 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HugeIcon(
              icon: icon,
              size: MediaQuery.of(context).size.width * 0.15,
              color: AppColors.white,
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: AppColors.white),
            )
          ],
        ),
      ),
    );
  }
}
