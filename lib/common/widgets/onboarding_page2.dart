import 'package:flutter/material.dart';
import 'package:zephyr/common/widgets/floating_card.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 20,
          top: 15,
          child: Transform.rotate(
            angle: 0,
            child: FloatingCard(
              imgIcon: "assets/icons/book_vector.png", 
              color: AppColors.primaryOrange,
              size: 50,
            ),
          ),
        ),

        Positioned(
          right: 25,
          bottom: 15,
          child: Transform.rotate(
            angle: -0.5,
            child: FloatingCard(
              imgIcon: "assets/icons/hat_vector.png", 
              color: AppColors.primaryBlue,
              size: 60,
            ),
          ),
        ),

        Positioned(
          left: 20,
          bottom: 10,
          child: Transform.rotate(
            angle: 0.1,
            child: FloatingCard(
              imgIcon: "assets/icons/aplus_vector.png", 
              color: AppColors.primaryOrange,
              size: 70,
            ),
          ),
        ),

        Positioned(
          left: 30,
          top: 10,
          child: Transform.rotate(
            angle: -0.5,
            child: FloatingCard(
              imgIcon: "assets/icons/react_vector.png", 
              color: AppColors.primaryBlue,
              size: 50,
            ),
          ),
        ),

        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image(
            image: AssetImage('assets/images/onboarding2.png')
          ),
        ),
      ],
    );
  }
}