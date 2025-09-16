import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/live_class/model/upcoming_live_model.dart';
import 'package:zephyr/features/live_class/provider/live_provider.dart';
import 'package:zephyr/features/live_class/widgets/live_class_card.dart';

class LiveUpcoming extends StatefulWidget {
  const LiveUpcoming({super.key});

  @override
  State<LiveUpcoming> createState() => _LiveUpcomingState();
}

class _LiveUpcomingState extends State<LiveUpcoming> {
  LiveProvider liveProvider = LiveProvider();
  @override
  void initState() {
    loadUpcomingLiveClasses();
    super.initState();
  }

  Future<void> loadUpcomingLiveClasses() async {
    final loadUpcomingProvider = context.read<LiveProvider>();
    loadUpcomingProvider.fetchUpcomingLive(context: context);
  }

  @override
  Widget build(BuildContext context) {
    liveProvider = context.watch<LiveProvider>();
    return Scaffold(
      body: liveProvider.isUpcomingLoading
          ? Center(child: CircularProgressIndicator())
          : liveProvider.ongoingLive.isEmpty
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Column(
                    children: [
                      Lottie.asset("assets/lottie/nodata.json", height: 200),
                      Text("No Upcoming Live Classes"),
                    ],
                  ),
                ))
              : ListView.separated(
                  itemCount: liveProvider.upcomingLive.length,
                  separatorBuilder: (context, value) => SizedBox(
                        height: 5,
                      ),
                  itemBuilder: (context, index) => LiveClassCard(
                        className: liveProvider.upcomingLive[index].title ?? "",
                        tutorName: (liveProvider.upcomingLive[index].faculty ??
                                    Faculty(name: "Faculty Name"))
                                .name ??
                            "Faculty Name",
                        imageUrl: (liveProvider.upcomingLive[index].faculty ??
                                    Faculty(
                                        image:
                                            "https://blog.kapdec.com/hubfs/Imported_Blog_Media/3784896.jpg"))
                                .image ??
                            "https://blog.kapdec.com/hubfs/Imported_Blog_Media/3784896.jpg",
                        currenttab: "Upcoming",
                        startDate: liveProvider.upcomingLive[index].start ?? "",
                        enddate: liveProvider.upcomingLive[index].end ?? "",
                      )),
    );
  }
}
