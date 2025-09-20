import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/screens/course_details_screen.dart';
import 'package:zephyr/features/enrolled_courses/screens/enrolled_course_detail_screen.dart';
import 'package:zephyr/features/home/model/featured_course_model.dart';
import 'package:zephyr/features/payment/screens/checkout_screen.dart';

class FeaturedCourseCard extends StatelessWidget {
  final int index;
  final Courses course;
  final bool isEnrolled;

  const FeaturedCourseCard({
    super.key,
    required this.course,
    required this.index,
    required this.isEnrolled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Card(
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.3),
        color: AppColors.white,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CourseImage(
              course: course,
              index: index,
              isEnrolled: isEnrolled,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                children: [
                  _CourseTitleAndPrice(course: course),
                  const SizedBox(height: 10),
                  isEnrolled
                      ? _StartLearningButton(courseId: course.id.toString())
                      : _ExploreAndSubscribeButtons(course: course),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CourseImage extends StatelessWidget {
  final Courses course;
  final int index;
  final bool isEnrolled;

  const _CourseImage({
    required this.course,
    required this.index,
    required this.isEnrolled,
  });

  Color _getGradientColor() {
    switch (index % 3) {
      case 0:
        return AppColors.primaryBlue;
      case 1:
        return AppColors.primaryGreen;
      case 2:
        return AppColors.primaryOrange;
      default:
        return AppColors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          child: SizedBox(
            height: 150,
            width: 280,
            child: CachedNetworkImage(
              imageUrl: course.thumbnail ??
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8hrpymVlFVUacFKLqwlFhCNnu2hVBhAeXQ&usqp=CAU",
              fit: BoxFit.cover,
              placeholder: (_, __) => Shimmer.fromColors(
                baseColor: AppColors.grey,
                highlightColor: AppColors.lightGrey,
                child: Container(
                  height: 120,
                  width: double.infinity,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  _getGradientColor(),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 7,
          right: 7,
          child: _CourseTypeBadge(
            type: course.type ?? "",
            isEnrolled: isEnrolled,
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: _StarRating(rating: course.averageRating ?? 0.0),
        ),
      ],
    );
  }
}

class _CourseTypeBadge extends StatelessWidget {
  final String type;
  final bool isEnrolled;

  const _CourseTypeBadge({
    required this.type,
    required this.isEnrolled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isEnrolled
            ? AppColors.primaryGreen.withOpacity(0.9)
            : AppColors.primaryBlue.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        type,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 10,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _CourseTitleAndPrice extends StatelessWidget {
  final Courses course;

  const _CourseTitleAndPrice({required this.course});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  course.title ?? "",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            height: 1,
            color: AppColors.lightGrey,
          ),
          Text(
            '₹${course.price}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}

class _StartLearningButton extends StatelessWidget {
  final String courseId;

  const _StartLearningButton({required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              foregroundColor: Colors.white,
              elevation: 2,
              shadowColor: Colors.deepPurpleAccent.withOpacity(0.25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EnrolledCourseDetailScreen(courseId: courseId),
                ),
              );
            },
            child: const Text("Start Learning",
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }
}

class _ExploreAndSubscribeButtons extends StatelessWidget {
  final Courses course;

  const _ExploreAndSubscribeButtons({required this.course});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen.withOpacity(0.12),
              foregroundColor: AppColors.primaryGreen,
              side: BorderSide(color: AppColors.primaryGreen, width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CourseDetailsScreen(courseId: course.id.toString()),
                ),
              );
            },
            child: const Text("Explore",
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue.withOpacity(0.9),
              foregroundColor: Colors.white,
              elevation: 2,
              shadowColor: AppColors.primaryBlue.withOpacity(0.25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CheckoutScreen(courseId: course.id.toString()),
                ),
              );
            },
            child: const Text("Subscribe",
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }
}

class _StarRating extends StatelessWidget {
  final double rating;

  const _StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    double decimal = rating - fullStars;
    int halfStars = decimal >= 0.5 ? 1 : 0;
    int emptyStars = 5 - fullStars - halfStars;

    return Row(
      children: [
        ...List.generate(fullStars,
            (_) => Icon(Icons.star, size: 18, color: AppColors.ratingYellow)),
        ...List.generate(
            halfStars,
            (_) =>
                Icon(Icons.star_half, size: 18, color: AppColors.ratingYellow)),
        ...List.generate(
            emptyStars,
            (_) => Icon(Icons.star_outline,
                size: 18, color: AppColors.ratingYellow)),
        const SizedBox(width: 5),
        Text(
          "$rating",
          style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.white),
        ),
      ],
    );
  }
}
