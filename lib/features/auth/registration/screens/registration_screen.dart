import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/auth/login/widgets/custom_textfeild.dart';
import 'package:zephyr/features/auth/provider/auth_provider.dart';
import 'package:zephyr/features/auth/registration/screens/registration_syllabus.dart';
import 'package:zephyr/features/auth/registration/widgets/dropdown_widget.dart';
import 'package:zephyr/features/auth/registration/widgets/gender_widget.dart';

class RegistrationScreen extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;
  final String isoCode;
  const RegistrationScreen(
      {required this.isoCode,
      required this.countryCode,
      required this.phoneNumber,
      super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class Gender {
  final String label;
  final IconData icon;
  final Color color;

  const Gender({required this.label, required this.icon, required this.color});
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  AuthProvider authProvider = AuthProvider();

  final TextEditingController fnameController = TextEditingController();
  final TextEditingController snameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController guardianController = TextEditingController();
  final TextEditingController gemailController = TextEditingController();
  final TextEditingController gmobController = TextEditingController();
  final TextEditingController gaddressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<Gender> genderOptions = [
    Gender(
        label: "Male", icon: Icons.male_rounded, color: AppColors.primaryBlue),
    Gender(
        label: "Female",
        icon: Icons.female_rounded,
        color: AppColors.primaryOrange)
  ];

  Future<void> loadDropdownOption() async {
    final loadProvider = context.read<AuthProvider>();
    await loadProvider.fetchRegisrationDropdownOption();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDropdownOption();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = context.watch<AuthProvider>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: authProvider.isDropdownLoading
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Your ",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600)),
                              Text("Journey",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: AppColors.primaryGreen,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Begins Here ",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'Full Name',
                            controller: fnameController,
                            suffixIcon: Icon(Icons.person),
                          ),
                          SizedBox(height: 5),
                          GestureDetector(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    dobController.text =
                                        "${pickedDate.toLocal()}".split(' ')[0];
                                  });
                                }
                              },
                              child: AbsorbPointer(
                                  child: CustomTextField(
                                hintText: 'Date of Birth',
                                controller: dobController,
                                suffixIcon: Icon(Icons.calendar_month),
                              ))),
                          SizedBox(height: 5),
                          CustomTextField(
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            suffixIcon: Icon(Icons.email),
                          ),
                          SizedBox(height: 5),
                          CustomTextField(
                            hintText: 'School Name',
                            obscureText: true,
                            controller: schoolController,
                            suffixIcon: Icon(Icons.school),
                          ),
                          SizedBox(height: 5),
                          DropdownWidget(
                            label: 'Class',
                            items: authProvider.classDropdownOptions
                                .map((classOption) =>
                                    classOption.title ?? "Class Option")
                                .toList(),
                            controller: classController,
                          ),
                          SizedBox(height: 20),
                          IntlPhoneField(
                            enabled: false,
                            initialValue: widget.phoneNumber,
                            decoration: InputDecoration(
                              labelText: 'Mobile Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(),
                              ),
                            ),
                            initialCountryCode: widget.isoCode,
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text("Gender"),
                          ),
                          SizedBox(height: 5),
                          Row(
                            spacing: 10,
                            children: [
                              ...List.generate(
                                  genderOptions.length,
                                  (index) => Expanded(
                                          child: GestureDetector(
                                        onTap: () =>
                                            authProvider.setSelectedGender(
                                                genderOptions[index]
                                                    .label
                                                    .toLowerCase()),
                                        child: GenderWidget(
                                            index: index,
                                            selectedIndex:
                                                authProvider.selectedGender,
                                            label: genderOptions[index].label,
                                            icon: genderOptions[index].icon,
                                            color: genderOptions[index].color),
                                      )))
                            ],
                          ),
                          SizedBox(height: 15),
                          if (authProvider.selectedGender == null)
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text("Please select a gender", style: TextStyle(
                                color: const Color(0xFFB00020)
                              ),),
                            ),
                          SizedBox(height: 20),
                          Builder(
                            builder: (context) {
                              return CustomButton(
                                text: "Next",
                                color: AppColors.primaryGreen,
                                textcolor: AppColors.white,
                                onPressed: () {
                                  if (authProvider.selectedGender == "") {
                                    authProvider.setGenderNull();
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RegistrationSyllabus(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Please fill all required fields")),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account? "),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: AppColors.primaryGreen,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
