import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zephyr/common/service/notification_service.dart';
import 'package:zephyr/constants/app_constants.dart';

class LiveClassCard extends StatelessWidget {
  final String className;
  final String tutorName;
  final String startDate;
  final String enddate;
  final String imageUrl;
  final Color imageColor;
  final String currenttab;

  const LiveClassCard(
      {super.key,
      required this.className,
      required this.tutorName,
      required this.startDate,
      required this.enddate,
      required this.imageUrl,
      required this.imageColor,
      required this.currenttab});

  String formatDate(String isoString) {
    DateTime dateTime = DateTime.parse(isoString);
    return DateFormat('MMM d').format(dateTime);
  }

  String formatYear(String isoString) {
    DateTime dateTime = DateTime.parse(isoString);
    return DateFormat('yyyy').format(dateTime);
  }

String formatTimeRange(String startIso, String endIso) {
  DateTime start = DateTime.parse(startIso);
  DateTime end = DateTime.parse(endIso);

  String startTime = DateFormat('hh:mm a').format(start).toUpperCase();
  String endTime = DateFormat('hh:mm a').format(end).toUpperCase();

  return "$startTime - $endTime";
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: Card(
        color: AppColors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(12),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35 > 200
                          ? 200
                          : MediaQuery.of(context).size.width * 0.35,
                      height: double.infinity,
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppColors.black,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (currenttab == "Ongoing")
                      Positioned(
                        bottom: 15,
                        left: 15,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(FluentIcons.live_20_filled,
                                  color: AppColors.primaryRed),
                              const SizedBox(width: 5),
                              const Text("Live class",
                                  style: TextStyle(
                                      color: AppColors.white, fontSize: 16)),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
                // const SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              className,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "by $tutorName",
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color: AppColors.primaryOrange,
                                      size: 15,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          " $startDate",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          " $enddate",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                if (currenttab == "Recordings")
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.download,
                                        color: AppColors.primaryBlue,
                                      ))
                                else if (currenttab == "Upcoming")
                                  IconButton(
                                      onPressed: () {
                                        NotificationService()
                                            .scheduleNotificationInMinutes(
                                                title: "Live Class Reminder",
                                                body:
                                                    "Your Live Class will begin in 15 minutes. Get ready to make your learning brighter!",
                                                // hour: 13,
                                                // minute: 6
                                                minutesFromNow: 3);
                                      },
                                      icon: Icon(
                                        Icons.alarm,
                                        color: AppColors.primaryGreen,
                                      ))
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: AppColors.primaryOrange,
                                  size: 15,
                                ),
                                // Text(
                                //   " $duration",
                                //   style: const TextStyle(
                                //     fontSize: 14,
                                //     color: AppColors.black,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
