import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/carbon.dart';
import 'package:zephyr/constants/app_constants.dart';

class StudyMaterialCard extends StatelessWidget {
  const StudyMaterialCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Card(
                color: AppColors.primaryRed,
                child: Iconify(Carbon.pdf),
              )
            ],
          ),
        ),
      ),
    );
  }
}