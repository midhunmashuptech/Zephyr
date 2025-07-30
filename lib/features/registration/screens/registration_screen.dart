import 'package:flutter/material.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/login/widgets/custom_textfeild.dart';
import 'package:zephyr/features/registration/screens/registration_syllabus.dart';
import 'package:zephyr/features/registration/widgets/dropdown_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
  List<String> classNames = [
    "class 7",
    "class 8",
    "class 9",
    "class 10",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Enter your Name',
                    controller: fnameController,
                    suffixIcon: Icon(Icons.person),
                  ),
                  SizedBox(height: 20),
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
                    // child: AbsorbPointer(
                    child: CustomTextField(
                      hintText: 'Enter your Date of Birth',
                      controller: dobController,
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Enter your Email',
                    obscureText: true,
                    controller: emailController,
                    suffixIcon: Icon(Icons.email),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Enter your Mobile Number',
                    obscureText: true,
                    controller: mobController,
                    suffixIcon: Icon(Icons.call),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Enter your School Name',
                    obscureText: true,
                    controller: schoolController,
                    suffixIcon: Icon(Icons.school),
                  ),
                  SizedBox(height: 20),
                  DropdownWidget(
                    label: 'Enter your Class',
                    items: classNames,
                    controller: classController,
                  ),
                  SizedBox(height: 20),
                  Builder(
                    builder: (context) {
                      return CustomButton(
                        text: "Next",
                        color: AppColors.primaryGreen,
                        textcolor: AppColors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RegistrationSyllabus()));
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
