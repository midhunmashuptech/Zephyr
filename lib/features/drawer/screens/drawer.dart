import 'package:flutter/material.dart';
import 'package:zephyr/common/screens/error_screen.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';
import 'package:zephyr/features/drawer/screens/profile_screen.dart';
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
              SizedBox(height: 20,),
              Opacity(opacity: 0.2, child: Divider(color: AppColors.primaryBlue,)),
              SizedBox(height: 30,),
              // ListTile(
              //   title: Text("My Profile", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
              //   leading: Icon(Icons.person),
              //   onTap: () {
              //     Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //           builder: (context) => const ProfileScreen()));
              //   },
              // ),
              DrawerComponent(item: "My Proflie", icon: Icons.person, onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              }),
              DrawerComponent(item: "Timeline", icon: Icons.timeline),
              DrawerComponent(item: "Terms & Conditions", icon: Icons.badge),
              DrawerComponent(item: "Help & Support", icon: Icons.help),
              DrawerComponent(item: "About Us", icon: Icons.info),
              DrawerComponent(item: "Logout", icon: Icons.logout),
              DrawerComponent(item: "Delete Account", icon: Icons.delete, onTap: () {
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
