import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/chapter_details/widgets/chapter_video_card.dart';
import 'package:zephyr/features/chapter_details/widgets/comments_listing_screen.dart';

class VideoPlayScreen extends StatefulWidget {
  const VideoPlayScreen({super.key});

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  late TabController _tabController;
  late BetterPlayerController betterPlayerController;
  int selectedIndex = 0; // Track selected video index

  final List<String> videoUrls = [
    "https://media.istockphoto.com/id/1854905414/video/speed-ramp-male-player-in-red-outfit-outplaying-his-opponents-in-a-football-game.mp4?s=mp4-640x640-is&k=20&c=lFRmcGTDZxlqP6cBnJguufewDafJXljQscbPwVRcHuQ=",
    "https://cdn.pixabay.com/video/2020/06/17/42420-431511648_large.mp4",
    "https://d3sigpa2r6yn5i.cloudfront.net/transcoded/85DRa92D54G/video.m3u8",
    // "https://d3sigpa2r6yn5i.cloudfront.net/transcoded/9SkEnE92d42/video.m3u8",
    // "https://player.vimeo.com/external/931461126.m3u8?s=8d81b0a23217e40cc7904c52db9c607be07691c5&logging=false"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    initializePlayer(videoUrls[0]); // Load first video initially
  }

  void initializePlayer(String url) {
    betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        looping: false,
        aspectRatio: 16 / 9,
        fullScreenAspectRatio: 16 / 9, // Ensure proper fullscreen aspect ratio
        allowedScreenSleep: false, // Prevents screen from sleeping
      ),
      betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        url,
      ),
    );

    setState(() {
      isLoading = false;
    });
  }

  void changeVideo(String url, int index) {
    betterPlayerController.setupDataSource(BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      url,
    ));

    setState(() {
      selectedIndex = index; // Update selected video index
    });
  }

  @override
  void dispose() {
    betterPlayerController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  // Video Player
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: BetterPlayer(controller: betterPlayerController),
                  ),

                  // Video Title Bar
                  Container(
                    color: AppColors.lightOrange,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              "Foundation of Mathematics",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.bookmark_add_rounded),
                        )
                      ],
                    ),
                  ),

                  // Tab Bar
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TabBar(
                      labelColor: AppColors.primaryBlue,
                      indicatorColor: AppColors.primaryOrange,
                      controller: _tabController,
                      tabs: [
                        Text("Videos"),
                        Text("Comments"),
                      ],
                    ),
                  ),

                  // Tab Views
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        videosListingTab(),
                        CommentsListingScreen(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget videosListingTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: List.generate(videoUrls.length, (index) {
            return ChapterVideoCard(
              currentlySelected: selectedIndex == index,
              onPressed: () => changeVideo(videoUrls[index], index),
            );
          }),
        ),
      ),
    );
  }
}
