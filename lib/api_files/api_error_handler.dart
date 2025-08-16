import 'package:get/get.dart';
import 'package:zephyr/api_files/api_exceptions.dart';
import 'package:zephyr/features/login/screens/mobile_number_verification.dart';

class ApiErrorHandler {
  static void handleError(ApiException exception) {
    if (exception is UnauthorizedException) {
      // clear token
      Get.offAll(() => const MobileNumberVerification());
      Get.snackbar(
        "Session Expired",
        "Please login again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (exception is BadRequestException) {
      _showSnack("Bad Request", exception.message);
    } else if (exception is NotFoundException) {
      _showSnack("Not Found", exception.message);
    } else if (exception is InternalServerErrorException) {
      _showSnack("Server Error", "Please try again later.");
    } else if (exception is NetworkException) {
      _showSnack("Network Error", "Check your internet connection.");
    } else {
      _showSnack("Error", exception.message);
    }
  }

  static void _showSnack(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }
}
