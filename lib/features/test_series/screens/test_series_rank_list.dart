import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/test_series/model/testseries_leaderboard_model.dart';
import 'package:zephyr/features/test_series/screens/test_leaderboard_tab.dart';
import 'package:zephyr/features/test_series/screens/test_ranktable_tab.dart';
import 'package:zephyr/features/test_series/widgets/rank_card.dart';
import 'package:zephyr/features/test_series/provider/test_series_provider.dart';

class TestSeriesRankList extends StatefulWidget {
  final String testId;
  final String maxMark;
  const TestSeriesRankList(
      {required this.testId, required this.maxMark, super.key});

  @override
  State<TestSeriesRankList> createState() => _TestSeriesRankListState();
}

class _TestSeriesRankListState extends State<TestSeriesRankList> with TickerProviderStateMixin {
  TestSeriesProvider testSeriesProvider = TestSeriesProvider();
  UserDetailsProvider userDetailsProvider = UserDetailsProvider();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadLeaderboard();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> loadLeaderboard() async {
    final loadProvider = context.read<TestSeriesProvider>();
    await loadProvider.fetchLeaderBoard(
        context: context, testId: widget.testId);
  }

  @override
  Widget build(BuildContext context) {
    testSeriesProvider = context.watch<TestSeriesProvider>();
    userDetailsProvider = context.watch<UserDetailsProvider>();
    return Scaffold(
      body: testSeriesProvider.isLeaderBoardLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
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
                      // Animated trophy with bounce effect
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: Image.asset(
                          "assets/images/trophy.png",
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.width * .16,
                              width: MediaQuery.of(context).size.width * .2,
                              decoration: BoxDecoration(
                                  gradient: AppColors.sidePodiumGradient)),
                          Container(
                            height: MediaQuery.of(context).size.width * .22,
                            width: MediaQuery.of(context).size.width * .2,
                            decoration: BoxDecoration(
                                gradient: AppColors.mainPodiumGradient),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Rank",
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w500)),
                                // Animated rank number
                                ScaleTransition(
                                  scale: _scaleAnimation,
                                  child: Text("${testSeriesProvider.leaderBoardList.firstWhere((student) => student.userId == userDetailsProvider.userDetails.id, orElse: () => Ranklist(rank: 0)).rank}",
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 35,
                                          fontWeight: FontWeight.w700)),
                                )
                              ],
                            )),
                          ),
                          Container(
                              height: MediaQuery.of(context).size.width * .12,
                              width: MediaQuery.of(context).size.width * .2,
                              decoration: BoxDecoration(
                                  gradient: AppColors.sidePodiumGradient)),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TabBar(
                    labelColor: AppColors.primaryBlue,
                    indicatorColor: AppColors.primaryOrange,
                    controller: _tabController,
                    tabs: const [
                      Text("Learderboard"),
                      Text("Ranklist"),
                    ],
                  ),
                ),

                // Tab Views
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      TestLeaderboardTab(maxMark: widget.maxMark),
                      TestRanktableTab(maxMark: widget.maxMark),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
