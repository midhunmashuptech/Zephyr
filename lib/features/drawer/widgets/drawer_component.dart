import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class DrawerComponent extends StatelessWidget {
  final String item;
  final IconData icon;
  final Color color;
  const DrawerComponent({super.key, required this.item, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        SizedBox(
          width: 10,
        ),
        Text(item)
      ],
    );
  }
}
