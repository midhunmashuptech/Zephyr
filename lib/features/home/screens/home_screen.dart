import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:iconify_flutter_plus/icons/mi.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/common/widgets/custom_search_bar.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/data_class/course.dart';
import 'package:zephyr/features/drawer/screens/drawer.dart';
import 'package:zephyr/features/drawer/screens/profile_screen.dart';
import 'package:zephyr/features/home/provider/home_page_provider.dart';
import 'package:zephyr/features/home/widgets/category_widget.dart';
import 'package:zephyr/features/home/widgets/featured_course_card.dart';
import 'package:zephyr/features/home/widgets/home_course_card.dart';
import 'package:zephyr/features/notification/screens/notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomePageProvider homePageProvider = HomePageProvider();
  UserDetailsProvider userDetailsProvider = UserDetailsProvider();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Course> courses = [];
  List<Course> filteredCourses = [];
  String? searchValue;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadActiveCourses();
  }

  Future<void> loadActiveCourses() async {
    final homePageProvider = context.read<HomePageProvider>();
    await homePageProvider.fetchActiveCouses(context);
    await homePageProvider.fetchFeaturedCourses(context: context);
    await homePageProvider.fetchCategoryBasedCourses(context: context);
  }

  void filterCourses() {
    filteredCourses = courses
        .where((course) => (course.name ?? "")
            .toLowerCase()
            .contains((searchValue ?? "").toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    homePageProvider = context.watch<HomePageProvider>();
    userDetailsProvider = context.watch<UserDetailsProvider>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              _scaffoldKey.currentState!.openDrawer();
                            },
                            icon: Iconify(
                              Mi.menu,
                              color: AppColors.primaryBlue,
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen()));
                          },
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.black.withAlpha(50),
                                      blurRadius: 6,
                                      spreadRadius: 2,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: AppColors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: CircleAvatar(
                                      radius: 25,
                                      foregroundImage:
                                          CachedNetworkImageProvider(
                                              userDetailsProvider
                                                      .userDetails.image ??
                                                  ""),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Hello, Welcome",
                                      style: TextStyle(fontSize: 13)),
                                  Text(
                                    userDetailsProvider.userDetails.name ??
                                        "User",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Notifications()));
                        },
                        icon: Iconify(Mdi.bell_notification, size: 30))
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomSearchBar(
                  color: AppColors.primaryBlue,
                  onChanged: (value) {
                    homePageProvider.filterActiveCourses(value);
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Featured Courses",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: homePageProvider.isFeaturedCourseLoading
                  ? Center(
                      child: Lottie.asset("assets/lottie/loading.json",
                          height: 100),
                    )
                  : SizedBox(
                      height: 310,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        itemCount: homePageProvider.featuredCourses.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: FeaturedCourseCard(
                            isEnrolled: homePageProvider
                                    .featuredCourses[index].isEnrolled ??
                                false,
                            course: homePageProvider.featuredCourses[index],
                            index: index,
                          ),
                        ),
                      ),
                    ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course Categories
                    (searchValue == "" || searchValue == null)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Category",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              homePageProvider.isCategoryCourseLoading
                                  ? Center(
                                      child: Lottie.asset(
                                          "assets/lottie/loading.json",
                                          height: 100),
                                    )
                                  : Wrap(
                                      alignment: WrapAlignment.start,
                                      children: homePageProvider
                                          .categoryBasedCourses
                                          .map((category) => GestureDetector(
                                                onTap: () => homePageProvider
                                                    .changeCategory(
                                                        category.id ?? 0),
                                                child: CategoryWidget(
                                                    isSelected: homePageProvider
                                                            .selectedCategory ==
                                                        category.id,
                                                    categoryName:
                                                        category.title ??
                                                            "Category Name"),
                                              ))
                                          .toList(),
                                    ),
                              SizedBox(height: 20),
                            ],
                          )
                        : SizedBox.shrink(),
                    // Recommended Section
                    Text(
                      homePageProvider.isCategoryCourseLoading
                          ? "All Courses for you"
                          : "${homePageProvider.selectedCategoryCourses.title} Courses for you",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    homePageProvider.isCategoryCourseLoading
                        ? Center(
                            child: Lottie.asset("assets/lottie/loading.json",
                                height: 100),
                          )
                        : LayoutBuilder(
                            builder: (context, constraints) {
                              final isTablet = constraints.maxWidth > 500;
                              // debugPrint("${constraints.maxWidth} $isTablet");
                              if (homePageProvider.selectedCategoryCourses.id ==
                                  0) {
                                if (homePageProvider.activeCourses.isEmpty) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 40.0),
                                      child: Column(
                                        children: [
                                          Lottie.asset(
                                              "assets/lottie/nodata.json",
                                              height: 200),
                                          Text("No Matching Courses found!"),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return isTablet
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.75,
                                          mainAxisSpacing: 5,
                                          crossAxisSpacing: 5,
                                        ),
                                        itemCount: homePageProvider
                                            .activeCourses.length,
                                        itemBuilder: (context, index) {
                                          final courseData = homePageProvider
                                              .activeCourses[index];
                                          return HomeCourseCard(
                                            index: index,
                                            courseId: courseData.id.toString(),
                                            courseName: courseData.title ??
                                                "Course Name",
                                            courseRating:
                                                (courseData.averageRating ??
                                                        1.0)
                                                    .toString(),
                                            isEnrolled:
                                                courseData.isEnrolled ?? false,
                                            thumbnail: courseData.thumbnail ??
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8hrpymVlFVUacFKLqwlFhCNnu2hVBhAeXQ&usqp=CAU",
                                            discountType:
                                                courseData.discountType ?? "0",
                                            discountValue:
                                                courseData.discountValue ?? "0",
                                            price: courseData.price ?? "0.00",
                                            start: courseData.start ?? "N/A",
                                            end: courseData.end ?? "N/A",
                                            duration: courseData.duration ?? 0,
                                            level: courseData.level ?? "N/A",
                                            type: courseData.type ?? "N/A",
                                          );
                                        },
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: homePageProvider
                                            .activeCourses.length,
                                        itemBuilder: (context, index) {
                                          final courseData = homePageProvider
                                              .activeCourses[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12.0),
                                            child: HomeCourseCard(
                                              index: index,
                                              courseId:
                                                  courseData.id.toString(),
                                              courseName: courseData.title ??
                                                  "Course Name",
                                              courseRating:
                                                  (courseData.averageRating ??
                                                          0.0)
                                                      .toString(),
                                              isEnrolled:
                                                  courseData.isEnrolled ??
                                                      false,
                                              thumbnail: courseData.thumbnail ??
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8hrpymVlFVUacFKLqwlFhCNnu2hVBhAeXQ&usqp=CAU",
                                              discountType:
                                                  courseData.discountType ??
                                                      "0",
                                              discountValue:
                                                  courseData.discountValue ??
                                                      "0",
                                              price: courseData.price ?? "0.00",
                                              start: courseData.start ?? "N/A",
                                              end: courseData.end ?? "N/A",
                                              duration:
                                                  courseData.duration ?? 0,
                                              level: courseData.level ?? "N/A",
                                              type: courseData.type ?? "N/A",
                                            ),
                                          );
                                        },
                                      );
                              } else {
                                final selectedCourses = homePageProvider
                                        .selectedCategoryCourses.courses ??
                                    [];
                                if (selectedCourses.isEmpty) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 40.0),
                                      child: Column(
                                        children: [
                                          Lottie.asset(
                                              "assets/lottie/nodata.json",
                                              height: 200),
                                          Text("No Matching Courses found!"),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return isTablet
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.75,
                                          mainAxisSpacing: 5,
                                          crossAxisSpacing: 5,
                                        ),
                                        itemCount: selectedCourses.length,
                                        itemBuilder: (context, index) {
                                          final courseData =
                                              selectedCourses[index];
                                          return HomeCourseCard(
                                            index: index,
                                            courseId: courseData.id.toString(),
                                            courseName: courseData.title ??
                                                "Course Name",
                                            courseRating:
                                                (courseData.averageRating ??
                                                        0.0)
                                                    .toString(),
                                            isEnrolled:
                                                courseData.isEnrolled ?? false,
                                            thumbnail: courseData.thumbnail ??
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8hrpymVlFVUacFKLqwlFhCNnu2hVBhAeXQ&usqp=CAU",
                                            discountType:
                                                courseData.discountType ?? "0",
                                            discountValue:
                                                courseData.discountValue ?? "0",
                                            price: courseData.price ?? "0.00",
                                            start: courseData.start ?? "N/A",
                                            end: courseData.end ?? "N/A",
                                            duration: courseData.duration ?? 0,
                                            level: courseData.level ?? "N/A",
                                            type: courseData.type ?? "N/A",
                                          );
                                        },
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: selectedCourses.length,
                                        itemBuilder: (context, index) {
                                          final courseData =
                                              selectedCourses[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12.0),
                                            child: HomeCourseCard(
                                              index: index,
                                              courseId:
                                                  courseData.id.toString(),
                                              courseName: courseData.title ??
                                                  "Course Name",
                                              courseRating:
                                                  (courseData.averageRating ??
                                                          0.0)
                                                      .toString(),
                                              isEnrolled:
                                                  courseData.isEnrolled ??
                                                      false,
                                              thumbnail: courseData.thumbnail ??
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8hrpymVlFVUacFKLqwlFhCNnu2hVBhAeXQ&usqp=CAU",
                                              discountType:
                                                  courseData.discountType ??
                                                      "0",
                                              discountValue:
                                                  courseData.discountValue ??
                                                      "0",
                                              price: courseData.price ?? "0.00",
                                              start: courseData.start ?? "N/A",
                                              end: courseData.end ?? "N/A",
                                              duration:
                                                  courseData.duration ?? 0,
                                              level: courseData.level ?? "N/A",
                                              type: courseData.type ?? "N/A",
                                            ),
                                          );
                                        },
                                      );
                              }
                            },
                          ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }
}
