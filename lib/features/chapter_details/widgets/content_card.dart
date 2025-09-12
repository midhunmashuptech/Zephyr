import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color.withAlpha(20),
          ),
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.width * 0.5 - 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HugeIcon(
                  icon: icon,
                  size: MediaQuery.of(context).size.width * 0.1,
                  color: color,
                ),
                SizedBox(height: 10),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.w500,
                      color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
