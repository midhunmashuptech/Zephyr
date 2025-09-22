import 'package:flutter/material.dart';
import 'package:zephyr/features/home/widgets/home_tablet_course_card.dart';

class HomeCardTestScreen extends StatefulWidget {
  const HomeCardTestScreen({super.key});

  @override
  State<HomeCardTestScreen> createState() => _HomeCardTestScreenState();
}

class _HomeCardTestScreenState extends State<HomeCardTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  HomeTabletCourseCard(
                    index: 1,
                    courseId: "1",
                    courseName: 'Repeaters 2025 (Mediacal Engineering) Course',
                    courseRating: '4.3',
                    thumbnail:
                        "https://d333c2xue188ia.cloudfront.net/images/courses/tot7sXXKYxE8gUyc4In2ycktCYgHzp4XrmvAUn92.png",
                    isEnrolled: 1 % 2 == 0 ? false : true,
                    price: '37,000',
                    discountType: 'aamount',
                    discountValue: '2000',
                    start: '2025-07-31T00:00:00.000000Z',
                    end: '2025-08-03T00:00:00.000000Z',
                    duration: 34,
                    level: 'basic',
                    type: 'Online Class',
                  ),
                ],
              )
              // ListView.separated(
              //     itemBuilder: (context, index) => HomeTabletCourseCard(
              //           index: index,
              //           courseId: "1",
              //           courseName: 'Repeaters 2025 (Mediacal Engineering)',
              //           courseRating: '4.3',
              //           thumbnail:
              //               "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8hrpymVlFVUacFKLqwlFhCNnu2hVBhAeXQ&usqp=CAU",
              //           isEnrolled: index % 2 == 0 ? true : false,
              //           price: '37,000',
              //           discountType: 'amount',
              //           discountValue: '2000',
              //           start: '2025-07-31T00:00:00.000000Z',
              //           end: '2025-08-03T00:00:00.000000Z',
              //           duration: 34,
              //           level: 'basic',
              //           type: 'Online Class',
              //         ),
              //     separatorBuilder: (context, index) => SizedBox(height: 5),
              //     itemCount: 3)
              )),
    );
  }
}
