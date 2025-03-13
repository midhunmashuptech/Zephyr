import 'package:flutter/material.dart';
import 'package:zephyr/features/notification/widgets/notification_card.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Today",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                NotificationCard(heading: "Zenith Exam 2025", subheading: "Stay updated on eligibility, exam pattern, key dates, and preparation resources. Don't miss out—check the official website for details!.The exam typically covers areas such as mathematics, science, language skills, and analytical reasoning. Candidates are advised to consult the official Zenith Exam website or contact the examination authorities for detailed information on eligibility criteria, application procedures, exam patterns, and preparation materials.", image: "assets/images/zephyr.jpg",time: "Last Wednesday at 9:42 AM",),
                NotificationCard(heading: "Zenith Exam 2025", subheading: "Stay updated on eligibility, exam pattern, key dates, and preparation resources. Don't miss out—check the official website for details!.The exam typically covers areas such as mathematics, science, language skills, and analytical reasoning. Candidates are advised to consult the official Zenith Exam website or contact the examination authorities for detailed information on eligibility criteria, application procedures, exam patterns, and preparation materials.", image: "assets/images/zephyr.jpg",time: "Last Wednesday at 9:42 AM",),
                NotificationCard(heading: "Zenith Exam 2025", subheading: "Stay updated on eligibility, exam pattern, key dates, and preparation resources. Don't miss out—check the official website for details!.The exam typically covers areas such as mathematics, science, language skills, and analytical reasoning. Candidates are advised to consult the official Zenith Exam website or contact the examination authorities for detailed information on eligibility criteria, application procedures, exam patterns, and preparation materials.", image: "assets/images/zephyr.jpg",time: "Last Wednesday at 9:42 AM",),
                NotificationCard(heading: "Zenith Exam 2025", subheading: "Stay updated on eligibility, exam pattern, key dates, and preparation resources. Don't miss out—check the official website for details!.The exam typically covers areas such as mathematics, science, language skills, and analytical reasoning. Candidates are advised to consult the official Zenith Exam website or contact the examination authorities for detailed information on eligibility criteria, application procedures, exam patterns, and preparation materials.", image: "assets/images/zephyr.jpg",time: "Last Wednesday at 9:42 AM",),
                NotificationCard(heading: "Zenith Exam 2025", subheading: "Stay updated on eligibility, exam pattern, key dates, and preparation resources. Don't miss out—check the official website for details!.The exam typically covers areas such as mathematics, science, language skills, and analytical reasoning. Candidates are advised to consult the official Zenith Exam website or contact the examination authorities for detailed information on eligibility criteria, application procedures, exam patterns, and preparation materials.", image: "assets/images/zephyr.jpg",time: "Last Wednesday at 9:42 AM",),
                Text("Recent",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                NotificationCard(heading: "Zenith Exam 2025", subheading: "Stay updated on eligibility, exam pattern, key dates, and preparation resources. Don't miss out—check the official website for details!.The exam typically covers areas such as mathematics, science, language skills, and analytical reasoning. Candidates are advised to consult the official Zenith Exam website or contact the examination authorities for detailed information on eligibility criteria, application procedures, exam patterns, and preparation materials.", image: "assets/images/zephyr.jpg",time: "Last Wednesday at 9:42 AM",),
                NotificationCard(heading: "Zenith Exam 2025", subheading: "Stay updated on eligibility, exam pattern, key dates, and preparation resources. Don't miss out—check the official website for details!.The exam typically covers areas such as mathematics, science, language skills, and analytical reasoning. Candidates are advised to consult the official Zenith Exam website or contact the examination authorities for detailed information on eligibility criteria, application procedures, exam patterns, and preparation materials.", image: "assets/images/zephyr.jpg",time: "Last Wednesday at 9:42 AM",),
                NotificationCard(heading: "Zenith Exam 2025", subheading: "Stay updated on eligibility, exam pattern, key dates, and preparation resources. Don't miss out—check the official website for details!.The exam typically covers areas such as mathematics, science, language skills, and analytical reasoning. Candidates are advised to consult the official Zenith Exam website or contact the examination authorities for detailed information on eligibility criteria, application procedures, exam patterns, and preparation materials.", image: "assets/images/zephyr.jpg",time: "Last Wednesday at 9:42 AM",)
              ],
            ),
          )
        ),
      ),
    );
  }
}