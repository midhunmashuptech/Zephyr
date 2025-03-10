import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/live_class/screens/live_ongoing.dart';
import 'package:zephyr/features/live_class/screens/live_recording_screen.dart';
import 'package:zephyr/features/live_class/screens/live_upcoming.dart';

class LiveTabviewDetails extends StatefulWidget {
  const LiveTabviewDetails({super.key});

  @override
  State<LiveTabviewDetails> createState() => _LiveTabviewDetailsState();
}

class _LiveTabviewDetailsState extends State<LiveTabviewDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Live Classes',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          leading: const Icon(FluentIcons.live_20_filled),
          bottom: TabBar(
            controller: _tabController,
            labelColor: AppColors.primaryBlue,
            indicatorColor: AppColors.primaryBlue,
            tabs: const [
              Tab(text: 'Ongoing'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Recordings'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
           LiveOngoing(),
           LiveUpcoming(),
           LiveRecordingScreen()

           
          ],
        ),
      ),
    );
  }
}

