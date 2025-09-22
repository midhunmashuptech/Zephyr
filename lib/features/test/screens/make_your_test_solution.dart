import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/test/widget/rank_card.dart';

class MakeYourTestSolution extends StatefulWidget {
  const MakeYourTestSolution({super.key});

  @override
  State<MakeYourTestSolution> createState() => _MakeYourTestSolutionState();
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

class _MakeYourTestSolutionState extends State<MakeYourTestSolution> {
  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20 ),
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: rankList.length,
                itemBuilder: (context, index) => RankCard(
                    name: rankList[index].name,
                    score: rankList[index].score,
                    rank: rankList[index].rank,
                    image: rankList[index].image)),
          ),
        ],
      ),
    );
  }
}
