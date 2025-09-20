import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/common/widgets/floating_card.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';
import 'package:zephyr/features/auth/login/screens/mobile_number_verification.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  // floating card rotation index
  int _rotationIndex = 0;

  final positions = [
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.bottomRight,
    Alignment.bottomLeft,
  ];

  Alignment _getPosition(int cardIndex) {
    return positions[(cardIndex + _rotationIndex) % positions.length];
  }

  double _getSize(int cardIndex) {
    if (cardIndex == 0 || cardIndex == 2) {
      if (_currentPage == 0 || _currentPage == 2)
        return 70;
      else
        return 50;
    } else{
      if (_currentPage == 0 || _currentPage == 2)
        return 50;
      else
        return 70;
    }
  }

  final List<Map<String, String>> onboardingPages = [
    {
      'title': 'Learn Smarter. Dream Bigger.',
      'caption':
          'Step into Zephyr Digital – your companion for school, entrance, and scholarship success.',
    },
    {
      'title': 'Your Path, Your Pace.',
      'caption':
          'Adaptive lessons designed for classes 6–12, so every student learns in the way that suits them best.',
    },
    {
      'title': 'Learn from the Best.',
      'caption':
          'Experienced mentors and curated content to prepare you for competitive exams with confidence.',
    },
    {
      'title': 'Practice. Perfect. Progress.',
      'caption':
          'Mock tests, quizzes, and detailed analytics to track growth and boost performance.',
    },
    {
      'title': 'Unlock Opportunities.',
      'caption':
          'Prepare not just for exams, but for scholarships that shape your future.',
    },
  ];

  Gradient _getGradientForPage(int page) {
    switch (page) {
      case 0:
        return AppColors.blueGradient;
      case 1:
        return AppColors.orangeGradient;
      case 2:
        return AppColors.greenGradient;
      case 3:
        return AppColors.orangeGradient;
      case 4:
        return AppColors.blueGradient;
      default:
        return AppColors.orangeGradient;
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
      _rotationIndex = (_rotationIndex + 1) % positions.length; // clockwise
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background gradient
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: LayoutGradient(
              key: ValueKey<int>(_currentPage),
              gradient: _getGradientForPage(_currentPage),
            ),
          ),

          /// Floating cards
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 40.0, right: 40.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      alignment: _getPosition(0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                        child: FloatingCard(
                          imgIcon: "assets/icons/hat_vector.png",
                          color: AppColors.primaryBlue,
                          size: _getSize(0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      alignment: _getPosition(1),
                      child: FloatingCard(
                        imgIcon: "assets/icons/aplus_vector.png",
                        color: AppColors.primaryOrange,
                        size: _getSize(1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      alignment: _getPosition(2),
                      child: FloatingCard(
                        imgIcon: "assets/icons/react_vector.png",
                        color: AppColors.primaryBlue,
                        size: _getSize(2),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      alignment: _getPosition(3),
                      child: FloatingCard(
                        imgIcon: "assets/icons/book_vector.png",
                        color: AppColors.primaryOrange,
                        size: _getSize(3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Onboarding pages
          Column(
            children: [
              const SizedBox(height: 50),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: onboardingPages.length,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/onboarding/onboarding${index + 1}.png',
                          height: 400,
                          fit: BoxFit.contain,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),

          /// Bottom card
          Positioned(
            bottom: 40,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Card(
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 35),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          SmoothPageIndicator(
                            controller: _controller,
                            count: onboardingPages.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: AppColors.primaryBlue,
                              dotColor: AppColors.grey,
                              dotHeight: 10,
                              dotWidth: 10,
                              spacing: 5,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            onboardingPages[_currentPage]['title'] ?? "",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              onboardingPages[_currentPage]['caption'] ?? "",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 30),
                          AnimatedSwitcher(
                            duration: const Duration(seconds: 1),
                            child: _currentPage == onboardingPages.length - 1
                                ? CustomButton(
                                    text: "Get Started",
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MobileNumberVerification()));
                                    },
                                    color: AppColors.primaryBlue,
                                    textcolor: AppColors.white,
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        child: const Text("Skip"),
                                        onPressed: () {
                                          _controller.jumpToPage(
                                              onboardingPages.length - 1);
                                        },
                                      ),
                                      CustomButton(
                                        text: "Next",
                                        onPressed: () {
                                          _controller.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeInOut);
                                        },
                                        width: 150,
                                        color: AppColors.primaryBlue,
                                        textcolor: AppColors.white,
                                      )
                                    ],
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
