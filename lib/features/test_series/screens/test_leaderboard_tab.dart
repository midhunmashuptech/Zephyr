import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/features/test_series/provider/test_series_provider.dart';
import 'package:zephyr/features/test_series/widgets/rank_card.dart';

class TestLeaderboardTab extends StatefulWidget {
  final String maxMark;
  const TestLeaderboardTab({super.key, required this.maxMark});

  @override
  State<TestLeaderboardTab> createState() => _TestLeaderboardTabState();
}

class _TestLeaderboardTabState extends State<TestLeaderboardTab> {
  TestSeriesProvider testSeriesProvider = TestSeriesProvider();

  @override
  Widget build(BuildContext context) {
    testSeriesProvider = context.watch<TestSeriesProvider>();
    return Scaffold(
      body: testSeriesProvider.leaderBoardList.isEmpty
          ? Center(
              child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
                children: [
                  // Animated no data Lottie
                  Lottie.asset("assets/lottie/nodata.json", height: 200),
                  Text("No Rank List available!"),
                ],
              ),
            ))
          : ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            separatorBuilder: (context, index) => SizedBox(height: 0),
            itemCount: testSeriesProvider.leaderBoardList.length <= 10 ? testSeriesProvider.leaderBoardList.length : 10,
            itemBuilder: (context, index) {
              final duration = Duration(milliseconds: 200 + index * 80);
              return TweenAnimationBuilder<Offset>(
                tween: Tween<Offset>(
                  begin: const Offset(0, 0.2),
                  end: Offset.zero,
                ),
                duration: duration,
                curve: Curves.easeOutCubic,
                builder: (context, offset, child) {
                  return AnimatedOpacity(
                    opacity: offset == Offset.zero ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Transform.translate(
                      offset: Offset(0, offset.dy * 40),
                      child: child,
                    ),
                  );
                },
                child: RankCard(
                  name: testSeriesProvider.leaderBoardList[index].name ??
                      "Name",
                  score:
                      "${testSeriesProvider.leaderBoardList[index].score}/${widget.maxMark}",
                  rank: testSeriesProvider.leaderBoardList[index].rank ?? 0,
                  image: "assets/images/profile.jpg",
                  userId:
                      testSeriesProvider.leaderBoardList[index].userId ??
                          -1,
                ),
              );
            },
          ),
    );
  }
}
