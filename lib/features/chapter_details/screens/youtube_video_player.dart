import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/chapter_details/provider/enrolled_chapter_details_provider.dart'
    show EnrolledChapterDetailsProvider;
import 'package:zephyr/features/chapter_details/widgets/chapter_video_card.dart';
import 'package:zephyr/features/chapter_details/widgets/comments_listing_screen.dart';

class YoutubeVideoPlayScreen extends StatefulWidget {
  const YoutubeVideoPlayScreen({super.key});

  @override
  State<YoutubeVideoPlayScreen> createState() => _YoutubeVideoPlayScreenState();
}

class _YoutubeVideoPlayScreenState extends State<YoutubeVideoPlayScreen>
    with SingleTickerProviderStateMixin {
  EnrolledChapterDetailsProvider enrolledChapterDetailsProvider =
      EnrolledChapterDetailsProvider();

  late TabController _tabController;
  late YoutubePlayerController _youtubeController;
  int selectedIndex = 0; // Track selected video index

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    initializePlayer(); // Load first video
  }

  void initializePlayer() {
    final chapterVideoProvider = context.read<EnrolledChapterDetailsProvider>();

    final videoId = YoutubePlayer.convertUrlToId(
            chapterVideoProvider.currentlyPlayingVideo.hls ?? "") ??
        "";

    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  void changeVideo(int index) {
    debugPrint("Chapter Changed to index $index");
    final chapterVideoProvider = context.read<EnrolledChapterDetailsProvider>();
    chapterVideoProvider.changePlayingVideo(index);

    final newVideoId = YoutubePlayer.convertUrlToId(
            chapterVideoProvider.currentlyPlayingVideo.hls ?? "") ??
        "";

    _youtubeController.load(newVideoId);

    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    enrolledChapterDetailsProvider =
        context.watch<EnrolledChapterDetailsProvider>();

    return SafeArea(
      child: Scaffold(
        body: enrolledChapterDetailsProvider.isVideosLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  // Video Player
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: YoutubePlayer(
                      controller: _youtubeController,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: AppColors.primaryOrange,
                      progressColors: ProgressBarColors(
                        playedColor: AppColors.primaryOrange,
                        handleColor: AppColors.primaryBlue,
                      ),
                    ),
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
                              enrolledChapterDetailsProvider
                                      .selectedChapter.chapterTitle ??
                                  "Chapter Name",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.bookmark_add_rounded),
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
              ),
      ),
    );
  }

  Widget videosListingTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: List.generate(
            enrolledChapterDetailsProvider.chapterVideos.length,
            (index) {
              return ChapterVideoCard(
                currentlySelected: enrolledChapterDetailsProvider
                        .currentlyPlayingVideo.batchVideoId ==
                    enrolledChapterDetailsProvider
                        .chapterVideos[index].batchVideoId,
                onPressed: () => changeVideo(index),
                videoTitle:
                    enrolledChapterDetailsProvider.chapterVideos[index].title ??
                        "Video Title",
                thumbnail: enrolledChapterDetailsProvider
                        .chapterVideos[index].thumbnail ??
                    "https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(enrolledChapterDetailsProvider.chapterVideos[index].hls ?? '')}/0.jpg",
                videoUrl:
                    enrolledChapterDetailsProvider.chapterVideos[index].hls ??
                        "",
                subtitle: "",
                duration: (enrolledChapterDetailsProvider
                            .chapterVideos[index].duration ??
                        0.0)
                    .toStringAsFixed(2),
                batchId:
                    "${enrolledChapterDetailsProvider.chapterVideos[index].batchVideoId}",
              );
            },
          ),
        ),
      ),
    );
  }
}
