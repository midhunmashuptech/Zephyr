import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zephyr/constants/app_constants.dart';

void showSnackBar(
  String title,
  String message,
) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: AppColors.primaryBlue.withAlpha(10),
    colorText: Colors.black,
    margin: EdgeInsets.symmetric(vertical: 10),
    titleText: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    snackStyle: SnackStyle.FLOATING,
    duration: const Duration(seconds: 3),
  );
}

String capitalizeFirst(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

String formatDate(String isoDate, String format) {
  try {
    if (isoDate == "") return "N/A";
    final date = DateTime.parse(isoDate);
    return DateFormat(format).format(date);
    // // Example: 31 Jul 2025
    // return "${date.day.toString().padLeft(2, '0')} "
    //     "${_monthAbbreviation(date.month)} "
    //     "${date.year}";
  } catch (e) {
    return isoDate;
  }
}
