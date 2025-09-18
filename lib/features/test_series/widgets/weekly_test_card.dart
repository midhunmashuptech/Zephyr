import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';
import 'package:zephyr/constants/app_constants.dart';

class WeeklyTestCard extends StatelessWidget {
  final String date;
  final String duration;
  final String questionno;

  const WeeklyTestCard({super.key, required this.date, required this.duration, required this.questionno});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryBlue),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Iconify(
                        MaterialSymbols.design_services,
                        color: AppColors.white,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Weekly Test Series 1",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Duration:",
                              style: TextStyle(color: AppColors.white)),
                          Text("Total Questions:",
                              style: TextStyle(color: AppColors.white))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Date",
                              style: TextStyle(color: AppColors.white)),
                          Text(date,
                              style: TextStyle(color: AppColors.white))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: AppColors.primaryGreen,
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Passed",
                  style: TextStyle(
                      color: AppColors.white, fontWeight: FontWeight.w600),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
