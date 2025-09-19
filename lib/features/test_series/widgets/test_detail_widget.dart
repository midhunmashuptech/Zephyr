import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zephyr/constants/app_constants.dart';

class TestDetailWidget extends StatelessWidget {
  const TestDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: MediaQuery.of(context).size.width * .3,
        // width: MediaQuery.of(context).size.width * .7,
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withAlpha(50),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -55,
              top: -35,
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.08,
                backgroundColor: AppColors.primaryBlue,
                child: Transform.rotate(
                  angle: -20 * 3.14 / 180,
                  child: HugeIcon(
                        icon: Icons.star_rounded,
                        color: AppColors.white.withAlpha(50),
                        size: MediaQuery.of(context).size.width * 0.2,
                      ),
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
            Center(
              child: Column(
                children: [
                  Text(
                    "Score",
                    style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  Text(
                    "Score",
                    style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w500,
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
