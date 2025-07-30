import 'package:flutter/material.dart';

class LayoutGradient extends StatelessWidget {
  const LayoutGradient({super.key, required this.gradient});
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: gradient,
        ),
      ),
    );
  }
}
