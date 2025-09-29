import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/assignments/models/assignment_details_model.dart';
import 'package:zephyr/features/assignments/models/assignment_model.dart';
import 'package:zephyr/features/assignments/service/assignment_service.dart';

class AssignmentProvider extends ChangeNotifier {
  bool _isAssignmentsLoading = false;
  bool get isAssignmentsLoading => _isAssignmentsLoading;

  bool _isAssignmentDetailsLoading = false;
  bool get isAssignmentDetailsLoading => _isAssignmentDetailsLoading;

  bool _isAssignmentSubmitting = false;
  bool get isAssignmentSubmitting => _isAssignmentSubmitting;

  List<Assignments> _assignmentList = [];
  List<Assignments> get assignmentList => _assignmentList;

  AssignmentDetails _assignmentDetails = AssignmentDetails();
  AssignmentDetails get assignmentDetails => _assignmentDetails;

  PlatformFile? selectedFile;
  void setSelectedFile(PlatformFile file) {
    selectedFile = file;
    notifyListeners();
  }

  void removeSelectedFile() {
    selectedFile = null;
    notifyListeners();
  }

  //Assignments
  Future<void> fetchAssignments({required BuildContext context}) async {
    _isAssignmentsLoading = true;
    _assignmentList = [];
    notifyListeners();
    final response = await AssignmentService().getAssignments(context: context);
    if (response == null) {
      showSnackBar("Error", "Error Loading Assignments");
      _isAssignmentsLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _assignmentList = response.assignments ?? [];
        notifyListeners();
        _isAssignmentsLoading = false;
        notifyListeners();
      }
    }
  }

  //AssignmentDetails
  Future<void> fetchAssignmentDetails(
      {required BuildContext context, required String assignmentId}) async {
    _isAssignmentDetailsLoading = true;
    _assignmentDetails = AssignmentDetails();
    selectedFile = null;
    notifyListeners();
    final response = await AssignmentService()
        .getAssignmentDetails(context: context, assignmentId: assignmentId);
    if (response == null) {
      showSnackBar("Error", "Error Loading Assignment Details");
      _isAssignmentDetailsLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _assignmentDetails = response.assignmentDetails ?? AssignmentDetails();
        notifyListeners();
        _isAssignmentDetailsLoading = false;
        notifyListeners();
      }
    }
  }

  //Assignment Submission
  Future<void> submitAssignment(
      {required BuildContext context, required String assignmentId}) async {
    _isAssignmentSubmitting = true;
    notifyListeners();
    final response = await AssignmentService().submitAssignment(
        context: context,
        assignmentId: assignmentId,
        filePath: selectedFile?.path ?? "");
    if (response == null) {
      showSnackBar("Error", "Error Submitting Assignment");
      _isAssignmentSubmitting = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        showSnackBar("Success", "Successfully Submitted Assignment");
        _isAssignmentSubmitting = false;
        notifyListeners();
        Navigator.pop(context);
      } else if (response.type == "error" &&
          response.message == "You have already submitted this assignment.") {
        showSnackBar("Success", "Assignment already submitted!");
        _isAssignmentSubmitting = false;
        notifyListeners();
        Navigator.pop(context);
      }
      _isAssignmentSubmitting = false;
      notifyListeners();
    }
  }
}
