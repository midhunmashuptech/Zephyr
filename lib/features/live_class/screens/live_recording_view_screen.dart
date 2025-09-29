import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:zephyr/constants/app_constants.dart';

class LiveRecordingViewScreen extends StatefulWidget {
  final String videoName;
  final String videoUrl;
  final String source;
  const LiveRecordingViewScreen(
      {super.key,
      required this.videoName,
      required this.videoUrl,
      required this.source});

  @override
  State<LiveRecordingViewScreen> createState() =>
      _LiveRecordingViewScreenState();
}

class _LiveRecordingViewScreenState extends State<LiveRecordingViewScreen> {
  BetterPlayerController? betterPlayerController;
  YoutubePlayerController? youtubeController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  void initializePlayer() {
    if (widget.source.toLowerCase() == "youtube") {
      final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? "";
      youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          controlsVisibleAtStart: true,
        ),
      );
    } else {
      betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(
          autoPlay: true,
          looping: false,
          aspectRatio: 16 / 9,
          fullScreenAspectRatio: 16 / 9,
          allowedScreenSleep: false,
          fit: BoxFit.contain,
          autoDispose: false,
        ),
        betterPlayerDataSource: BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          widget.videoUrl,
        ),
      );
    }

    if (mounted) {
      setState(() {});
    }
  }

  void disposePlayers() {
    if (betterPlayerController != null) {
      betterPlayerController!.pause();
      betterPlayerController!.dispose();
      betterPlayerController = null;
    }
    if (youtubeController != null) {
      youtubeController!.pause();
      youtubeController!.dispose();
      youtubeController = null;
    }
  }

  @override
  void dispose() {
    disposePlayers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // If device is in landscape, switch back to portrait instead of popping
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          await SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return false; // Don't exit page yet
        }
        return true; // Allow exit in portrait
      },
      child: SafeArea(
        child: Scaffold(
          body: OrientationBuilder(
            builder: (context, orientation) {
              final isLandscape = orientation == Orientation.landscape;

              if (isLandscape) {
                // LANDSCAPE → only video player fullscreen
                return SizedBox.expand(
                  child: _buildVideoPlayer(),
                );
              }

              // PORTRAIT → video player + UI
              return Column(
                children: [
                  // Video Player
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: _buildVideoPlayer(),
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
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// Builds the appropriate video player widget based on source
  Widget _buildVideoPlayer() {
    if (widget.source.toLowerCase() == "youtube") {
      return youtubeController != null
          ? YoutubePlayer(
              controller: youtubeController!,
              showVideoProgressIndicator: true,
            )
          : const Center(child: CircularProgressIndicator());
    } else {
      return betterPlayerController != null
          ? BetterPlayer(controller: betterPlayerController!)
          : const Center(child: CircularProgressIndicator());
    }
  }
}
