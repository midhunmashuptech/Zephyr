import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zephyr/features/live_class/model/ongoing_live_model.dart';
import 'package:zephyr/features/live_class/provider/live_provider.dart';
import 'package:zephyr/features/live_class/widgets/live_class_card.dart';
import 'package:zephyr/features/live_class/widgets/live_class_card_with_thumbnail.dart';

class LiveOngoing extends StatefulWidget {
  const LiveOngoing({super.key});

  @override
  State<LiveOngoing> createState() => _LiveOngoingState();
}

class _LiveOngoingState extends State<LiveOngoing> {
  LiveProvider liveProvider = LiveProvider();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadOngoingLiveClass();
    });

    super.initState();
  }

  Future<void> loadOngoingLiveClass() async {
    final loadProvider = context.read<LiveProvider>();
    await loadProvider.fetchOngoingLive(context: context);
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    liveProvider = context.watch<LiveProvider>();
    return Scaffold(
      body: liveProvider.isOngoingLoading
          ? Center(child: CircularProgressIndicator())
          : liveProvider.ongoingLive.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/lottie/nodata.json", height: 200),
                      Text("No Ongoing Live Classes"),
                      SizedBox(height: 10),
                    ],
                  ),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                        height: 5,
                      ),
                  itemCount: liveProvider.ongoingLive.length,
                  itemBuilder: (context, index) => liveProvider
                              .ongoingLive[index].isFeatured ==
                          1
                      ? GestureDetector(
                          onTap: () {
                            debugPrint("Launching Live Class: liveProvider.ongoingLive[index].url");
                            _launchInBrowser(Uri.parse(
                                liveProvider.ongoingLive[index].url ?? ""));
                          },
                          child: LiveClassCardWithThumbnail(
                            className: liveProvider.ongoingLive[index].title ??
                                "Class Name",
                            tutorName:
                                (liveProvider.ongoingLive[index].faculty ??
                                            Faculty(name: "Faculty Name"))
                                        .name ??
                                    "Faculty Name",
                            startDate:
                                liveProvider.ongoingLive[index].start ?? "",
                            enddate: liveProvider.ongoingLive[index].end ?? "",
                            imageUrl: liveProvider
                                    .ongoingLive[index].thumbnail ??
                                "https://blog.kapdec.com/hubfs/Imported_Blog_Media/3784896.jpg",
                            currenttab: "Ongoing",
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            debugPrint("Launching Live Class: liveProvider.ongoingLive[index].url");
                            _launchInBrowser(Uri.parse(
                                liveProvider.ongoingLive[index].url ?? ""));
                          },
                        child: LiveClassCard(
                            className: liveProvider.ongoingLive[index].title ??
                                "Class Name",
                            tutorName: (liveProvider.ongoingLive[index].faculty ??
                                        Faculty(name: "Faculty Name"))
                                    .name ??
                                "Faculty Name",
                            startDate:
                                liveProvider.ongoingLive[index].start ?? "",
                            enddate: liveProvider.ongoingLive[index].end ?? "",
                            imageUrl: (liveProvider.ongoingLive[index].faculty ??
                                        Faculty(
                                            image:
                                                "https://blog.kapdec.com/hubfs/Imported_Blog_Media/3784896.jpg"))
                                    .image ??
                                "https://blog.kapdec.com/hubfs/Imported_Blog_Media/3784896.jpg",
                            currenttab: "Ongoing",
                          ),
                      )),
    );
  }
}
