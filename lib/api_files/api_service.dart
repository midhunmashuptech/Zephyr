import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/login/screens/mobile_number_verification.dart';
import 'api_exceptions.dart';

class ApiService {
  final String? authToken;

  ApiService({this.authToken});

  /// GET request
  Future<dynamic> authGetRequest({required String url}) async {
    try {
      final response = await http.get(Uri.parse(url));
      return _handleResponse(response);
    } on http.ClientException {
      _showError("Client error. Please check your connection.");
      throw NetworkException("Client error. Please check your connection.");
    }
  }

  /// POST request (multipart style)
  Future<dynamic> authPostRequest(
      {required String url, required Map<String, String> fields}) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll(fields);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);
    } on http.ClientException {
      _showError("Client error. Please check your connection.");
      throw NetworkException("Client error. Please check your connection.");
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////

  /// Authenticated GET request
  Future<dynamic> getRequest({required String url}) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: _authHeaders(),
      );
      return _handleResponse(response);
    } on http.ClientException {
      _showError("Client error. Please check your connection.");
      throw NetworkException("Client error. Please check your connection.");
    }
  }

  /// Authenticated POST request (multipart style)
  Future<dynamic> postRequest(
      {required String url, required Map<String, String> fields}) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll(fields);
      request.headers.addAll(_authHeaders());

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);
    } on http.ClientException {
      _showError("Client error. Please check your connection.");
      throw NetworkException("Client error. Please check your connection.");
    }
  }

  /// Auth headers helper
  Map<String, String> _authHeaders() {
    return {
      "Authorization": "Bearer $authToken",
      "Accept": "application/json",
    };
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /// Handle API response
  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body.isNotEmpty ? response.body : '{}';

    switch (statusCode) {
      case 200:
      case 201:
        try {
          return json.decode(body);
        } catch (_) {
          return body; // fallback if not JSON
        }

      case 401:
        print("hiii");
        Get.offAll(() => const MobileNumberVerification());
        throw UnauthorizedException("Unauthorized. Please login again.");

      case 400:
        _showError("Bad request. Please try again.");
        throw BadRequestException("Bad request.");

      case 404:
        print("nhj");
        _showError("Resource not found.");
        throw NotFoundException("Resource not found.");

      case 500:
      case 502:
      case 503:
        _showError("Server error. Please try later.");
        throw InternalServerErrorException("Server error.");

      default:
        print("jio");
        _showError("Unexpected error: $statusCode");
        throw ApiException("Unexpected error $statusCode");
    }
  }

  /// 🔹 Show error snackbar
  void _showError(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: AppColors.black,
      duration: const Duration(seconds: 3),
    );
  }
}
