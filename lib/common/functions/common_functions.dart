import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

void showSnackBar(String title, String message,) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: AppColors.primaryBlue.withAlpha(10),
    colorText: Colors.black,
    margin: EdgeInsets.symmetric(vertical: 10),
    titleText: Text(title, style: TextStyle(fontWeight: FontWeight.w600),),
    snackStyle: SnackStyle.FLOATING,
    duration: const Duration(seconds: 3),
  );
}

String capitalizeFirst(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}
