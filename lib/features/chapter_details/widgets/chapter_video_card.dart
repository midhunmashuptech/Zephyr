import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

// ignore: must_be_immutable
class ChapterVideoCard extends StatelessWidget {
  final void Function()? onPressed;
  bool? currentlySelected = false;
  ChapterVideoCard({super.key, this.onPressed, this.currentlySelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.black.withAlpha(20),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],
                color: AppColors.white,
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.width * 0.17,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: AppColors.primaryBlue, width: 3)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset("assets/images/course_bg1.jpg"),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.17,
                                    decoration: BoxDecoration(
                                        color: AppColors.black.withAlpha(80)),
                                  ),
                                ),
                                Icon(
                                  Icons.play_arrow_rounded,
                                  color: AppColors.white,
                                  size: 40,
                                )
                              ],
                            ))),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Rational and Irrational Numbers and its funtions",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.035,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              // Text(
                              //   "Class 10 - Chemical Reactions & Equations",
                              //   style: TextStyle(
                              //       fontSize: MediaQuery.of(context).size.width * 0.025, color: AppColors.black),
                              // ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text("Duration: "),
                                  Text(
                                    "Mathematics",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.025,
                                        color: AppColors.primaryBlue),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.schedule_rounded, size: 20),
                                  SizedBox(width: 5),
                                  Text(
                                    "12:45",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (currentlySelected == true)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.17 + 16,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.black.withAlpha(180)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Currently Playing...",
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
