import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/features/notification/provider/notification_provider.dart';
import 'package:zephyr/features/notification/widgets/notification_card.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  NotificationProvider notificationProvider = NotificationProvider();
  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    final loadProvider = context.read<NotificationProvider>();
    await loadProvider.fetchNotifications(context: context);
  }

  String formatDateLabel(String dateTimeString) {
    final DateTime inputDate = DateTime.parse(dateTimeString).toLocal();
    final DateTime now = DateTime.now();

    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime tomorrow = today.add(const Duration(days: 1));
    final DateTime yesterday = today.subtract(const Duration(days: 1));

    final DateTime inputDay =
        DateTime(inputDate.year, inputDate.month, inputDate.day);

    String formattedDate = DateFormat("d MMMM yyyy").format(inputDate);

    if (inputDay == today) {
      return "Today, $formattedDate";
    } else if (inputDay == tomorrow) {
      return "Tomorrow, $formattedDate";
    } else if (inputDay == yesterday) {
      return "Yesterday, $formattedDate";
    } else {
      return formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final notificationProvider = context.watch<NotificationProvider>();
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  BackButton(),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Notifications",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                  ),
                ],
              ),
              notificationProvider.isNotificationsLoading
              ? Center(child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ))
              : notificationProvider.notificationsList.isEmpty
              ? Center(
                          child: Column(
                            children: [
                              Lottie.asset("assets/lottie/nodata.json",
                                  height: 200),
                              SizedBox(
                                height: 10,
                              ),
                              Text("No New Notifications!")
                            ],
                          ),
                        )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (contex, _) => SizedBox(height: 5),
                  itemCount: notificationProvider.notificationsList.length,
                  itemBuilder: (contex, index) => NotificationCard(
                      heading:
                          notificationProvider.notificationsList[index].title ??
                              "",
                      subheading: notificationProvider
                              .notificationsList[index].message ??
                          "",
                      image:
                          notificationProvider.notificationsList[index].image ??
                              "",
                      time: formatDateLabel(notificationProvider
                              .notificationsList[index].createdAt ??
                          "")
                          )),
            ],
          ),
        ),
      )),
    );
  }
}
