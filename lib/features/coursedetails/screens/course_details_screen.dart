import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ic.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/provider/course_provider.dart';
import 'package:zephyr/features/coursedetails/screens/chapter_navigator_observer.dart';
import 'package:zephyr/features/coursedetails/screens/course_chapters.dart';
import 'package:zephyr/features/coursedetails/screens/course_overview.dart';
import 'package:zephyr/features/coursedetails/screens/course_reviews.dart';
import 'package:zephyr/features/payment/screens/checkout_screen.dart';

class CourseDetailsScreen extends StatefulWidget {
  String courseId;
  CourseDetailsScreen({super.key, required this.courseId});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<NavigatorState> _chapterTabNavKey =
      GlobalKey<NavigatorState>();
  final ValueNotifier<bool> _chapterTabCanPop = ValueNotifier(false);

  late TabController _tabController;
  bool isFinished = false;
  final List<Widget> _tabs = [];
  CourseProvider courseProvider = CourseProvider();

  @override
  void initState() {
    super.initState();
    loadCourseData();
    _tabController = TabController(length: 3, vsync: this);
    _tabs.addAll([
      CourseOverview(),
      buildChapterTab(), // wrapped with internal navigator
      CourseReviews(courseId: widget.courseId,),
    ]);
  }

  Future<void> loadCourseData() async {
    final loadProvider = context.read<CourseProvider>();
    await loadProvider.getCourseDetails(courseId: widget.courseId, context: context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildChapterTab() {
    return Navigator(
      key: _chapterTabNavKey,
      observers: [ChapterNavigatorObserver(_chapterTabCanPop)],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => CourseChapters(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    courseProvider = context.watch<CourseProvider>();
    return Scaffold(
      body: courseProvider.isLoading
          ? Center(
              child: Lottie.asset("assets/lottie/loading.json", height: 100),
            )
          : Stack(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                            imageUrl: courseProvider
                                    .courseData.thumbnail ??
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8hrpymVlFVUacFKLqwlFhCNnu2hVBhAeXQ&usqp=CAU",
                            imageBuilder: (context, imageProvider) => Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: AppColors.grey,
                              highlightColor: AppColors.lightGrey,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.3,
                                width: double.infinity,
                                color: AppColors.white,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: double.infinity,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.error,
                                  color: Colors.red, size: 40),
                            ),
                          ),
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3 -40),
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5),
                                child: Text(
                                    courseProvider.courseData.title ??
                                        "Course title",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                      height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.3 - 250,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TabBarView(
                          controller: _tabController,
                          children: _tabs,
                        ),
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
                          child: SwipeableButtonView(
                            buttonText:
                                "Enroll for ₹${double.parse(courseProvider.courseData.price ?? "0.0").toInt()}",
                            buttonWidget: const Icon(Icons.arrow_forward,
                                color: AppColors.primaryOrange),
                            activeColor: AppColors.primaryOrange,
                            isFinished: isFinished,
                            onWaitingProcess: () {
                              Future.delayed(const Duration(seconds: 2), () {
                                setState(() {
                                  isFinished = true;
                                });
                              });
                            },
                            onFinish: () async {
                              // Navigate and wait for pop
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckoutScreen()),
                              );
                              // Reset state after returning WITHOUT triggering reverse animation
                              setState(() {
                                isFinished = false;
                              });
                            },
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
