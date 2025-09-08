import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';
import 'package:zephyr/features/auth/provider/auth_provider.dart';
import 'package:zephyr/features/auth/registration/model/registration_dropdown_options_model.dart';
import 'package:zephyr/features/drawer/screens/new_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? selectedImage;
  UserDetailsProvider userDetailProvider = UserDetailsProvider();
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

  String formatIsoDate(String isoDate) {
    if (isoDate == "") return "";
    DateTime parsedDate = DateTime.parse(isoDate);
    return DateFormat('dd-MM-yyyy').format(parsedDate);
  }

  String capitalize(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}

  Future<void> loadDropDowns() async {
    final authProvider = context.read<AuthProvider>();
    await authProvider.fetchRegisrationDropdownOption();
  }

  @override
  void initState() {
    super.initState();
    loadDropDowns();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = context.watch<AuthProvider>();
    userDetailProvider = context.watch<UserDetailsProvider>();
    return Scaffold(
      body: authProvider.isDropdownLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Stack(
              children: [
                LayoutGradient(gradient: AppColors.orangeGradient),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          BackButton(),
                          SizedBox(width: 10),
                          Text(
                            'Profile Page',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: CircleAvatar(
                          backgroundImage: selectedImage == null
                              ? AssetImage("assets/images/kim_shin.webp")
                              : FileImage(selectedImage!),
                          radius: 80,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              "Fullname",
                              style: TextStyle(color: AppColors.ratingGrey),
                            ),
                            Text(userDetailProvider.userDetails.name ?? "",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Divider(),
                            SizedBox(height: 10),
                            Text(
                              "Email Address",
                              style: TextStyle(color: AppColors.ratingGrey),
                            ),
                            Text(userDetailProvider.userDetails.email ?? "",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Divider(),
                            SizedBox(height: 5),
                            Text(
                              "Mobile Number",
                              style: TextStyle(color: AppColors.ratingGrey),
                            ),
                            Text(userDetailProvider.userDetails.phone ?? "",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Divider(),
                            SizedBox(height: 5),
                            Text(
                              "Secondary Phone Number",
                              style: TextStyle(color: AppColors.ratingGrey),
                            ),
                            Text(
                                userDetailProvider.userDetails.secondaryPhone ??
                                    "",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Divider(),
                            SizedBox(height: 10),
                            Text(
                              "School",
                              style: TextStyle(color: AppColors.ratingGrey),
                            ),
                            Text(userDetailProvider.userDetails.school ?? "",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Divider(),
                            SizedBox(height: 10),
                            Text(
                              "Class Studying",
                              style: TextStyle(color: AppColors.ratingGrey),
                            ),
                            Text(
                                authProvider.classDropdownOptions
                                        .firstWhere(
                                          (classOption) =>
                                              classOption.id.toString() ==
                                              userDetailProvider
                                                  .userDetails.classStudying,
                                          orElse: () =>
                                              ClassStudying(title: "No Class"),
                                        )
                                        .title ??
                                    "",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Divider(),
                            SizedBox(height: 10),
                            Text(
                              "Syllabus",
                              style: TextStyle(color: AppColors.ratingGrey),
                            ),
                            Text(
                                authProvider.syllabusDropdownOptions
                                        .firstWhere(
                                            (syllabus) =>
                                                syllabus.id ==
                                                userDetailProvider
                                                    .userDetails.syllabusId,
                                            orElse: () => Syllabus(
                                                title: "No Syllabus Found"))
                                        .title ??
                                    "",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Divider(),
                            SizedBox(height: 10),
                            Text(
                              "Gender",
                              style: TextStyle(color: AppColors.ratingGrey),
                            ),
                            Text(capitalize(userDetailProvider.userDetails.gender ?? ""),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Divider(),
                            SizedBox(height: 10),
                            Text(
                              "Date of Birth",
                              style: TextStyle(color: AppColors.ratingGrey),
                            ),
                            Text(
                                formatIsoDate(
                                    userDetailProvider.userDetails.dob ?? ""),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Divider(),
                            SizedBox(height: 10),
                            Text(
                              "Address",
                              style: TextStyle(color: AppColors.ratingGrey),
                            ),
                            Text(userDetailProvider.userDetails.address ?? "",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Divider(),
                            SizedBox(height: 10),
                            Text(
                              "District",
                              style: TextStyle(color: AppColors.ratingGrey),
                            ),
                            Text(userDetailProvider.userDetails.district ?? "",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Divider(),
                            SizedBox(height: 10),
                            Text(
                              "State",
                              style: TextStyle(color: AppColors.ratingGrey),
                            ),
                            Text(userDetailProvider.userDetails.state ?? "",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Divider(),
                            SizedBox(height: 10),
                            Text(
                              "Country",
                              style: TextStyle(color: AppColors.ratingGrey),
                            ),
                            Text(userDetailProvider.userDetails.country ?? "",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Divider(),
                            SizedBox(height: 10),
                            CustomButton(
                              text: "Update Password",
                              color: AppColors.primaryOrange,
                              textcolor: AppColors.white,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NewPasswordScreen()));
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CustomButton(
                              text: "Logout",
                              color: AppColors.primaryBlue,
                              textcolor: AppColors.white,
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
    );
  }
}
