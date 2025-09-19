import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:zephyr/constants/app_constants.dart';

class TestDetailWidget extends StatelessWidget {
  final String label;
  final String value;
  final String icon;
  final Color color;
  final double size;
  const TestDetailWidget(
      {super.key,
      required this.label,
      required this.value,
      required this.icon,
      required this.color,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        // height: MediaQuery.of(context).size.width * .3,
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Positioned(
              right: -10,
              bottom: -15,
              child: Transform.rotate(
                angle: -20 * 3.14 / 180,
                child: Iconify(
                  icon,
                  size: 80,
                  color: color.withAlpha(250),
                ),
              ),
            ),
            // Positioned(
            //   right: -55,
            //   bottom: -35,
            //   child: Transform.rotate(
            //       angle: -30 * 3.14 / 180,
            //       child: HugeIcon(
            //         icon: Icons.stars_rounded,
            //         color: AppColors.primaryBlue.withAlpha(20),
            //         size: MediaQuery.of(context).size.width * .3,
            //       )),
            // ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w600,
                        fontSize: 28),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
