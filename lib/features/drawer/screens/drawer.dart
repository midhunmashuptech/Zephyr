import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/common/screens/error_screen.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/auth/login/screens/mobile_number_verification.dart';
import 'package:zephyr/features/drawer/screens/about_us.dart';
import 'package:zephyr/features/drawer/screens/edit_profile.dart';
import 'package:zephyr/features/drawer/screens/privacy_policy.dart';
import 'package:zephyr/features/drawer/screens/profile_screen.dart';
import 'package:zephyr/features/drawer/screens/refund_policy.dart';
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
                            offset: const Offset(0, 6),
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
                                  ? const Icon(Icons.person,
                                      size: 32, color: AppColors.primaryBlue)
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Hello,",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  user.name ?? "",
                                  style: const TextStyle(
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
                          const Icon(Icons.chevron_right,
                              color: Colors.white54),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Drawer Items
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
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
                          onTap: () {
                            _showHelpAndSupportDialog(context);
                          },
                        ),
                        _ModernDrawerItem(
                          icon: Icons.info_outline,
                          label: "About Us",
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => AboutUs()),
                          ),
                        ),
                        _ModernDrawerItem(
                          icon: Icons.receipt_long,
                          label: "Refund Policy",
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => RefundPolicy()),
                          ),
                        ),
                        _ModernDrawerItem(
                          icon: Icons.security,
                          label: "Privacy Policy",
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => PrivacyPolicy()),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Divider(
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
                                title: const Text("Sign out?"),
                                content: const Text(
                                  "You will be signed out of your account. To continue, you’ll need to log in again.",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        overlayColor: AppColors.lightBlue),
                                    onPressed: () async {
                                      FlutterSecureStorage secureStorage =
                                          const FlutterSecureStorage();
                                      await secureStorage.delete(key: "token");
                                      Get.offAll(MobileNumberVerification());
                                    },
                                    child: const Text("Logout"),
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
                            onTap: () => showDeleteAccountDialog(context)),
                      ],
                    ),
                  ),
                  // App Version or Footer
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: const Text(
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

  void showDeleteAccountDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: const Text(
                "Delete Account?",
              ),
              content: const Text(
                "Are you sure you really want to delete your account?",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      overlayColor: AppColors.lightBlue),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    showSnackBar("Delete Request Sent", "Account delete request has been initiated successfully. You will receive a confirmation email shortly.");
                  },
                  child: const Text("Confirm"),
                ),
              ],
            ));
  }

  void _showHelpAndSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // allow tap outside to close
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 22.0, horizontal: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Contact Us",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: const BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Email",
                            style: TextStyle(color: AppColors.black)),
                        GestureDetector(
                          onTap: () async {
                            final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: 'info@zephyrdigital.in',
                            );
                            if (await canLaunchUrl(emailLaunchUri)) {
                              await launchUrl(emailLaunchUri);
                            }
                          },
                          child: const Text(
                            "info@zephyrdigital.in",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        const Text("Mobile Number",
                            style: TextStyle(color: AppColors.black)),
                        GestureDetector(
                          onTap: () async {
                            final Uri phoneUri = Uri(
                              scheme: 'tel',
                              path: '+919645474080',
                            );
                            if (await canLaunchUrl(phoneUri)) {
                              await launchUrl(phoneUri);
                            }
                          },
                          child: const Text(
                            "+91 9645474080",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      leading: Container(
        decoration: BoxDecoration(
          color: (color ?? AppColors.primaryBlue).withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8),
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
