import 'package:flutter/widgets.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/assignments/models/assignment_details_model.dart';
import 'package:zephyr/features/assignments/models/assignment_model.dart';

class AssignmentService {

//Assignment Lists
  Future<AssignmentModel?> getAssignments(
      {required BuildContext context}) async {
    final responseJson =
        await ApiService().postRequest(url: getAssignmentUrl, fields: {});
    if (responseJson == null) {
      showSnackBar("Eroor", "Error loading Assignments");
    } else {
      final assignmentModel = AssignmentModel.fromJson(responseJson);
      return assignmentModel;
    }
    return null;
  }

  //Assignment List Details
  Future<AssignmentDetailsModel?> getAssignmentDetails(
      {required BuildContext context, required String assignmentId}) async {
    final responseJson = await ApiService().postRequest(
        url: getAssignmentDetailsUrl, fields: {"assignment_id": assignmentId});
    if (responseJson == null) {
      showSnackBar("Error", "Error Loading Assignment details");
    } else {
      final assignmentDetailModel =
          AssignmentDetailsModel.fromJson(responseJson);
      return assignmentDetailModel;
    }
    return null;
  }

}
