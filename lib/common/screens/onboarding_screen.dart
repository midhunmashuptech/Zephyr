import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
// Removed old onboarding page imports
import 'package:zephyr/constants/app_constants.dart';
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
        return AppColors.orangeCourseActionGradient;
      case 4:
        return AppColors.greenCourseActionGradient;
      default:
        return AppColors.blueGradient;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: LayoutGradient(
              key: ValueKey<int>(_currentPage),
              gradient: _getGradientForPage(_currentPage),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 50),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: onboardingPages.length,
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Image.asset(
                          'assets/onboarding/onboarding${index + 1}.png',
                          height: 300,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 30),
                        Text(
                          onboardingPages[index]['title']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            onboardingPages[index]['caption']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
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
                          SizedBox(height: 15),
                          AnimatedSwitcher(
                            duration: Duration(seconds: 1),
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
                                      GestureDetector(
                                        child: TextButton(
                                          child: Text("Skip"),
                                          onPressed: () {
                                            _controller.jumpToPage(
                                                onboardingPages.length - 1);
                                          },
                                        ),
                                      ),
                                      CustomButton(
                                        text: "Next",
                                        onPressed: () {
                                          _controller.nextPage(
                                              duration:
                                                  Duration(milliseconds: 300),
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
