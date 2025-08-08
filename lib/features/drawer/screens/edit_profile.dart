import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  @override
  void initState() {
    usernameController.text = "Nazriya Nazim";
    emailController.text = "nazriyanazim@gmail.com";
    mobileController.text = "9765433222";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Edit Profile"),
      ),
      body: SafeArea(
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
            SizedBox(height: 15,),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(hintText: "Enter user name"),
            ),
            SizedBox(height: 10),
            TextField(
              style: TextStyle(color: AppColors.grey),
              readOnly: true,
              controller: mobileController,
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: "Enter mobile number"),
            ),
            // SizedBox(height: 5),
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: "Enter email address"),
            ),
            SizedBox(height: 20),
            CustomButton(
              text: "Update",
              onPressed: (){},
              color: AppColors.primaryOrange,
              textcolor: AppColors.white,)
          ],
        ),
      )
      ),
    );
  }
}
