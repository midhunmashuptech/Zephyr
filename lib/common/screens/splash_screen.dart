import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/model/user.dart';
import 'package:zephyr/common/model/user_details_model.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'dart:async';

import 'package:zephyr/common/screens/onboarding_screen.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/auth/login/screens/mobile_number_verification.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // 2 sec fade-in effect
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    // checkLoginStatus();
    Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          );
        });
  }

  Future<void> checkLoginStatus() async {
    final loginedOnce = await _secureStorage.read(key: "loginedOnce");
    if (loginedOnce == "true") {
      // check for token existance
      final token = await _secureStorage.read(key: "token");
      if (token != null && token != "") {
        final response = await http.get(
          Uri.parse(getUserDetailsUrl),
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        );

        if (response.statusCode == 200) {
          final responseBody = response.body.isNotEmpty ? response.body : '{}';
          final responseJson = json.decode(responseBody);
          final userDetailsModel = UserDetailsModel.fromJson(responseJson);
          if (userDetailsModel.type == "success") {
            final userProvider = context.read<UserDetailsProvider>();
            userProvider.setUserDetails(userDetailsModel.user ?? User());
            // Bottom Nav
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingScreen()),
            );
          } else {
            // Mobile Num
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MobileNumberVerification()),
            );
          }
        } else if (response.statusCode == 401) {
          // Mobile Num
          showSnackBar("Token Expired", "Session expired! Please login again.");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          );
        }
      } else {
        // Onboarding Screen
        Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          );
        });
      }
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue, // Set background color to blue
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            'assets/logo/dummy_logo.png', // Replace with your logo path
            width: 200,
          ),
        ),
      ),
    );
  }
}
