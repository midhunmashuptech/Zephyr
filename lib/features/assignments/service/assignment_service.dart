import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/assignments/models/assignment_details_model.dart';
import 'package:zephyr/features/assignments/models/assignment_model.dart';
import 'package:zephyr/features/assignments/models/submit_assignment_model.dart';

class AssignmentService {
//Assignment Lists
  Future<AssignmentModel?> getAssignments(
      {required BuildContext context}) async {
    final responseJson =
        await ApiService().postRequest(url: getAssignmentUrl, fields: {});
    if (responseJson == null) {
      return null;
    } else {
      final assignmentModel = AssignmentModel.fromJson(responseJson);
      return assignmentModel;
    }
  }

  //Assignment List Details
  Future<AssignmentDetailsModel?> getAssignmentDetails(
      {required BuildContext context, required String assignmentId}) async {
    final responseJson = await ApiService().postRequest(
        url: getAssignmentDetailsUrl, fields: {"assignment_id": assignmentId});
    if (responseJson == null) {
      return null;
    } else {
      final assignmentDetailModel =
          AssignmentDetailsModel.fromJson(responseJson);
      return assignmentDetailModel;
    }
  }

  //Assignment List Details
  Future<SubmitAssignmentModel?> submitAssignment(
      {required BuildContext context,
      required String assignmentId,
      required String filePath}) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(submitAssignmentUrl));
      request.fields.addAll({"assignment_id": assignmentId});
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      FlutterSecureStorage secureStorage = FlutterSecureStorage();
      final token = await secureStorage.read(key: "token");
      final headers = {
        'Authorization': 'Bearer $token',
      };
      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        String responseData = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = jsonDecode(responseData);

        var submitAssignmentModel =
            SubmitAssignmentModel.fromJson(jsonResponse);
        if (submitAssignmentModel.type == 'success') {
          debugPrint('Message: ${submitAssignmentModel.message}');
        }
        return submitAssignmentModel;
      } else {
        debugPrint('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception: $e');
      return null;
    }
  }
}
