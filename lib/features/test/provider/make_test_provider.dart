import 'package:flutter/cupertino.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/test/model/class_subject_options_model.dart';
import 'package:zephyr/features/test/service/make_your_test_service.dart';

class MakeTestProvider extends ChangeNotifier {
  bool _isOptionsLoading = false;
  bool get isOptionsLoading => _isOptionsLoading;

  List<Classes> _classes = [];
  List<Classes> get classes => _classes;
  List<Subjects> _subjects = [];
  List<Subjects> get subjects => _subjects;

  List<String> _classOptions = [];
  List<String> get classOptions => _classOptions;
  List<String> _subjectOptions = [];
  List<String> get subjectOptions => _subjectOptions;

  Future<void> fetchClassSubjectsOptions(BuildContext context) async {
    _isOptionsLoading = true;
    notifyListeners();

    final response = await MakeYourTestService().getClassSubjectOptionsModel();
    if (response == null) {
      showSnackBar("Error", "Something went wrong! please try again");
    } else {
      if (response.type == "success") {
        _classes = response.classes ?? [];
        _subjects = response.subjects ?? [];

        _classOptions = classes.map((clas) => clas.title ?? "").toList();
        _subjectOptions =
            subjects.map((subject) => subject.title ?? "").toList();
      } else {
        _classOptions = [];
        _subjectOptions = [];
      }
    }
    notifyListeners();

    _isOptionsLoading = false;
    notifyListeners();
  }
}
