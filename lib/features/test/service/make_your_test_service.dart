import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/test/model/class_subject_options_model.dart';

class MakeYourTestService {
  Future<ClassSubjectOptionsModel?> getClassSubjectOptionsModel() async {
    final responseJson = await ApiService()
        .authPostRequest(url: getClassSubjectOptionsUrl, fields: {});
    
    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("Error", "Json Error");
      return null;
    } else {
      final classSubjectOptionsModel =
          ClassSubjectOptionsModel.fromJson(responseJson);
      if (classSubjectOptionsModel.type == "success") {
        return classSubjectOptionsModel;
      } else {
        return classSubjectOptionsModel;
      }
    }
  }
}
