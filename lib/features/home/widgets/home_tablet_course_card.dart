import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/screens/course_details_screen.dart';
import 'package:zephyr/features/enrolled_courses/screens/enrolled_course_detail_screen.dart';
import 'package:zephyr/features/home/widgets/feature_row_widget.dart';
import 'package:zephyr/features/payment/screens/checkout_screen.dart';

class HomeTabletCourseCard extends StatelessWidget {
  final int index;
  final String courseId;
  final String courseName;
  final String courseRating;
  final String thumbnail;
  final bool isEnrolled;
  final String price;
  final String discountType; // "no discount" or "amount"
  final String? discountValue; // discount amount if discountType == "amount"
  final String start;
  final String end;
  final int duration;
  final String level;
  final String type;
  const HomeTabletCourseCard({
    super.key,
    required this.index,
    required this.courseId,
    required this.courseName,
    required this.courseRating,
    required this.thumbnail,
    required this.isEnrolled,
    required this.price,
    required this.discountType,
    required this.discountValue,
    required this.start,
    required this.end,
    required this.duration,
    required this.level,
    required this.type,
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
    double? finalPrice = (original != null && discount != null)
        ? (original - discount)
        : original;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB), // Elegant off-white background
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFDEE3EA), // Soft, elegant border
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB0B8C1).withOpacity(0.13),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: const Color(0xFFDEE3EA).withOpacity(0.08),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(children: [
        Row(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      height: 120,
                      width: MediaQuery.of(context).size.width * 0.33,
                      imageUrl: thumbnail,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Shimmer.fromColors(
                        baseColor: const Color(0xFFE3E6ED),
                        highlightColor: const Color(0xFFF8F9FB),
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.33,
                          color: const Color(0xFFF8F9FB),
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
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          const Color(0xFF2D3A4A).withOpacity(0.82),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Enroll/Enrolled badge
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isEnrolled
                          ? const Color(0xFF3CB371)
                          : const Color(0xFF2D3A4A),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.07),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      type.isNotEmpty
                          ? "${type[0].toUpperCase()}${type.substring(1)} Class"
                          : "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                Positioned(bottom: 10, left: 10, child: courseStarRating()),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title of Course
                    SizedBox(
                      height: 45,
                      child: Text(
                        courseName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D3A4A),
                          letterSpacing: 0.1,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),

                    // Start and End date
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      runSpacing: 6,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_today,
                                size: 16, color: const Color(0xFF3CB371)),
                            const SizedBox(width: 5),
                            Text(
                              'Starts: ${start.isEmpty || start == "null" ? "NA" : formatReadableDate(start)}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF7B8493),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward,
                            size: 16, color: const Color(0xFF7B8493)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.event,
                                size: 16, color: const Color(0xFF3CB371)),
                            const SizedBox(width: 5),
                            Text(
                              "Ends: ${end.isEmpty || end == "null" ? "NA" : formatReadableDate(end)}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF7B8493),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Course Features
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: FeatureRowWidget(
                                  feature: 'Live Lectures',
                                  color: const Color(0xFF2D3A4A),
                                  icon: Icons.live_tv),
                            ),
                            Expanded(
                              child: FeatureRowWidget(
                                  feature: 'Recorded Lectures',
                                  color: const Color(0xFF3CB371),
                                  icon: Icons.play_circle_fill),
                            )
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: FeatureRowWidget(
                                  feature: "DPP's & Quizzes",
                                  color: const Color(0xFFF7B731),
                                  icon: Icons.assignment),
                            ),
                            Expanded(
                              child: FeatureRowWidget(
                                feature: "Doubt Clearance",
                                color: const Color(0xFF2D3A4A),
                                icon: Icons.help_outline,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),

        // Payment and Buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Row(
                  children: [
                    if (discountType == "amount" &&
                        discount != null &&
                        discount > 0) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '₹$price',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color(0xFF7B8493),
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                finalPrice != null
                                    ? '₹${finalPrice.toStringAsFixed(2).replaceAll(RegExp(r'\.00'), '')}/-'
                                    : '₹-',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color(0xFF2D3A4A),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7B731),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.07),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              'Discount of ₹${discountValue ?? ''} applied',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      )
                    ] else ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            finalPrice != null
                                ? '₹${finalPrice.toStringAsFixed(2).replaceAll(RegExp(r'\.00'), '')}/-'
                                : '₹-',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFF2D3A4A),
                            ),
                          ),
                          Text(
                            'Course fee amount',
                            style: const TextStyle(
                              color: Color(0xFF7B8493),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
                const SizedBox(width: 14),

                // Buttons
                Expanded(
                  child: Row(
                    children: [
                      isEnrolled
                          ? Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blue,
                                  elevation: 0,
                                  side: const BorderSide(
                                    color: Colors.blue,
                                    width: 1.5,
                                  ),
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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
                                child: const Text(
                                  "Start Learning",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: const Color(0xFF3CB371)
                                            .withOpacity(0.10),
                                        foregroundColor:
                                            const Color(0xFF3CB371),
                                        side: const BorderSide(
                                            color: Color(0xFF3CB371),
                                            width: 1.2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
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
                                      child: const Text("Explore",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF8A56F7), // Purple
                                        foregroundColor: Colors.white,
                                        elevation: 2,
                                        shadowColor: const Color(0xFF8A56F7)
                                            .withOpacity(0.18),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
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
                                      child: const Text(
                                        "Subscribe",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
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

String formatReadableDate(String isoDate) {
  try {
    final date = DateTime.parse(isoDate);
    return DateFormat("dd/MM/yy").format(date);

    // // Example: 31 Jul 2025
    // return "${date.day.toString().padLeft(2, '0')} "
    //     "${_monthAbbreviation(date.month)} "
    //     "${date.year}";
  } catch (e) {
    return isoDate;
  }
}
