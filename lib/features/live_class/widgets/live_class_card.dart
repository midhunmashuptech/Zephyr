import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:zephyr/common/service/notification_service.dart';
import 'package:zephyr/constants/app_constants.dart';

class LiveClassCard extends StatelessWidget {
  final String className;
  final String tutorName;
  final String date;
  final String year;
  final String duration;
  final String imageUrl;
  final Color imageColor;
  final String currenttab;

  const LiveClassCard(
      {super.key,
      required this.className,
      required this.tutorName,
      required this.date,
      required this.year,
      required this.duration,
      required this.imageUrl,
      required this.imageColor,
      required this.currenttab});

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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.3 > 150
                        ? 150
                        : MediaQuery.of(context).size.width * 0.3,
                    width: MediaQuery.of(context).size.width * 0.4 > 200
                        ? 200
                        : MediaQuery.of(context).size.width * 0.4,
                    child: Image.asset(imageUrl, fit: BoxFit.cover),
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
              const SizedBox(width: 10),
              Expanded(
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                      " $date",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      " $year",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: AppColors.primaryOrange,
                                  size: 15,
                                ),
                                Text(
                                  " $duration",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.black,
                                  ),
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
                          Column(
                            children: [
                              // IconButton(
                              //     onPressed: () {
                              //       NotificationService().showNotification(
                              //           title: "Title", body: "Body");
                              //     },
                              //     icon: Icon(
                              //       Icons.alarm,
                              //       color: AppColors.primaryOrange,
                              //     )),
                              IconButton(
                                  onPressed: () {
                                    NotificationService().scheduleNotification(
                                        title: "Live Class Reminder",
                                        body: "Your Live Class will begin in 15 minutes. Get ready to make your learning brighter!",
                                        hour: 17,
                                        minute: 31);
                                  },
                                  icon: Icon(
                                    Icons.alarm,
                                    color: AppColors.primaryGreen,
                                  )),
                              // IconButton(
                              //     onPressed: () {
                              //       NotificationService()
                              //           .checkPendingNotifications();
                              //     },
                              //     icon: Icon(
                              //       Icons.alarm,
                              //       color: AppColors.primaryBlue,
                              //     )),
                            ],
                          )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
