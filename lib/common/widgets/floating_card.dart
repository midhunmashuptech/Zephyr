import 'package:flutter/material.dart';

class FloatingCard extends StatelessWidget {
  const FloatingCard({super.key, required this.imgIcon, required this.color, required this.size});
  final String imgIcon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(imgIcon),
        ),
      ),
    );
  }
}
