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

class RankList {
  final String name;
  final String score;
  final int rank;
  final String image;

  const RankList({
    required this.name,
    required this.score,
    required this.rank,
    required this.image,
  });
}

List<RankList> rankList = [
  RankList(
    name: 'Midhun Murali',
    score: '99/100',
    rank: 1,
    image: "assets/images/profilenew.png",
  ),
  RankList(
    name: 'Athulya Ajayakumar',
    score: '98/100',
    rank: 2,
    image: "assets/images/profile.jpg",
  ),
  RankList(
    name: 'Alankritha Sreekumar',
    score: '98/100',
    rank: 3,
    image: "assets/images/profile.jpg",
  ),
  RankList(
    name: 'Athira Ajayakumar',
    score: '94/100',
    rank: 4,
    image: "assets/images/profile.jpg",
  ),
  RankList(
    name: 'Aswin Menon',
    score: '98/100',
    rank: 5,
    image: "assets/images/profile.jpg",
  ),
  RankList(
    name: 'Dony Baby',
    score: '98/100',
    rank: 6,
    image: "assets/images/profile.jpg",
  ),
  RankList(
    name: 'Aravind Babu',
    score: '94/100',
    rank: 7,
    image: "assets/images/profile.jpg",
  ),
  RankList(
    name: 'Aswin Menon',
    score: '98/100',
    rank: 8,
    image: "assets/images/profile.jpg",
  ),
  RankList(
    name: 'Dony Baby',
    score: '98/100',
    rank: 9,
    image: "assets/images/profile.jpg",
  ),
  RankList(
    name: 'Aravind Babu',
    score: '94/100',
    rank: 10,
    image: "assets/images/profile.jpg",
  ),
];
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
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: AppColors.primaryBlue),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "🎉 Congratulations!",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Your Rank",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "#3",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "🏆 Top Rankers",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Leaderboard for the Test",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          testSeriesProvider.isLeaderBoardLoading?
          Center(child: CircularProgressIndicator())
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
                    image: rankList[index].image)),
          ),
        ],
      ),
    );
  }
}
