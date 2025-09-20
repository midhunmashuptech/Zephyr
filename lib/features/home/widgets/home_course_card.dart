import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/screens/course_details_screen.dart';
import 'package:zephyr/features/enrolled_courses/screens/enrolled_course_detail_screen.dart';
import 'package:zephyr/features/payment/screens/checkout_screen.dart';

class HomeCourseCard extends StatelessWidget {
  final int index;
  final String courseId;
  final String courseName;
  final String courseRating;
  final String thumbnail;
  final bool isEnrolled;
  final String price;
  final String discountType; // "no discount" or "amount"
  final String? discountValue; // discount amount if discountType == "amount"

  const HomeCourseCard({
    super.key,
    required this.index,
    required this.courseId,
    required this.courseName,
    required this.courseRating,
    required this.thumbnail,
    required this.isEnrolled,
    required this.price,
    required this.discountType,
    this.discountValue,
  });

  @override
  Widget build(BuildContext context) {
    double? original =
        double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), ''));
    double? discount = (discountType == "amount" &&
            discountValue != null &&
            discountValue!.isNotEmpty)
        ? double.tryParse(discountValue!.replaceAll(RegExp(r'[^0-9.]'), ''))
        : null;
    double? finalPrice =
        (original != null && discount != null) ? (original - discount) : null;

    return Card(
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.30),
      color: AppColors.white,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: thumbnail,
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
              // Gradient overlay for readability
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        switch (index % 3) {
                          0 => AppColors.primaryBlue.withOpacity(0.85),
                          1 => AppColors.primaryGreen.withOpacity(0.85),
                          2 => AppColors.primaryOrange.withOpacity(0.85),
                          int() => AppColors.black.withOpacity(0.85),
                        },
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Enroll/Enrolled badge
              Positioned(
                top: 7,
                right: 7,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isEnrolled
                        ? AppColors.primaryGreen.withOpacity(0.9)
                        : AppColors.primaryBlue.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    isEnrolled ? "Enrolled" : "Enroll",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
    
              Positioned(bottom: 7, left: 7, child: courseStarRating()),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45,
                  child: Text(
                    courseName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: 8),
                Divider(
                  color: AppColors.lightGrey,
                  thickness: 1,
                  height: 1,
                ),
                SizedBox(height: 10),
                LayoutBuilder(builder: (context, constraints) {
                  final isTablet = constraints.maxWidth < 300;
                            // debugPrint("${constraints.maxWidth} $isTablet");
                  return Row(
                    children: [
                      if (discountType == "amount" &&
                          discount != null &&
                          discount > 0) ...[
                        isTablet
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '₹$price',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: AppColors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        finalPrice != null
                                            ? '₹${finalPrice.toStringAsFixed(2).replaceAll(RegExp(r'\.00'), '')}'
                                            : '₹-',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: AppColors.primaryBlue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryOrange
                                          .withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.black.withOpacity(0.08),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      'Discount of ₹${discountValue ?? ''} applied',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Expanded(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '₹$price',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          finalPrice != null
                                              ? '₹${finalPrice.toStringAsFixed(2).replaceAll(RegExp(r'\.00'), '')}'
                                              : '₹-',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: AppColors.primaryBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryOrange
                                            .withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.08),
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        'Discount of ₹${discountValue ?? ''} applied',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                      ] else ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '₹$price',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.primaryBlue,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black.withOpacity(0.08),
                                //     blurRadius: 4,
                                //     offset: Offset(0, 2),
                                //   ),
                                // ],
                              ),
                              child: Text(
                                '',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]
                    ],
                  );
                }),
                SizedBox(height: 10),
                isEnrolled
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shadowColor:
                                Colors.deepPurpleAccent.withOpacity(0.25),
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
                                    EnrolledCourseDetailScreen(
                                  courseId: courseId,
                                ),
                              ),
                            );
                          },
                          child: Text("Start Learning",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    AppColors.primaryGreen.withOpacity(0.12),
                                foregroundColor: AppColors.primaryGreen,
                                side: BorderSide(
                                    color: AppColors.primaryGreen,
                                    width: 1.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CourseDetailsScreen(
                                              courseId: courseId,
                                            )));
                              },
                              child: Text("Explore",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.primaryBlue.withOpacity(0.9),
                                foregroundColor: Colors.white,
                                elevation: 2,
                                shadowColor:
                                    AppColors.primaryBlue.withOpacity(0.25),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
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
                                            CheckoutScreen(
                                              courseId: courseId,
                                            )));
                              },
                              child: Text("Subscribe",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget courseStarRating() {
    double rating = double.tryParse(courseRating) ?? 0.0;
    final fullStarCount = rating.floor();
    final decimalPart = rating - fullStarCount;
    final halfStarCount = decimalPart >= 0.5 ? 1 : 0;
    final emptyStarCount = 5 - fullStarCount - halfStarCount;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(fullStarCount, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 1.5),
              child: Icon(Icons.star, size: 16, color: AppColors.ratingYellow),
            );
          }),
          ...List.generate(halfStarCount, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 1.5),
              child: Icon(Icons.star_half,
                  size: 16, color: AppColors.ratingYellow),
            );
          }),
          ...List.generate(emptyStarCount, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 1.5),
              child: Icon(Icons.star_outline,
                  size: 16, color: AppColors.ratingYellow),
            );
          }),
          SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 13.5,
            ),
          ),
        ],
      ),
    );
  }
}
