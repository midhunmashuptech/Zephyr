import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/fa6_solid.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/login/widgets/custom_textfeild.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? _selectgender;
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  hintText: 'Enter your  First Name',
                  controller: fnameController,
                  suffixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  hintText: 'Enter your Second Name',
                  controller: snameController,
                  suffixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  hintText: 'Enter your Email',
                  obscureText: true,
                  controller: emailController,
                  suffixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  hintText: 'Enter your Mobile Number',
                  obscureText: true,
                  controller: mobController,
                  suffixIcon: Icon(Icons.call),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
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
              ),
              // ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  hintText: 'Enter your Class',
                  obscureText: true,
                  controller: classController,
                  suffixIcon: Icon(Icons.school),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  hintText: 'Enter your School Name',
                  obscureText: true,
                  controller: schoolController,
                  suffixIcon: Icon(Icons.school),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text("Select Your Gender: ",
                    style: TextStyle(fontSize: 18)),
              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  hintText: "Enter your Guardian's Name",
                  controller: guardianController,
                  suffixIcon: SizedBox(
                    height: 20,
                    width: 20,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(right: 5, child: Iconify(Mdi.person, size: 20)),
                        Positioned(left: 5, child: Iconify(Mdi.person)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  hintText: "Enter your Guardian's Email",
                  controller: gemailController,
                  suffixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  hintText: "Enter your Guardian's Number",
                  controller: gmobController,
                  suffixIcon: Icon(Icons.call),
                ),
              ),
               SizedBox(height: 20),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  hintText: "Enter your Guardian's Address",
                  controller: gaddressController,
                  suffixIcon: Icon(Icons.home),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
