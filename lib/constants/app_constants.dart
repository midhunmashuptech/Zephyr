import 'package:flutter/material.dart';

class AppColors {

  //Primary colors
  static const Color primaryBlue = Color(0xFF5F61F0);
  static const Color primaryGreen = Color(0xFF68BD00);
  static const Color primaryOrange = Color(0xFFF5A101);
  static const Color primaryRed = Color(0xFFFF0000);

  //Black and white
  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color black = Color.fromARGB(255, 0, 0, 0);

  //Blue Shades
  static const Color darkBlue = Color(0xFF4A2CD0);
  static const Color dropdownblue = Color.fromRGBO(195, 227, 249, 1);
  static const Color secondaryViolet = Color(0xFF5E22A2);
  static const Color secondaryCyan = Color(0xFF16DBCC);
  static const Color lightBlue = Color.fromARGB(255, 179, 204, 255);

  //Grey Shades
  static const Color grey = Color.fromARGB(255, 198, 198, 198);
  static const Color ratingGrey = Color.fromARGB(255, 78, 77, 77);
  static const Color lightGrey = Color(0xFFEEEEEE);
static const Color borderGrey = Color(0xFFFBFEFF);

  //Light Shades
  static const Color lightGreen = Color.fromARGB(255, 172, 255, 130);
  static const Color lightOrange = Color.fromARGB(255, 255, 186, 75);
  static const Color lightRed = Color.fromARGB(255, 255, 191, 191);

  //Yellow
  static const Color ratingYellow = Color.fromARGB(255, 255, 242, 0);

  //Red
  static const Color darkred = Color(0xFFC00000);

  // color gradients 
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

  static const Gradient orangeCourseActionGradient = LinearGradient(
  colors: [
    Color(0xFFF5A101), // #F39E00 with 52% opacity
    Color.fromARGB(255, 255, 232, 183), // transparent
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

static const Gradient greenCourseActionGradient = LinearGradient(
  colors: [
   Color(0xFF68BD00), // #F39E00 with 52% opacity
    Color.fromARGB(255, 214, 255, 183), // transparent
  ],
  
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
}
