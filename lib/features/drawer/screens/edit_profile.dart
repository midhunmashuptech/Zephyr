import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/auth/registration/widgets/dropdown_widget.dart';
import 'package:zephyr/features/drawer/provider/edit_profile_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? selectedImage;

  UserDetailsProvider userDetailsProvider = UserDetailsProvider();
  EditProfileProvider editProfileProvider = EditProfileProvider();

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController secondaryPhoneController =
      TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController classController = TextEditingController();


  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() {
    final loadProvider = context.read<UserDetailsProvider>();
    usernameController.text = loadProvider.userDetails.name ?? "";
    emailController.text = loadProvider.userDetails.email ?? "";
    mobileController.text = loadProvider.userDetails.phone ?? "";
    schoolController.text = loadProvider.userDetails.school ?? "";
    addressController.text = loadProvider.userDetails.address ?? "";
    countryController.text = loadProvider.userDetails.country ?? "";
    stateController.text = loadProvider.userDetails.state ?? "";
    districtController.text = loadProvider.userDetails.district ?? "";
    classController.text = loadProvider.userDetails.district ?? "";
  }

  @override
  Widget build(BuildContext context) {
    userDetailsProvider = context.watch<UserDetailsProvider>();
    editProfileProvider = context.read<EditProfileProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: selectedImage == null
                          ? AssetImage("assets/images/kim_shin.webp")
                          : FileImage(selectedImage!),
                      radius: 90,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryOrange,
                        child: IconButton(
                          onPressed: () => pickImage(),
                          icon: Icon(
                            Icons.edit,
                            size: 23,
                          ),
                          color: AppColors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(hintText: "Enter user name"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Enter email address"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: schoolController,
                decoration: InputDecoration(hintText: "Enter School Name"),
              ),
              SizedBox(height: 10),
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
                  child: TextField(
                    controller: dobController,
                    decoration:
                        InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month),
                          hintText: "Enter Date of Birth"),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: addressController,
                decoration: InputDecoration(hintText: "Enter Address"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: countryController,
                decoration: InputDecoration(hintText: "Enter Country"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: stateController,
                decoration: InputDecoration(hintText: "Enter State"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: districtController,
                decoration: InputDecoration(hintText: "Enter District"),
              ),
              SizedBox(height: 5),
              DropdownWidget(label: 'ygfuyg',
               items: ["rt","rdcr","rdrer"], 
               controller: classController,),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                controller: secondaryPhoneController,
                decoration:
                    InputDecoration(hintText: "Enter Secondary Phone Number"),
              ),
              SizedBox(height: 10),
              TextField(
                style: TextStyle(color: AppColors.grey),
                readOnly: true,
                controller: mobileController,
                decoration: InputDecoration(
                    errorText:
                        "Disclaimer: For mobile number changes, kindly contact our support team.",
                    errorMaxLines: 2,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Enter mobile number"),
              ),
              // SizedBox(height: 5),
              SizedBox(height: 20),
              CustomButton(
                text: "Update",
                onPressed: () {
                  editProfileProvider.setUpdatedProfile(
                      usernameController.text, emailController.text);
                },
                color: AppColors.primaryOrange,
                textcolor: AppColors.white,
              )
            ],
          ),
        )),
      ),
    );
  }
}
