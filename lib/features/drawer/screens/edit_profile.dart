import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/auth/provider/auth_provider.dart';
import 'package:zephyr/features/auth/registration/model/registration_dropdown_options_model.dart';
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
  AuthProvider authProvider = AuthProvider();

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
  final TextEditingController dobController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController secondaryMobileController =
      TextEditingController();
  final TextEditingController syllabusController = TextEditingController();

  String formatIsoDate(String isoDate) {
    if (isoDate == "") return "";
    DateTime parsedDate = DateTime.parse(isoDate);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final loadProvider = context.read<UserDetailsProvider>();
    final optionsProvider = context.read<AuthProvider>();
    final editProvider = context.read<EditProfileProvider>();
    editProvider.loadingTrue();

    await optionsProvider.fetchRegisrationDropdownOption();
    usernameController.text = loadProvider.userDetails.name ?? "";
    emailController.text = loadProvider.userDetails.email ?? "";
    mobileController.text = loadProvider.userDetails.phone ?? "";
    schoolController.text = loadProvider.userDetails.school ?? "";
    addressController.text = loadProvider.userDetails.address ?? "";
    countryController.text = loadProvider.userDetails.country ?? "";
    stateController.text = loadProvider.userDetails.state ?? "";
    districtController.text = loadProvider.userDetails.district ?? "";
    dobController.text = formatIsoDate(loadProvider.userDetails.dob ?? "");
    print(optionsProvider.classDropdownOptions.length);
    classController.text = optionsProvider.classDropdownOptions
            .firstWhere(
                (option) =>
                    option.id.toString() ==
                    loadProvider.userDetails.classStudying,
                orElse: () => ClassStudying(title: "Invalid Option"))
            .title ??
        "option";
    syllabusController.text = optionsProvider.syllabusDropdownOptions
            .firstWhere(
                (syllabus) =>
                    loadProvider.userDetails.syllabusId == syllabus.id,
                orElse: () => Syllabus(title: "Invalid Syllabus"))
            .title ??
        "";

    if (loadProvider.userDetails.gender == "male" ||
        loadProvider.userDetails.gender == "female") {
      editProvider.radiocheck(loadProvider.userDetails.gender);
    } else {
      editProvider.radiocheck(null);}

    editProvider.loadingFalse();
  }

  @override
  Widget build(BuildContext context) {
    userDetailsProvider = context.watch<UserDetailsProvider>();
    editProfileProvider = context.watch<EditProfileProvider>();
    authProvider = context.watch<AuthProvider>();
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
                          ? CachedNetworkImageProvider(
                              userDetailsProvider.userDetails.image ?? "")
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
              editProfileProvider.isDataLoading
                  ? Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: usernameController,
                          decoration:
                              InputDecoration(hintText: "Enter user name"),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: emailController,
                          decoration:
                              InputDecoration(hintText: "Enter email address"),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: schoolController,
                          decoration:
                              InputDecoration(hintText: "Enter School Name"),
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
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.calendar_month),
                                  hintText: "Enter Date of Birth"),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Gender"),
                        Row(
                          children: [
                            Radio<String>(
                                value: "male",
                                groupValue: editProfileProvider.checkedOption,
                                onChanged: (value) {
                                  editProfileProvider.radiocheck(value);
                                }),
                            Text(
                              "Male",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 7),
                            Row(
                              children: [
                                Radio<String>(
                                    value: "female",
                                    groupValue:
                                        editProfileProvider.checkedOption,
                                    onChanged: (value) {
                                      editProfileProvider.radiocheck(value);
                                    }),
                                // SizedBox(width:4),
                                Text(
                                  "Female",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ],
                        ),
                        DropdownWidget(
                          label: 'Syllabus',
                          items: authProvider.syllabusDropdownOptions
                              .map((item) => item.title ?? "Syllabus Option")
                              .toList(),
                          controller: syllabusController,
                        ),
                        TextField(
                          controller: addressController,
                          decoration:
                              InputDecoration(hintText: "Enter Address"),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: countryController,
                          decoration:
                              InputDecoration(hintText: "Enter Country"),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: stateController,
                          decoration: InputDecoration(hintText: "Enter State"),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: districtController,
                          decoration:
                              InputDecoration(hintText: "Enter District"),
                        ),
                        SizedBox(height: 5),
                        DropdownWidget(
                          label: 'Class Studying',
                          items: authProvider.classDropdownOptions
                              .map((item) => item.title ?? "Class Option")
                              .toList(),
                          controller: classController,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: secondaryMobileController,
                          decoration: InputDecoration(
                              hintText: "Enter Secondary Phone Number"),
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
                            // hintText: "Enter mobile number"
                          ),
                        ),
                        SizedBox(height: 20),
                        editProfileProvider.isUpdating
                        ? Center(child: CircularProgressIndicator())
                        : CustomButton(
                          text: "Update",
                          onPressed: () {
                            editProfileProvider.updateDetails(
                                context: context,
                                name: usernameController.text,
                                email: emailController.text,
                                gender: editProfileProvider.checkedOption ?? "",
                                dob: dobController.text,
                                school: schoolController.text,
                                classStudying: authProvider.classDropdownOptions
                                    .firstWhere(
                                      (classes) =>
                                          classes.title == classController.text,
                                      orElse: () => ClassStudying(id: 0),
                                    )
                                    .id
                                    .toString(),
                                syllabusId: authProvider.syllabusDropdownOptions
                                    .firstWhere(
                                      (syllabus) =>
                                          syllabus.title ==
                                          syllabusController.text,
                                      orElse: () => Syllabus(id: 0),
                                    )
                                    .id
                                    .toString(),
                                address: addressController.text,
                                district: districtController.text,
                                state: stateController.text,
                                country: countryController.text,
                                secondaryPhone: secondaryMobileController.text);
                            editProfileProvider.setUpdatedProfile(
                                usernameController.text, emailController.text);
                          },
                          color: AppColors.primaryOrange,
                          textcolor: AppColors.white,
                        )
                      ],
                    ),
            ],
          ),
        )),
      ),
    );
  }
}
