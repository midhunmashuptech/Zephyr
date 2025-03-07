import 'package:flutter/material.dart';
import 'package:zephyr/features/live_class/widgets/live_class_card.dart' show LiveClassCard;

class LiveOngoing extends StatefulWidget {
  const LiveOngoing({super.key});

  @override
  State<LiveOngoing> createState() => _LiveOngoingState();
}

class _LiveOngoingState extends State<LiveOngoing> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LiveClassCard(
              className: "Foundation of class 10",    
              tutorName: "By Punit singh",
              date: "12/12/2021",
              duration: "10:00 AM - 11:00 AM",
              imageUrl: "assets/images/course_bg1.jpg",
              imageColor: Colors.blue,
            ),
          ],
        )
      ),
    );
  }
}