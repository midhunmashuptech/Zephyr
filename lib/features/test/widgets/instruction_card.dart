import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:zephyr/constants/app_constants.dart';

class InstructionCard extends StatelessWidget {
  final String instext;
  final String instsubtext;
  final String icon;
  final Color bgcolor;

  const InstructionCard(
      {super.key,
      required this.instext,
      required this.icon,
      required this.bgcolor,
      required this.instsubtext
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.16 > 40
                  ? 40
                  : MediaQuery.of(context).size.width * 0.16,
              height: MediaQuery.of(context).size.width * 0.16 > 40
                  ? 40
                  : MediaQuery.of(context).size.width * 0.16,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(MediaQuery.of(context).size.width),
                color: bgcolor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Iconify(
                  icon,
                  size: 5,
                  color: AppColors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    instext,
                    style: TextStyle(
                        height: 1.3, fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  Text(
                instsubtext,
                style: TextStyle(
                    height: 1.3, fontSize: 13, fontWeight: FontWeight.w400,),
              ),
                ],
              ),
            ),
             
          ],
        ),
      ),
    );
  }
}
