import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF5F61F0);
  static const Color primaryGreen = Color(0xFF68BD00);
  static const Color primaryOrange = Color(0xFFF5A101);
  static const Color primaryRed = Color(0xFFFF0000);

  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color grey = Color.fromARGB(255, 198, 198, 198);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
<<<<<<< HEAD
  static const Color dropdownblue = Color.fromRGBO(227, 242, 253, 1);
=======
  static const Color rating_yellow = Color.fromARGB(255, 255, 242, 0);

>>>>>>> e4177c3da64d8f38a19556157aa7777fe1d806f6

  static const Color lightBlue = Color(0xFFDEE9FF);
  static const Color lightGreen = Color(0xFFE5FFD8);
  static const Color lightOrange = Color.fromARGB(255, 253, 248, 227);

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
}
