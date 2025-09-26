// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import 'package:zephyr/constants/app_constants.dart';
// import 'package:zephyr/features/chapter_details/provider/enrolled_chapter_details_provider.dart'
//     show EnrolledChapterDetailsProvider;
// import 'package:zephyr/features/chapter_details/widgets/chapter_video_card.dart';
// import 'package:zephyr/features/chapter_details/widgets/comments_listing_screen.dart';

// class VideoPlayScreen extends StatefulWidget {
//   const VideoPlayScreen({super.key});

//   @override
//   State<VideoPlayScreen> createState() => _VideoPlayScreenState();
// }

// class _VideoPlayScreenState extends State<VideoPlayScreen>
//     with SingleTickerProviderStateMixin {
//   EnrolledChapterDetailsProvider enrolledChapterDetailsProvider =
//       EnrolledChapterDetailsProvider();

//   late TabController _tabController;

//   BetterPlayerController? betterPlayerController;

//   YoutubePlayerController? youtubeController;

//   int selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       initializePlayer(); // load first video after build
//     });
//   }

//   /// Initializes the appropriate player based on the video source
//   void initializePlayer() {
//     final chapterVideoProvider = context.read<EnrolledChapterDetailsProvider>();
//     final currentVideo = chapterVideoProvider.currentlyPlayingVideo;

//     disposePlayers(); // Dispose old player before initializing a new one

//     if (currentVideo.source?.toLowerCase() == "youtube") {
//       final videoId =
//           YoutubePlayer.convertUrlToId(currentVideo.hls ?? "") ?? "";
//       youtubeController = YoutubePlayerController(
//         initialVideoId: videoId,
//         flags: const YoutubePlayerFlags(
//             autoPlay: true, mute: false, controlsVisibleAtStart: true),
//       );
//     } else {
//       betterPlayerController = BetterPlayerController(
//         const BetterPlayerConfiguration(
//           autoPlay: true,
//           looping: false,
//           aspectRatio: 16 / 9,
//           fullScreenAspectRatio: 16 / 9,
//           allowedScreenSleep: false,
//           fit: BoxFit.contain,
//           autoDispose: false,
//         ),
//         betterPlayerDataSource: BetterPlayerDataSource(
//           BetterPlayerDataSourceType.network,
//           currentVideo.hls ?? "",
//         ),
//       );
//     }
//     setState(() {});
//   }

//   /// Handles changing the video when user selects a new one
//   void changeVideo(int index) {
//     disposePlayers();
//     final chapterVideoProvider = context.read<EnrolledChapterDetailsProvider>();
//     chapterVideoProvider.changePlayingVideo(index);
//     setState(() {
//       selectedIndex = index;
//     });
//     initializePlayer(); // re-initialize with new video source
//   }

//   /// Dispose both players to avoid memory leaks
//   void disposePlayers() {
//     if (betterPlayerController != null) {
//       betterPlayerController!.dispose();
//       betterPlayerController = null;
//     }
//     if (youtubeController != null) {
//       youtubeController!.dispose();
//       youtubeController = null;
//     }
//   }

//   @override
//   void dispose() {
//     disposePlayers();
//     _tabController.dispose();
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     enrolledChapterDetailsProvider =
//         context.watch<EnrolledChapterDetailsProvider>();
//     return WillPopScope(
//       onWillPop: () async {
//         // if device is in landscape, switch back to portrait instead of popping
//         if (MediaQuery.of(context).orientation == Orientation.landscape) {
//           await SystemChrome.setPreferredOrientations([
//             DeviceOrientation.portraitUp,
//             DeviceOrientation.portraitDown,
//           ]);
//           return false; // don't exit page yet
//         }
//         return true; // allow exit in portrait
//       },
//       child: Scaffold(
//         body: OrientationBuilder(
//           builder: (context, orientation) {
//             final isLandscape = orientation == Orientation.landscape;

//             if (isLandscape) {
//               // LANDSCAPE → only video player fullscreen
//               return SizedBox.expand(
//                 child: enrolledChapterDetailsProvider
//                             .currentlyPlayingVideo.source ==
//                         "youtube"
//                     ? (youtubeController != null
//                         ? YoutubePlayer(
//                             controller: youtubeController!,
//                             showVideoProgressIndicator: true,
//                           )
//                         : const SizedBox())
//                     : (betterPlayerController != null
//                         ? BetterPlayer(controller: betterPlayerController!)
//                         : const SizedBox()),
//               );
//             }

//             // PORTRAIT → video player + UI
//             return Column(
//               children: [
//                 AspectRatio(
//                   aspectRatio: 16 / 9,
//                   child: enrolledChapterDetailsProvider
//                               .currentlyPlayingVideo.source ==
//                           "youtube"
//                       ? (youtubeController != null
//                           ? YoutubePlayer(
//                               controller: youtubeController!,
//                               showVideoProgressIndicator: true,
//                             )
//                           : const Center(child: CircularProgressIndicator()))
//                       : (betterPlayerController != null
//                           ? BetterPlayer(controller: betterPlayerController!)
//                           : const Center(child: CircularProgressIndicator())),
//                 ),
//                 // Example UI below player

//                 Container(
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: AppColors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TabBar(
//                     labelColor: AppColors.primaryBlue,
//                     indicatorColor: AppColors.primaryOrange,
//                     controller: _tabController,
//                     tabs: const [
//                       Text("Videos"),
//                       Text("Comments"),
//                     ],
//                   ),
//                 ),

//                 // Tab Views
//                 Expanded(
//                   child: TabBarView(
//                     controller: _tabController,
//                     children: [
//                       videosListingTab(),
//                       const CommentsListingScreen(),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget videosListingTab() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: List.generate(
//             enrolledChapterDetailsProvider.chapterVideos.length,
//             (index) {
//               final video = enrolledChapterDetailsProvider.chapterVideos[index];

//               return ChapterVideoCard(
//                 currentlySelected: enrolledChapterDetailsProvider
//                         .currentlyPlayingVideo.batchVideoId ==
//                     video.batchVideoId,
//                 onPressed: () => changeVideo(index),
//                 videoTitle: video.title ?? "Video Title",
//                 thumbnail: video.thumbnail ??
//                     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8hrpymVlFVUacFKLqwlFhCNnu2hVBhAeXQ&usqp=CAU",
//                 videoUrl: video.hls ?? "",
//                 subtitle: "",
//                 duration: (video.duration ?? 0.0).toStringAsFixed(2),
//                 batchId: "${video.batchVideoId}",
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }



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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializePlayer(); // load first video after build
    });
  }

  /// Initializes the appropriate player based on the video source
  /// Only call this when actually changing videos, not on orientation changes
  void initializePlayer() {
    final chapterVideoProvider = context.read<EnrolledChapterDetailsProvider>();
    final currentVideo = chapterVideoProvider.currentlyPlayingVideo;

    disposePlayers(); // Dispose old player before initializing a new one

    if (currentVideo.source?.toLowerCase() == "youtube") {
      final videoId =
          YoutubePlayer.convertUrlToId(currentVideo.hls ?? "") ?? "";
      youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
            autoPlay: true, mute: false, controlsVisibleAtStart: true),
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
          currentVideo.hls ?? "",
        ),
      );
    }
    setState(() {});
  }

  /// Handles changing the video when user selects a new one
  void changeVideo(int index) {
    // Only dispose and reinitialize when actually changing videos
    disposePlayers();
    final chapterVideoProvider = context.read<EnrolledChapterDetailsProvider>();
    chapterVideoProvider.changePlayingVideo(index);
    setState(() {
      selectedIndex = index;
    });
    initializePlayer(); // re-initialize with new video source
  }

  /// Dispose both players to avoid memory leaks
  void disposePlayers() {
    if (betterPlayerController != null) {
      betterPlayerController!.dispose();
      betterPlayerController = null;
    }
    if (youtubeController != null) {
      youtubeController!.dispose();
      youtubeController = null;
    }
  }

  @override
  void dispose() {
    disposePlayers();
    _tabController.dispose();
    super.dispose();
  }

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
                // Example UI below player

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
    if (enrolledChapterDetailsProvider.currentlyPlayingVideo.source?.toLowerCase() == "youtube") {
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

  Widget videosListingTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: List.generate(
            enrolledChapterDetailsProvider.chapterVideos.length,
            (index) {
              final video = enrolledChapterDetailsProvider.chapterVideos[index];

              return ChapterVideoCard(
                currentlySelected: enrolledChapterDetailsProvider
                        .currentlyPlayingVideo.batchVideoId ==
                    video.batchVideoId,
                onPressed: () => changeVideo(index),
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