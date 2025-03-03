import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: AssetImage('assets/images/onboarding3.png')
              ),
            ),
          ],
    );
  }
}