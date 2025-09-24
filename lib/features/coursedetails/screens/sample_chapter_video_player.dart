import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class SampleChapterVideoPlayer extends StatefulWidget {
  final String videoName;
  final String videoUrl;
  const SampleChapterVideoPlayer({super.key, required this.videoUrl, required this.videoName});

  @override
  State<SampleChapterVideoPlayer> createState() =>
      _SampleChapterVideoPlayerState();
}

class _SampleChapterVideoPlayerState extends State<SampleChapterVideoPlayer> {
  late BetterPlayerController betterPlayerController;

  @override
  void initState() {
    super.initState();
    initializePlayer(); // Load first video initially
  }

  void initializePlayer() {
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
        widget.videoUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                        widget.videoName,
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
          ],
        ),
      ),
    );
  }
}
