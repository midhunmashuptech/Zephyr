import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Image(image: AssetImage('assets/images/onboarding1.png')),
        ),
      ],
    );
  }
}
