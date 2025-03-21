import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ic.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/screens/course_chapters.dart';
import 'package:zephyr/features/coursedetails/screens/course_overview.dart';
import 'package:zephyr/features/coursedetails/screens/course_reviews.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({super.key});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFinished = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/course_bg1.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 260),
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Foundation of class 10',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Iconify(Ic.videocam,
                                    color: AppColors.primaryGreen),
                                const SizedBox(width: 5),
                                const Text("38 classes"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.people,
                                    color: AppColors.primaryBlue),
                                const SizedBox(width: 5),
                                const Text("50.6k"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: AppColors.primaryOrange),
                                const SizedBox(width: 5),
                                const Text("4.8"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primaryBlue,
                    indicatorColor: AppColors.primaryOrange,
                    dividerColor: AppColors.white,
                    tabs: const [
                      Tab(text: 'Overview'),
                      Tab(text: 'Chapters'),
                      Tab(text: 'Reviews'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 520,
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    CourseOverview(),
                    CourseChapters(),
                    CourseReviews()
                  ],
                ),
              ),
            ],
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: SwipeableButtonView(
                        buttonText: "Enroll at 599/-",
                        buttonWidget: const Icon(Icons.arrow_forward,
                            color: AppColors.primaryOrange),
                        activeColor: AppColors.primaryOrange,
                        isFinished: isFinished,
                        onWaitingProcess: () {
                          // Simulate a delay for the button action
                          Future.delayed(const Duration(seconds: 1), () {
                            setState(() {
                              isFinished = true;
                            });
                          });
                        },
                        onFinish: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
