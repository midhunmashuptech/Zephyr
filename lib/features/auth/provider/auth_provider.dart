import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/model/user.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/features/auth/registration/model/registration_dropdown_options_model.dart'
    as dropdownModel;
import 'package:zephyr/features/auth/service/login_service.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:zephyr/features/auth/service/registration_service.dart';

class AuthProvider extends ChangeNotifier {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  bool _isVerifyingPhone = false;
  bool get isVerifyingPhone => _isVerifyingPhone;

  bool _isLogining = false;
  bool get isLogining => _isLogining;

  bool _isDropdownLoading = false;
  bool get isDropdownLoading => _isDropdownLoading;

  List<dropdownModel.ClassStudying> _classDropdownOptions = [];
  List<dropdownModel.ClassStudying> get classDropdownOptions =>
      _classDropdownOptions;

  List<dropdownModel.Syllabus> _syllabusDropdownOptions = [];
  List<dropdownModel.Syllabus> get syllabusDropdownOptions =>
      _syllabusDropdownOptions;

  String countryISOCode = 'IN';
  String countryCode = '';
  String phoneNumber = '';
  String errorText = '';
  bool isValidNumber = false;
  String? userExist;

  // Registration Variables
  // Registration Form Varibale
  String fullName = "";
  String dob = "";
  String email = "";
  String schoolName = "";
  int classId = 0;
  String? selectedGender = "";

  // Registration Syllabus Variable
  int? selectedSyllabusId;

  // Registration Password Variable
  String registrationPassword = "123456";

  void setPassword(String enterdPassword) {
    registrationPassword = enterdPassword;
    notifyListeners();
    print(registrationPassword);
    print(selectedSyllabusId);
    print(fullName);
    print(dob);
    print(email);
    print(schoolName);
    print(classId);
    print(selectedGender);
    print(phoneNumber);
    print(countryCode);
  }

  Future<void> registerUser({
    required BuildContext context,
  }) async {
    final response = await RegistrationService().registerUser(context,
        name: fullName,
        email: email,
        phone: phoneNumber,
        countryCode: countryCode,
        dob: dob,
        gender: selectedGender ?? "",
        school: schoolName,
        classStudying: classId.toString(),
        syllabus: selectedSyllabusId.toString(),
        password: password);
    if (response == null) {
      showSnackBar("error", "Something went wrong! please try again");
    } else {
      if (response.type == "success" && response.token != null) {
        final userDetails = response.user;
        final userDetailProvider = context.read<UserDetailsProvider>();
        userDetailProvider.setUserDetails(userDetails ?? User());
        await _secureStorage.write(key: "token", value: response.token);
        showSnackBar("Registration success", "Start your journey now");
      } else {
        showSnackBar("Registration failed", "Please try again later");
      }
    }
  }

  // Login Variables
  bool _isPasswordEmpty = false;
  bool get isPasswordEmpty => _isPasswordEmpty;
  String password = '';

  void setSelectedGender(String gender) {
    selectedGender = gender;
    notifyListeners();
  }

  void clearSyllabus() {
    selectedSyllabusId = null;
  }

  void setSelectedSyllabus(int? syllabusId) {
    selectedSyllabusId = syllabusId;
    notifyListeners();
  }

  void setGenderNull() {
    selectedGender = null;
    notifyListeners();
  }

  void setAllFormValues(String nameValue, String dobValue, String emailValue,
      String schoolNameValue, int classIdValue) {
    fullName = nameValue;
    dob = dobValue;
    email = emailValue;
    schoolName = schoolNameValue;
    classId = classIdValue;

    debugPrint(nameValue +
        dobValue +
        emailValue +
        schoolNameValue +
        classIdValue.toString() +
        "$selectedGender");
  }

  void updatePasswordStatus(bool value, String typedPassword) {
    _isPasswordEmpty = value;
    password = typedPassword;
    notifyListeners();
  }

  /// Update phone number & validate
  void updatePhoneNumber(PhoneNumber value) {
    countryISOCode = value.countryISOCode;
    countryCode = value.countryCode;
    phoneNumber = value.number;

    if (phoneNumber.isEmpty) {
      errorText = "Mobile number is required";
      isValidNumber = false;
    } else if (!value.isValidNumber()) {
      errorText = "Enter a valid mobile number";
      isValidNumber = false;
    } else {
      errorText = '';
      isValidNumber = true;
    }

    notifyListeners();
  }

  Future<void> userLogin(BuildContext context, String password) async {
    _isLogining = true;
    debugPrint("true $isLogining");
    notifyListeners();

    final response = await LoginService().login(context,
        countryCode: countryCode, phone: phoneNumber, password: password);
    if (response == null) {
      debugPrint("Something went wrong! please try again");
      _isLogining = false;
      notifyListeners();
    } else {
      if (response.type == "success" &&
          response.token != null &&
          response.token != "") {
        // Writing token to Flutter secure Storage
        await _secureStorage.write(key: "token", value: response.token);

        // Reading token from Flutter secure Storage
        final token = await _secureStorage.read(key: "token");

        context
            .read<UserDetailsProvider>()
            .setUserDetails(response.user ?? User());

        print(token);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavScreen()),
        ).then((_) {
          _isLogining = false;
          notifyListeners();
        });
      } else {
        _isLogining = false;
        notifyListeners();
      }
    }
  }

  Future<void> verifyPhoneNumber(
      BuildContext context, String phone, String countryCode) async {
    _isVerifyingPhone = true;
    notifyListeners();

    final response = await LoginService()
        .verifyPhoneNumber(context, countryCode: countryCode, phone: phone);
    if (response == null) {
      userExist == "error";
    } else {
      print(response.exists);
      if (response.exists == true) {
        userExist = "true";
      } else if (response.exists == false) {
        userExist = "false";
      }
    }
    notifyListeners();

    _isVerifyingPhone = false;
    _isPasswordEmpty = false;
    password = '';
    notifyListeners();
  }

  Future<void> fetchRegisrationDropdownOption() async {
    _isDropdownLoading = true;
    selectedGender = "";
    notifyListeners();

    final response = await RegistrationService().getRegisterDropdownOptions();
    if (response == null) {
      showSnackBar("Error", "Something went wrong! Try again");
    } else {
      if (response.type == "success") {
        _classDropdownOptions = response.classStudying ?? [];
        _syllabusDropdownOptions = response.syllabuses ?? [];
        print("Syllabus: ${syllabusDropdownOptions.length}");
      } else {
        _classDropdownOptions = [];
        _syllabusDropdownOptions = [];
      }
    }
    notifyListeners();

    _isDropdownLoading = false;
    notifyListeners();
  }
}
