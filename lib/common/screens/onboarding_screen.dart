import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zephyr/common/widgets/onboarding_page1.dart';
import 'package:zephyr/common/widgets/onboarding_page2.dart';
import 'package:zephyr/common/widgets/onboarding_page3.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  var _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: LayoutGradient(
              key: ValueKey<int>(_currentPage),
              gradient: _currentPage == 0
                  ? AppColors.blueGradient
                  : _currentPage == 1
                      ? AppColors.orangeGradient
                      : AppColors.greenGradient,
            ),
          ),
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 470,
                child: PageView(
                  controller: _controller,
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  children: [
                    OnboardingPage1(),
                    OnboardingPage2(),
                    OnboardingPage3()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Card(
                  color: AppColors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 35),
                    child: Column(
                      children: [
                        Text(
                          "Education is the best learn ever",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15),
                        SmoothPageIndicator(
                          controller: _controller,
                          count: 3,
                          effect: ExpandingDotsEffect(
                            activeDotColor: AppColors.primaryBlue,
                            dotColor: AppColors.grey,
                            dotHeight: 10,
                            dotWidth: 10,
                            spacing: 5,
                          ),
                        ),
                        SizedBox(height: 15),
                        AnimatedSwitcher(
                            duration: Duration(seconds: 1),
                            child: _currentPage == 2
                                ? TextButton(
                                    style: TextButton.styleFrom(
                                        foregroundColor: AppColors.white,
                                        backgroundColor: AppColors.primaryBlue),
                                    onPressed: () {
                                      // Navigator.pushReplacement(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => const SplashScreen()
                                      // )
                                    },
                                    child: Text("Get Started"))
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Skip"),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                              foregroundColor: AppColors.white,
                                              backgroundColor:
                                                  AppColors.primaryBlue),
                                          onPressed: () {
                                            _controller.nextPage(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.easeInOut);
                                          },
                                          child: Text("Next"))
                                    ],
                                  ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
