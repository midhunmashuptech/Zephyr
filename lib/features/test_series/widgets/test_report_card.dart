import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';
import 'package:zephyr/constants/app_constants.dart';

class TestReportCard extends StatelessWidget {
  final String title;
  final String date;
  final String duration;
  final String questionno;
  final bool isPassed;

  const TestReportCard(
      {super.key,
      required this.title,
      required this.date,
      required this.duration,
      required this.questionno,
      required this.isPassed
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryBlue),
      child: Column(
        children: [
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Iconify(
                  MaterialSymbols.design_services,
                  color: AppColors.white,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          SizedBox(height: 5),
          Divider(),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Duration: $duration",
                        style: TextStyle(color: AppColors.white)),
                    Text("Total Questions: $questionno",
                        style: TextStyle(color: AppColors.white))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Date", style: TextStyle(color: AppColors.white)),
                    Text(date, style: TextStyle(color: AppColors.white))
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          isPassed?
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: AppColors.primaryGreen,
            ))
            :Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: const Color.fromARGB(255, 223, 52, 52),
            ),
            child:
             Center(
                child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: 
             
             isPassed?
              Text(
                "Passed",
                style: TextStyle(
                    color: AppColors.white, fontWeight: FontWeight.w600),
              )
              :Text(
                "Failed",
                style: TextStyle(
                    color: AppColors.white, fontWeight: FontWeight.w600),
              )
            )),
          ),
        ],
      ),
    );
  }
}
