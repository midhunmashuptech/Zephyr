import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? selectedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          LayoutGradient(gradient: AppColors.orangeGradient),
          Column(
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
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: selectedImage == null
                          ? AssetImage("assets/images/kim_shin.webp")
                          : FileImage(selectedImage!),
                      radius: 80,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryOrange,
                        child: IconButton(
                          onPressed: () => pickImage(),
                          icon: Icon(Icons.edit),
                          color: AppColors.white,
                        ),
                      ),
                    )
                  ],
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
                      "Firstname",
                      style: TextStyle(color: AppColors.ratingGrey),
                    ),
                    Text("Kim",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    Divider(),
                    SizedBox(height: 10),
                    Text(
                      "Lastname",
                      style: TextStyle(color: AppColors.ratingGrey),
                    ),
                    Text("Shin",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    Divider(),
                    SizedBox(height: 10),
                    Text(
                      "Email Address",
                      style: TextStyle(color: AppColors.ratingGrey),
                    ),
                    Text("kimshin@gmail.com",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    Divider(),
                    SizedBox(height: 5),
                    Text(
                      "Mobile Number",
                      style: TextStyle(color: AppColors.ratingGrey),
                    ),
                    Text("9992226661",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: "Update Password",
                      color: AppColors.primaryOrange,
                      textcolor: AppColors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      text: "Logout",
                      color: AppColors.primaryBlue,
                      textcolor: AppColors.white,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
