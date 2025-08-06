import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bxs.dart';
import 'package:zephyr/constants/app_constants.dart';

class SelectedCouponCard extends StatelessWidget {
  final String offer;
  final void Function() onDelete;
  const SelectedCouponCard({super.key, required this.offer, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.lightBlue.withAlpha(30),
                border: Border.all(width: 2, color: AppColors.primaryBlue),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Iconify(
                          Bxs.offer,
                          color: AppColors.primaryOrange,
                        ),
                        SizedBox(width: 10),
                        Text(
                          offer,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Applied",
                        style: TextStyle(
                          color: AppColors.primaryGreen,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.check_circle_outline_rounded,
                        color: AppColors.primaryGreen,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: onDelete,
            icon: Icon(
              Icons.delete_rounded,
              color: AppColors.primaryRed,
            ))
      ],
    );
  }
}
