import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class LiveClassCard extends StatelessWidget {
  final String className;
  final String tutorName;
  final String date;
  final String duration;
  final String imageUrl;
  final Color imageColor;

  const LiveClassCard({
    super.key,
    required this.className,
    required this.tutorName,
    required this.date,
    required this.duration,
    required this.imageUrl,
    required this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              color: imageColor,
              borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  className,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                   " $tutorName",
                  style: TextStyle(color: AppColors.black, fontSize: 15,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  " $date",
                  style: const TextStyle(fontSize: 14,color: AppColors.black,),
                ),
                Text(
                  " $duration",
                  style: const TextStyle(fontSize: 14,color: AppColors.black,),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(FluentIcons.live_20_filled,color: AppColors.primaryRed),
                    const SizedBox(width: 5),
                    const Text("Live class", style: TextStyle(color: AppColors.primaryRed, fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
