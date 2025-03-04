import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/login/widgets/custom_textfeild.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? _selectgender;
  bool isChecked = false;
  bool isPwdVisible = false;
  bool isCPwdVisible = false;
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
  final TextEditingController gpwdController = TextEditingController();
  final TextEditingController gcpwdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                              fontWeight: FontWeight.bold)),
                      Text("Journey",
                          style: TextStyle(
                              fontSize: 25,
                              color: AppColors.primaryGreen,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Begins Here ",
                          style: TextStyle(
                              fontSize: 25,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Enter your  First Name',
                    controller: fnameController,
                    suffixIcon: Icon(Icons.person),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Enter your Second Name',
                    controller: snameController,
                    suffixIcon: Icon(Icons.person),
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
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                  // ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Enter your Class',
                    obscureText: true,
                    controller: classController,
                    suffixIcon: Icon(Icons.school),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Enter your School Name',
                    obscureText: true,
                    controller: schoolController,
                    suffixIcon: Icon(Icons.school),
                  ),
                  SizedBox(height: 20),
                  Text("Select Your Gender: ", style: TextStyle(fontSize: 18)),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 'Male',
                              groupValue: _selectgender,
                              onChanged: (value) {
                                setState(() {
                                  _selectgender = value.toString();
                                });
                              },
                            ),
                            Text('Male'),
                          ],
                        ),
                        SizedBox(width: 20),
                        Row(
                          children: [
                            Radio(
                              value: 'Female',
                              groupValue: _selectgender,
                              onChanged: (value) {
                                setState(() {
                                  _selectgender = value.toString();
                                });
                              },
                            ),
                            Text('Female'),
                          ],
                        ),
                        SizedBox(width: 20),
                        Row(
                          children: [
                            Radio(
                              value: 'Others',
                              groupValue: _selectgender,
                              onChanged: (value) {
                                setState(() {
                                  _selectgender = value.toString();
                                });
                              },
                            ),
                            Text('Others'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: "Enter your Guardian's Name",
                    controller: guardianController,
                    suffixIcon: SizedBox(
                      height: 20,
                      width: 20,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                              right: 5, child: Iconify(Mdi.person, size: 20)),
                          Positioned(left: 5, child: Iconify(Mdi.person)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: "Enter your Guardian's Email",
                    controller: gemailController,
                    suffixIcon: Icon(Icons.email),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: "Enter your Guardian's Number",
                    controller: gmobController,
                    suffixIcon: Icon(Icons.call),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: "Enter your Guardian's Address",
                    controller: gaddressController,
                    suffixIcon: Icon(Icons.home),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: "Enter your Password",
                    obscureText: isPwdVisible,
                    controller: gpwdController,
                    suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPwdVisible = !isPwdVisible;
                            });
                          },
                          icon: isPwdVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: "Confirm your Password",
                    obscureText: isCPwdVisible,
                    controller: gcpwdController,
                    suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isCPwdVisible = !isCPwdVisible;
                            });
                          },
                          icon: isCPwdVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                  ),
                  Row(children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                      focusColor: AppColors.black,
                      activeColor: AppColors.primaryGreen,
                    ),
                    const SizedBox(height: 16),
                    const Text('I Agree to the Terms and Conditions'),
                  ]),
                  SizedBox(height: 20),
                  Builder(
                    builder: (context) {
                      return CustomButton(
                        text: "Register",
                        color: AppColors.primaryGreen,
                        textcolor: AppColors.white,
                        onPressed: () {
                          if (gpwdController.text != gcpwdController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Passwords do not match"),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Registration Successful"),
                              ),
                            );
                          }
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
