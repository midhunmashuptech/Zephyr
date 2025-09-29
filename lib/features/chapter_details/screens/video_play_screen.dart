import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/chapter_details/provider/enrolled_chapter_details_provider.dart'
    show EnrolledChapterDetailsProvider;
import 'package:zephyr/features/chapter_details/widgets/chapter_video_card.dart';
import 'package:zephyr/features/chapter_details/widgets/comments_listing_screen.dart';

class VideoPlayScreen extends StatefulWidget {
  const VideoPlayScreen({super.key});

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen>
    with SingleTickerProviderStateMixin {
  EnrolledChapterDetailsProvider enrolledChapterDetailsProvider =
      EnrolledChapterDetailsProvider();

  late TabController _tabController;

  BetterPlayerController? betterPlayerController;

  YoutubePlayerController? youtubeController;

  int selectedIndex = 0;
  
  bool _isDisposing = false;
  bool _isInitializing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializePlayer(); // load first video after build
    });
  }

  /// Initializes the appropriate player based on the video source
  Future<void> initializePlayer() async {
    if (_isInitializing || _isDisposing) return;
    
    _isInitializing = true;
    
    final chapterVideoProvider = context.read<EnrolledChapterDetailsProvider>();
    final currentVideo = chapterVideoProvider.currentlyPlayingVideo;

    // Dispose old players before initializing new ones
    await disposePlayers();

    // Add a small delay to ensure disposal is complete
    await Future.delayed(const Duration(milliseconds: 100));

    if (!mounted) {
      _isInitializing = false;
      return;
    }

    try {
      if (currentVideo.source?.toLowerCase() == "youtube") {
        final videoId =
            YoutubePlayer.convertUrlToId(currentVideo.hls ?? "") ?? "";
        youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
              autoPlay: true, mute: false, controlsVisibleAtStart: true),
        );
      } else {
        // Create BetterPlayer with proper configuration
        betterPlayerController = BetterPlayerController(
          const BetterPlayerConfiguration(
            autoPlay: true,
            looping: false,
            aspectRatio: 16 / 9,
            fullScreenAspectRatio: 16 / 9,
            allowedScreenSleep: false,
            fit: BoxFit.contain,
            autoDispose: false, // Set to false to control disposal manually
            handleLifecycle: true,
            controlsConfiguration: BetterPlayerControlsConfiguration(
              enablePlayPause: true,
              enableMute: true,
              enableFullscreen: true,
              enableProgressBar: true,
              enableSkips: false,
            ),
          ),
          betterPlayerDataSource: BetterPlayerDataSource(
            BetterPlayerDataSourceType.network,
            currentVideo.hls ?? "",
            notificationConfiguration: BetterPlayerNotificationConfiguration(
              showNotification: false,
            ),
          ),
        );
      }
      
      _isInitializing = false;
      
      // Force rebuild after controller is created
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint("Error initializing player: $e");
      _isInitializing = false;
    }
  }

  /// Handles changing the video when user selects a new one
  Future<void> changeVideo(int index) async {
    // Prevent changing to the same video
    if (selectedIndex == index) {
      debugPrint("Video already selected, skipping change");
      return;
    }
    
    // Prevent multiple simultaneous changes
    if (_isDisposing || _isInitializing) {
      debugPrint("Player busy, skipping video change");
      return;
    }

    final chapterVideoProvider = context.read<EnrolledChapterDetailsProvider>();
    
    // Update the selected video in provider
    chapterVideoProvider.changePlayingVideo(index);
    
    if (mounted) {
      setState(() {
        selectedIndex = index;
      });
    }
    
    // Initialize new player (which will dispose old ones first)
    await initializePlayer();
  }

  /// Dispose both players to avoid memory leaks
  Future<void> disposePlayers() async {
    if (_isDisposing) return;
    
    _isDisposing = true;

    try {
      // Dispose BetterPlayer
      if (betterPlayerController != null) {
        final controller = betterPlayerController;
        betterPlayerController = null; // Set to null immediately
        
        try {
          // Check if controller is still valid before operations
          if (controller?.isVideoInitialized() == true) {
            await controller?.pause();
          }
          
          // Dispose without waiting for async operations
          controller?.dispose(forceDispose: true);
          
        } catch (e) {
          debugPrint("Error disposing BetterPlayer: $e");
        }
      }

      // Dispose YouTube player
      if (youtubeController != null) {
        final controller = youtubeController;
        youtubeController = null; // Set to null immediately
        
        try {
          if (controller?.value.isReady == true) {
            controller?.pause();
          }
          controller?.dispose();
        } catch (e) {
          debugPrint("Error disposing YouTubePlayer: $e");
        }
      }
      
      // Small delay to ensure disposal completes
      await Future.delayed(const Duration(milliseconds: 100));
      
    } catch (e) {
      debugPrint("Error in disposePlayers: $e");
    } finally {
      _isDisposing = false;
    }
  }

  @override
  void dispose() {
    // Dispose tab controller first
    _tabController.dispose();
    
    // Force synchronous disposal of players
    try {
      betterPlayerController?.dispose(forceDispose: true);
    } catch (e) {
      debugPrint("Error in BetterPlayer dispose: $e");
    }
    
    try {
      youtubeController?.dispose();
    } catch (e) {
      debugPrint("Error in YouTube dispose: $e");
    }
    
    betterPlayerController = null;
    youtubeController = null;
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    enrolledChapterDetailsProvider =
        context.watch<EnrolledChapterDetailsProvider>();
    return WillPopScope(
      onWillPop: () async {
        // if device is in landscape, switch back to portrait instead of popping
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          await SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return false; // don't exit page yet
        }
        return true; // allow exit in portrait
      },
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
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: _buildVideoPlayer(),
                ),

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
                    tabs: const [
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
                      const CommentsListingScreen(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Builds the appropriate video player widget without disposing/recreating controllers
  Widget _buildVideoPlayer() {
    // Show loading while initializing or disposing
    if (_isInitializing || _isDisposing) {
      return Container(
        color: Colors.black,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (enrolledChapterDetailsProvider.currentlyPlayingVideo.source?.toLowerCase() == "youtube") {
      return youtubeController != null
          ? YoutubePlayer(
              controller: youtubeController!,
              showVideoProgressIndicator: true,
            )
          : Container(
              color: Colors.black,
              child: const Center(child: CircularProgressIndicator()),
            );
    } else {
      return betterPlayerController != null
          ? BetterPlayer(controller: betterPlayerController!)
          : Container(
              color: Colors.black,
              child: const Center(child: CircularProgressIndicator()),
            );
    }
  }

  Widget videosListingTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: List.generate(
            enrolledChapterDetailsProvider.chapterVideos.length,
            (index) {
              final video = enrolledChapterDetailsProvider.chapterVideos[index];
              final isCurrentlySelected = enrolledChapterDetailsProvider
                      .currentlyPlayingVideo.batchVideoId ==
                  video.batchVideoId;

              return ChapterVideoCard(
                currentlySelected: isCurrentlySelected,
                // Only call changeVideo if not currently selected
                onPressed: isCurrentlySelected ? (){} : () => changeVideo(index),
                videoTitle: video.title ?? "Video Title",
                thumbnail: video.thumbnail ??
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8hrpymVlFVUacFKLqwlFVUacFKLqwlFhCNnu2hVBhAeXQ&usqp=CAU",
                videoUrl: video.hls ?? "",
                subtitle: "",
                duration: (video.duration ?? 0.0).toStringAsFixed(2),
                batchId: "${video.batchVideoId}",
              );
            },
          ),
        ),
      ),
    );
  }
}