import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/drawer/models/timeline_activity_model.dart';

class TimelineItem extends StatelessWidget {
  final Activities item;
  final bool isFirst;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.item,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: const LineStyle(color: AppColors.grey, thickness: 2),
      afterLineStyle: const LineStyle(color: AppColors.grey, thickness: 2),
      indicatorStyle: IndicatorStyle(
        width: 20,
        color: AppColors.grey,
        indicatorXY: 0.5,
      ),
      endChild: Card(
          color: Colors.grey[100],
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (item.contentDetails ?? ContentDetails(title: "Content Title")).title ?? "Content Title",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: (item.timeline ?? Timeline()).contentType == "video" ? AppColors.primaryGreen : (item.timeline ?? Timeline()).contentType == "material" ? AppColors.primaryBlue : AppColors.primaryOrange),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (item.timeline ?? Timeline(contentType: "Content Type")).contentType ?? "Content Type",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        (item.timeline ?? Timeline(contentType: "Content Type")).accessedAt ?? "Content Type",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
          // ListTile(
          //   title: Text(
          //     item.title,
          //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: item.color),
          //   ),
          //   subtitle: Text(
          //     item.subtitle,
          //     style: const TextStyle(fontSize: 14, color: Colors.grey),
          //   ),
          //   trailing: Text(
          //     item.time,
          //     style: const TextStyle(fontSize: 14, color: Colors.grey),
          //   ),
          // ),
          ),
    );
  }
}
