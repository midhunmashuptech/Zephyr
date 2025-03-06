import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:zephyr/constants/app_constants.dart';

class ContentCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const ContentCard({super.key, required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.5 - 40,
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
    );
  }
}
