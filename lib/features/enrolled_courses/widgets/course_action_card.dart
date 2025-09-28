import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zephyr/constants/app_constants.dart';

class CourseActionCard extends StatefulWidget {
  final String title;
  final Gradient bgcolor;
  final Color iconColor;
  final IconData icon;
  final Function() onPressed;

  const CourseActionCard(
      {required this.icon,
      required this.iconColor,
      required this.title,
      required this.bgcolor,
      required this.onPressed,
      super.key});

  @override
  State<CourseActionCard> createState() => _CourseActionCardState();
}

class _CourseActionCardState extends State<CourseActionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: MediaQuery.of(context).size.width * .3,
        // width: MediaQuery.of(context).size.width * .7,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            gradient: widget.bgcolor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: AppColors.grey, blurRadius: 7, spreadRadius: 3)
            ],
            border: Border.all(
                color: AppColors.white,
                width: 3,
                strokeAlign: BorderSide.strokeAlignOutside)),
        child: Stack(
          children: [
            Positioned(
              right: -55,
              bottom: -35,
              child: Transform.rotate(
                  angle: -30 * 3.14 / 180,
                  child: HugeIcon(
                    icon: widget.icon,
                    color: widget.iconColor,
                    size: MediaQuery.of(context).size.width * .3,
                  )),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 22),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
