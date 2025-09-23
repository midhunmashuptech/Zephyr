import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ic.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zephyr/common/widgets/course_info_chip.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/enrolled_courses/provider/enrolled_course_provider.dart';
import 'package:zephyr/features/enrolled_courses/screens/enrolled_course_chapter.dart';
import 'package:zephyr/features/enrolled_courses/screens/enrolled_courses_review.dart';

class EnrolledCourseDetailScreen extends StatefulWidget {
  final String courseId;
  const EnrolledCourseDetailScreen({super.key, required this.courseId});

  @override
  State<EnrolledCourseDetailScreen> createState() =>
      _EnrolledCourseDetailScreenState();
}

class _EnrolledCourseDetailScreenState extends State<EnrolledCourseDetailScreen>
    with SingleTickerProviderStateMixin {
  EnrolledCourseProvider enrolledCourseProvider = EnrolledCourseProvider();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    loadCourses();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> loadCourses() async {
    final loadCourseProvider = context.read<EnrolledCourseProvider>();
    await loadCourseProvider.getCourseDetailsAndEnrollments(
        context: context, courseId: widget.courseId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    enrolledCourseProvider = context.watch<EnrolledCourseProvider>();

    return Scaffold(
      body: enrolledCourseProvider.isCourseDetailsLoading ||
              enrolledCourseProvider.isCourseEnrollmentsLoading
          ? Center(
              child: Lottie.asset("assets/lottie/loading.json", height: 100),
            )
          : DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    expandedHeight: MediaQuery.of(context).size.height * 0.4,
                    pinned: true,
                    floating: false,
                    backgroundColor: Colors.white,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                              imageUrl: enrolledCourseProvider
                                      .selectedCourseDetails.thumbnail ??
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8hrpymVlFVUacFKLqwlFhCNnu2hVBhAeXQ&usqp=CAU",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                                  color: AppColors.white,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.error,
                                    color: Colors.red, size: 40),
                              ),
                            ),
                          ),
                          // Dropdown at top right
                          Positioned(
                            top: 40,
                            right: 16,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButton<int>(
                                underline: SizedBox(),
                                value: enrolledCourseProvider
                                    .selectedEnrollment.enrollmentId,
                                icon: Icon(Icons.more_vert),
                                items: List.generate(
                                  enrolledCourseProvider
                                      .courseEnrollments.length,
                                  (index) => DropdownMenuItem(
                                      value: enrolledCourseProvider
                                          .courseEnrollments[index]
                                          .enrollmentId,
                                      child: Text(enrolledCourseProvider
                                              .courseEnrollments[index]
                                              .batchName ??
                                          "Batch Name")),
                                ),
                                onChanged: (value) {
                                  enrolledCourseProvider
                                      .changeEnrollment(value ?? 0);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(160),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                  enrolledCourseProvider
                                          .selectedCourseDetails.title ??
                                      "Course title",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CourseInfoChip(
                                    icon: Iconify(
                                      Ic.videocam,
                                      color: AppColors.primaryGreen,
                                      size: 20,
                                    ),
                                    label:
                                        "${enrolledCourseProvider.selectedCourseDetails.videoCount} Classes",
                                  ),
                                  CourseInfoChip(
                                    icon: Icon(
                                      Icons.my_library_books_rounded,
                                      color: AppColors.primaryBlue,
                                      size: 20,
                                    ),
                                    label:
                                        "${enrolledCourseProvider.selectedCourseDetails.pdfCount} Materials",
                                  ),
                                  CourseInfoChip(
                                    icon: Icon(
                                      Icons.star,
                                      color: AppColors.primaryOrange,
                                      size: 20,
                                    ),
                                    label:
                                        "${enrolledCourseProvider.selectedCourseDetails.averageRating}",
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                                    Tab(text: 'Chapters'),
                                    Tab(text: 'Reviews'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    EnrolledCourseChapter(),
                    EnrolledCoursesReview(
                      courseId: widget.courseId,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
