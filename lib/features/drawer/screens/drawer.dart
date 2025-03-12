import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/drawer/widgets/drawer_component.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            DrawerComponent(item: "Your Proflie", icon: Icons.person, color: AppColors.primaryBlue,),
            DrawerComponent(item: "Timeline", icon: Icons.timeline, color: AppColors.primaryOrange,),
            DrawerComponent(item: "Settings", icon: Icons.settings, color: AppColors.primaryGreen,),
            DrawerComponent(item: "Logout", icon: Icons.logout, color: AppColors.primaryRed,),
          ],
        ),
      )
    );
  }
}