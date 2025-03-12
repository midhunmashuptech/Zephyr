import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF5F61F0);
  static const Color primaryGreen = Color(0xFF68BD00);
  static const Color primaryOrange = Color(0xFFF5A101);
  static const Color primaryRed = Color(0xFFFF0000);

  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color grey = Color.fromARGB(255, 198, 198, 198);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color dropdownblue = Color.fromRGBO(195, 227, 249, 1);
  static const Color ratingYellow = Color.fromARGB(255, 255, 242, 0);
  static const Color ratingGrey = Color.fromARGB(255, 78, 77, 77);
  static const Color darkred = Color(0xFFC00000);

  static const Color lightBlue = Color(0xFFDEE9FF);
  static const Color lightGreen = Color(0xFFE5FFD8);
  static const Color lightOrange = Color.fromARGB(255, 253, 248, 227);
  static const Color lightRed = Color.fromARGB(255, 255, 231, 231);
  static const Color lightGrey = Color(0xFFEEEEEE);

  static const Gradient blueGradient = LinearGradient(
    colors: [
      lightBlue,
      Color(0xFFFFFFFF),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient greenGradient = LinearGradient(
    colors: [
      lightGreen,
      Color(0xFFFFFFFF),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient orangeGradient = LinearGradient(
    colors: [
      lightOrange,
      Color(0xFFFFFFFF),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient redGradient = LinearGradient(
    colors: [
      lightRed,
      Color(0xFFFFFFFF),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
