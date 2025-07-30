import 'package:flutter/material.dart';
import 'package:zephyr/common/widgets/floating_card.dart';
import 'package:zephyr/constants/app_constants.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Positioned(
              right: 30,
              top: 15,
              child: Transform.rotate(
                angle: 0,
                child: FloatingCard(
                  imgIcon: "assets/icons/react_vector.png", 
                  color: AppColors.primaryBlue,
                  size: 50,
                ),
              ),
            ),
        
            Positioned(
              right: 45,
              bottom: 15,
              child: Transform.rotate(
                angle: -0.5,
                child: FloatingCard(
                  imgIcon: "assets/icons/book_vector.png", 
                  color: AppColors.primaryOrange,
                  size: 60,
                ),
              ),
            ),
        
            Positioned(
              left: 30,
              bottom: 10,
              child: Transform.rotate(
                angle: 0.1,
                child: FloatingCard(
                  imgIcon: "assets/icons/hat_vector.png", 
                  color: AppColors.primaryBlue,
                  size: 70,
                ),
              ),
            ),
        
            Positioned(
              left: 40,
              top: 10,
              child: Transform.rotate(
                angle: -0.5,
                child: FloatingCard(
                  imgIcon: "assets/icons/aplus_vector.png", 
                  color: AppColors.primaryOrange,
                  size: 50,
                ),
              ),
            ),

            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.65),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Image(image: AssetImage('assets/images/onboarding3.png')),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            ],
          ),
        ),
      ],
    );
  }
}