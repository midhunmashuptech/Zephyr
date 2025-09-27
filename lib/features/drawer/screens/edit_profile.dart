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
import 'package:zephyr/features/drawer/provider/edit_profile_provider.dart';
import 'package:zephyr/features/drawer/widgets/dropdown_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  UserDetailsProvider userDetailsProvider = UserDetailsProvider();
  EditProfileProvider editProfileProvider = EditProfileProvider();
  AuthProvider authProvider = AuthProvider();

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      editProfileProvider.uploadProfileImage(
          filePath: pickedFile.path, context: context);
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
    
    await editProvider.fetchUserDetailsBeforeEditing(context: context);

    await optionsProvider.fetchRegisrationDropdownOption();
    usernameController.text = loadProvider.userDetails.name ?? "";
    emailController.text = loadProvider.userDetails.email ?? "";
    mobileController.text = loadProvider.userDetails.phone ?? "";
    schoolController.text = loadProvider.userDetails.school ?? "";
    addressController.text = loadProvider.userDetails.address ?? "";
    countryController.text = loadProvider.userDetails.country ?? "";
    stateController.text = loadProvider.userDetails.state ?? "";
    districtController.text = loadProvider.userDetails.district ?? "";
    secondaryMobileController.text =
        loadProvider.userDetails.secondaryPhone ?? "";
    dobController.text = formatIsoDate(loadProvider.userDetails.dob ?? "");
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
      editProvider.radiocheck(null);
    }

    editProvider.loadingFalse();
    debugPrint("false");
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String label,
      IconData? icon,
      bool readOnly = false,
      TextInputType? keyboardType,
      String? hintText,
      Widget? suffixIcon,
      int maxLines = 1,
      Color? fillColor,
      bool enabled = true,
      String? errorText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        maxLines: maxLines,
        enabled: enabled,
        style: TextStyle(
          color: enabled ? Colors.black : AppColors.grey,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: icon != null ? Icon(icon, color: AppColors.black) : null,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: fillColor ?? AppColors.lightGrey.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: AppColors.grey,
              width: 1.2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: AppColors.grey,
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: AppColors.black,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
          errorText: errorText,
          errorMaxLines: 2,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, bottom: 6.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    userDetailsProvider = context.watch<UserDetailsProvider>();
    editProfileProvider = context.watch<EditProfileProvider>();
    authProvider = context.watch<AuthProvider>();

    return Scaffold(
      // backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: AppColors.background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Edit Profile",
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: editProfileProvider.isDataLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withOpacity(0.2),
                                  blurRadius: 5,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: AppColors.white,
                              child: editProfileProvider.isProfilePictureLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : ClipOval(
                                      child: CachedNetworkImage(
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover,
                                        imageUrl: userDetailsProvider
                                                .userDetails.image ??
                                            "",
                                        placeholder: (context, url) =>
                                            Container(
                                          color: AppColors.lightGrey,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.person,
                                                size: 60,
                                                color: AppColors.grey),
                                      ),
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 4,
                            child: GestureDetector(
                              onTap: pickImage,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryOrange,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.white, width: 2),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.edit,
                                    color: AppColors.white, size: 22),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Personal Information"),
                          _buildTextField(
                            controller: usernameController,
                            label: "Name",
                            icon: Icons.person,
                          ),
                          _buildTextField(
                            controller: emailController,
                            label: "Email",
                            icon: Icons.email,
                          ),
                          _buildTextField(
                            controller: schoolController,
                            label: "School Name",
                            icon: Icons.school,
                          ),
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
                                  dobController.text = DateFormat('yyyy-MM-dd')
                                      .format(pickedDate);
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: _buildTextField(
                                controller: dobController,
                                label: "Date of Birth",
                                icon: Icons.cake,
                                suffixIcon: Icon(Icons.calendar_month,
                                    color: AppColors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Gender:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: "male",
                                      groupValue:
                                          editProfileProvider.checkedOption,
                                      activeColor: AppColors.black,
                                      onChanged: (value) {
                                        editProfileProvider.radiocheck(value);
                                      },
                                    ),
                                    Text("Male"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: "female",
                                      groupValue:
                                          editProfileProvider.checkedOption,
                                      activeColor: AppColors.black,
                                      onChanged: (value) {
                                        editProfileProvider.radiocheck(value);
                                      },
                                    ),
                                    Text("Female"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          _buildSectionTitle("Academic Details"),
                          DropdownWidget(
                            label: 'Syllabus',
                            items: authProvider.syllabusDropdownOptions
                                .map((item) => item.title ?? "Syllabus Option")
                                .toList(),
                            controller: syllabusController,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownWidget(
                            label: 'Class Studying',
                            items: authProvider.classDropdownOptions
                                .map((item) => item.title ?? "Class Option")
                                .toList(),
                            controller: classController,
                          ),
                          _buildSectionTitle("Contact Information"),
                          _buildTextField(
                            controller: addressController,
                            label: "Address",
                            icon: Icons.location_on,
                            maxLines: 2,
                          ),
                          _buildTextField(
                            controller: countryController,
                            label: "Country",
                            icon: Icons.flag,
                          ),
                          _buildTextField(
                            controller: stateController,
                            label: "State",
                            icon: Icons.map,
                          ),
                          _buildTextField(
                            controller: districtController,
                            label: "District",
                            icon: Icons.location_city,
                          ),
                          _buildTextField(
                            controller: secondaryMobileController,
                            label: "Secondary Phone",
                            icon: Icons.phone_android,
                            keyboardType: TextInputType.number,
                          ),
                          _buildTextField(
                            controller: mobileController,
                            label: "Mobile Number",
                            icon: Icons.phone,
                            readOnly: true,
                            enabled: false,
                            errorText:
                                "Disclaimer: For mobile number changes, kindly contact our support team.",
                          ),
                          SizedBox(height: 24),
                          editProfileProvider.isUpdating
                              ? Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  text: "Update",
                                  onPressed: () {
                                    editProfileProvider.updateDetails(
                                        context: context,
                                        name: usernameController.text,
                                        email: emailController.text,
                                        gender:
                                            editProfileProvider.checkedOption ??
                                                "",
                                        dob: dobController.text,
                                        school: schoolController.text,
                                        classStudying:
                                            authProvider.classDropdownOptions
                                                .firstWhere(
                                                  (classes) =>
                                                      classes.title ==
                                                      classController.text,
                                                  orElse: () =>
                                                      ClassStudying(id: 0),
                                                )
                                                .id
                                                .toString(),
                                        syllabusId:
                                            authProvider.syllabusDropdownOptions
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
                                        secondaryPhone:
                                            secondaryMobileController.text);
                                    editProfileProvider.setUpdatedProfile(
                                        usernameController.text,
                                        emailController.text);
                                  },
                                  color: AppColors.primaryOrange,
                                  textcolor: AppColors.white,
                                ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
      ),
    );
  }
}
