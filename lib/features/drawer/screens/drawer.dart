import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/common/screens/error_screen.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';
import 'package:zephyr/features/auth/login/screens/mobile_number_verification.dart';
import 'package:zephyr/features/drawer/screens/about_us.dart';
import 'package:zephyr/features/drawer/screens/edit_profile.dart';
import 'package:zephyr/features/drawer/screens/help_and_support.dart';
import 'package:zephyr/features/drawer/screens/profile_screen.dart';
import 'package:zephyr/features/drawer/screens/terms_and_conditions.dart';
import 'package:zephyr/features/drawer/screens/timeline_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetailsProvider = context.watch<UserDetailsProvider>();
    final user = userDetailsProvider.userDetails;

    return Drawer(
      child: Stack(
        children: [
          // LayoutGradient(
          //   gradient: LinearGradient(
          //     colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //   ),
          // ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
              child: Column(
                children: [
                  // User Profile Section
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ProfileScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  user.image != null && user.image!.isNotEmpty
                                      ? CachedNetworkImageProvider(user.image!)
                                      : null,
                              child: user.image == null || user.image!.isEmpty
                                  ? Icon(Icons.person,
                                      size: 32, color: AppColors.primaryBlue)
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello,",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  user.name ?? "",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    letterSpacing: 0.5,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right, color: Colors.white54),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Drawer Items
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        _ModernDrawerItem(
                          icon: Icons.edit,
                          label: "Edit Profile",
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const EditProfile()),
                          ),
                        ),
                        _ModernDrawerItem(
                          icon: Icons.timeline,
                          label: "Timeline",
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const TimelineScreen()),
                          ),
                        ),
                        _ModernDrawerItem(
                          icon: Icons.badge,
                          label: "Terms & Conditions",
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TermsAndConditions()),
                          ),
                        ),
                        _ModernDrawerItem(
                          icon: Icons.help_outline,
                          label: "Help & Support",
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => HelpAndSupport()),
                          ),
                        ),
                        _ModernDrawerItem(
                          icon: Icons.info_outline,
                          label: "About Us",
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => AboutUs()),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Divider(
                            color: Colors.white24,
                            thickness: 1,
                            indent: 8,
                            endIndent: 8),
                        const SizedBox(height: 12),
                        _ModernDrawerItem(
                          icon: Icons.logout,
                          label: "Logout",
                          color: Colors.redAccent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                title: Text("Sign out?"),
                                content: Text(
                                  "You will be signed out of your account. To continue, you’ll need to log in again.",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                    ),
                                    onPressed: () async {
                                      FlutterSecureStorage _secureStorage =
                                          FlutterSecureStorage();
                                      await _secureStorage.delete(key: "token");
                                      Get.offAll(MobileNumberVerification());
                                    },
                                    child: Text("Logout"),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        _ModernDrawerItem(
                          icon: Icons.delete_forever,
                          label: "Delete Account",
                          color: Colors.red,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ErrorScreen()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // App Version or Footer
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      "Zephyr v1.0.0",
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 13,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModernDrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _ModernDrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      leading: Container(
        decoration: BoxDecoration(
          color: (color ?? AppColors.primaryBlue).withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(8),
        child: Icon(icon, color: color ?? Colors.black, size: 24),
      ),
      title: Text(
        label,
        style: TextStyle(
          color: color ?? Colors.black87,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      hoverColor: Colors.white10,
      splashColor: AppColors.primaryBlue.withOpacity(0.08),
    );
  }
}
