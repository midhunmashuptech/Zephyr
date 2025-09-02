import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:zephyr/common/screens/error_screen.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';
import 'package:zephyr/features/auth/login/screens/mobile_number_verification.dart';
import 'package:zephyr/features/drawer/screens/about_us.dart';
import 'package:zephyr/features/drawer/screens/edit_profile.dart';
import 'package:zephyr/features/drawer/screens/help_and_support.dart';
import 'package:zephyr/features/drawer/screens/terms_and_conditions.dart';
import 'package:zephyr/features/drawer/screens/timeline_screen.dart';
import 'package:zephyr/features/drawer/widgets/drawer_component.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Stack(
      children: [
        LayoutGradient(gradient: AppColors.blueGradient),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black
                              .withAlpha(50), // changed this - withOpacity(0.2)
                          blurRadius: 6,
                          spreadRadius: 2,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          radius: 40,
                          foregroundImage:
                              AssetImage("assets/images/kim_shin.webp"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Hello, Welcome", style: TextStyle(fontSize: 16)),
                      Text(
                        "Kim Shin",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              Opacity(
                  opacity: 0.2,
                  child: Divider(
                    color: AppColors.primaryBlue,
                  )),
              SizedBox(height: 30),
              DrawerComponent(
                  item: "Edit Proflie",
                  icon: Icons.edit,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfile()));
                  }),
              DrawerComponent(
                item: "Timeline",
                icon: Icons.timeline,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TimelineScreen()));
                },
              ),
              DrawerComponent(
                item: "Terms & Conditions",
                icon: Icons.badge,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsAndConditions()));
                },
              ),
              DrawerComponent(
                item: "Help & Support",
                icon: Icons.help,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HelpAndSupport()));
                },
              ),
              DrawerComponent(
                item: "About Us",
                icon: Icons.info,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUs()));
                },
              ),
              DrawerComponent(
                item: "Logout",
                icon: Icons.logout,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Are you sure?"),
                      content: Text(
                          "You will be signed out of your account. To continue, you’ll need to log in again."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            FlutterSecureStorage _secureStorage =
                                FlutterSecureStorage();
                            await _secureStorage.delete(key: "token");
                            Get.offAll(MobileNumberVerification());
                          },
                          child: Text("logout"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              DrawerComponent(
                  item: "Delete Account",
                  icon: Icons.delete,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ErrorScreen()));
                  }),
            ],
          ),
        ),
      ],
    ));
  }
}
