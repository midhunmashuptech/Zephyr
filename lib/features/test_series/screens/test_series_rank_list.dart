import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/test/widget/rank_card.dart';
import 'package:zephyr/features/test_series/provider/test_series_provider.dart';

class TestSeriesRankList extends StatefulWidget {
  final String testId;
  final String maxMark;
  const TestSeriesRankList({required this.testId, required this.maxMark, super.key});

  @override
  State<TestSeriesRankList> createState() => _TestSeriesRankListState();
}

TestSeriesProvider testSeriesProvider = TestSeriesProvider();

class _TestSeriesRankListState extends State<TestSeriesRankList> {
  @override
  void initState() {
    super.initState();
    loadLeaderboard();
  }

  Future<void> loadLeaderboard() async {
    final loadProvider = context.read<TestSeriesProvider>();
    await loadProvider.fetchLeaderBoard(
        context: context, testId: widget.testId);
  }

  @override
  Widget build(BuildContext context) {
    final testSeriesProvider = context.watch<TestSeriesProvider>();
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: AppColors.primaryBlue),
            child: Column(
              children: [
                SizedBox(height: 80),
                Text(
                  "You have been placed among 20\nparticipants in this exam at",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                // Text(
                //   "🏆",
                //   style: TextStyle(
                //       fontSize: 50,
                //       fontWeight: FontWeight.w500,
                //       color: AppColors.white),
                // ),
                Image.asset("assets/images/trophy.png", width: MediaQuery.of(context).size.width * 0.2,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(height: MediaQuery.of(context).size.width * .16, width: MediaQuery.of(context).size.width * .2, decoration: BoxDecoration(
                      gradient: AppColors.sidePodiumGradient
                    )),
                    Container(height: MediaQuery.of(context).size.width * .22, width: MediaQuery.of(context).size.width * .2, decoration: BoxDecoration(
                      gradient: AppColors.mainPodiumGradient
                    ), child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Rank", style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w500)),Text("24", style: TextStyle(color: AppColors.white, fontSize: 35, fontWeight: FontWeight.w700))],)),),
                    Container(height: MediaQuery.of(context).size.width * .12, width: MediaQuery.of(context).size.width * .2, decoration: BoxDecoration(
                      gradient: AppColors.sidePodiumGradient
                    )),
                  ],
                )
              ],
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          // Text(
          //   "🏆 Top Rankers",
          //   style: TextStyle(
          //     fontSize: 22,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // SizedBox(height: 4),
          // Text(
          //   "Leaderboard for the Test",
          //   style: TextStyle(
          //     fontSize: 15,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          testSeriesProvider.isLeaderBoardLoading?
          Expanded(child: Center(child: CircularProgressIndicator()))
           : testSeriesProvider.leaderBoardList.isEmpty
           ? Center(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Column(
                    children: [
                      Lottie.asset("assets/lottie/nodata.json", height: 200),
                      Text("No Rank List available!"),
                    ],
                  ),
                ))

          :Expanded(
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: testSeriesProvider.leaderBoardList.length,
                itemBuilder: (context, index) => RankCard(
                    name: testSeriesProvider.leaderBoardList[index].name ?? "Name",
                    score: "${testSeriesProvider.leaderBoardList[index].score}/${widget.maxMark}" ,
                    rank: testSeriesProvider.leaderBoardList[index].rank ?? 0,
                    image: "assets/images/profile.jpg", 
                    userId: testSeriesProvider.leaderBoardList[index].userId ?? -1,)),
          ),
        ],
      ),
    );
  }
}
