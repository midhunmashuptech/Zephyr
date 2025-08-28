import 'package:flutter/cupertino.dart';

class MakeTestProvider extends ChangeNotifier {
  bool _isOptionsLoading = false;
  bool get isOptionsLoading => _isOptionsLoading;

  List<String> _classOptions = [];
  List<String> get classOptions => _classOptions;
  List<String> _subjectOptions = [];
  List<String> get subjectOptions => _subjectOptions;

  Future<void> fetchClassSubjectsOptions() async {}
}
