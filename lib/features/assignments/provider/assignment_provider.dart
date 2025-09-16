import 'package:flutter/cupertino.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/assignments/models/assignment_model.dart';
import 'package:zephyr/features/assignments/service/assignment_service.dart';

class AssignmentProvider extends ChangeNotifier {
  bool _isAssignmentsLoading = false;
  bool get isAssignmentsLoading => _isAssignmentsLoading;

  bool _isAssignmentDetailsLoading = false;
  bool get isAssignmentDetailsLoading => _isAssignmentDetailsLoading;

  List<Assignments> _assignmentList = [];
  List<Assignments> get assignmentList => _assignmentList;

//Assignments
  Future<void> fetchAssignments({required BuildContext context}) async {
    _isAssignmentsLoading = true;
    notifyListeners();
    final response = await AssignmentService().getAssignments(context: context);
    if (response == null) {
      showSnackBar("Error", "Error Fetching Assignments");
      _isAssignmentsLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _assignmentList = response.assignments ?? [];
        notifyListeners();
        showSnackBar("Success", "Successfully Fetched Assignments");
        _isAssignmentsLoading = false;
        notifyListeners();
      }
    }
  }

  //AssignmentDetails
  
}
