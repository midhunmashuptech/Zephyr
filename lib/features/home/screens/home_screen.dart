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
  final List<String> categories = [
    "All",
    "NEET",
    "JEE",
    "UPSC",
    "PSC",
    "SSC",
  ];

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Top Section with Profile and Menu
                Row(
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
                                      color: AppColors.black.withAlpha(
                                          50), // changed this - withOpacity(0.2)
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

                SizedBox(height: 20),

                CustomSearchBar(
                  color: AppColors.primaryBlue,
                  onChanged: (value) {
                    homePageProvider.filterActiveCourses(value);
                  },
                ),

                SizedBox(height: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Featured Courses",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    homePageProvider.isFeaturedCourseLoading
                        ? Center(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ))
                        :
                        // FeaturedCourseCard(
                        //           course: homePageProvider.featuredCourses[0],
                        //           index: 0),
                        SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics:
                                  BouncingScrollPhysics(), // or AlwaysScrollableScrollPhysics()
                              itemCount:
                                  homePageProvider.featuredCourses.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FeaturedCourseCard(
                                  course:
                                      homePageProvider.featuredCourses[index],
                                  index: index,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 20),
                  ],
                ),

                /// Course Categories
                (searchValue == "" || searchValue == null)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Courses",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Wrap(
                              children: categories
                                  .map((category) => CategoryWidget(
                                      categoryName:
                                          category)) // Assuming CategoryWidget fits dynamically
                                  .toList(),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      )
                    : SizedBox(height: 0),

                /// Recommended Section
                Text(
                  "Recommended for you",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),

                homePageProvider.isActiveCoursesLoading
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: CircularProgressIndicator()),
                          ],
                        ))
                    : homePageProvider.filteredActiveCourses.isEmpty
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40.0),
                            child: Column(
                              children: [
                                Lottie.asset("assets/lottie/nodata.json",
                                    height: 200),
                                Text("No Matching Courses found!"),
                              ],
                            ),
                          ))
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: homePageProvider.activeCourses.length,
                            itemBuilder: (context, index) => HomeCourseCard(
                                course: homePageProvider
                                    .filteredActiveCourses[index],
                                index: index))
                // Wrap(
                //     children: List.generate(
                //         homePageProvider.filteredActiveCourses.length,
                //         (index) => HomeCourseCard(
                //             course: homePageProvider
                //                 .filteredActiveCourses[index],
                //             index: index))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
