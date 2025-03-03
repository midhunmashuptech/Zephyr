import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: AssetImage('assets/images/onboarding2.png')
              ),
            ),
          ],
    );
  }
}