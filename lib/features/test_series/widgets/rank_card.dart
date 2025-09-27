import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/constants/app_constants.dart';

class RankCard extends StatelessWidget {
  final String name;
  final String score;
  final int rank;
  final String image;
  final int userId;

  const RankCard(
      {super.key,
      required this.name,
      required this.score,
      required this.rank,
      required this.image,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserDetailsProvider>();
    debugPrint(
        "${userProvider.userDetails.id} ${userId} : ${userProvider.userDetails.id == userId}");

    return Padding(
      padding: userProvider.userDetails.id == userId
          ? EdgeInsets.symmetric(horizontal: 2.0)
          : EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        elevation: userProvider.userDetails.id == userId ? 2 : 0,
        clipBehavior: Clip.hardEdge,
        child: Container(
          decoration: BoxDecoration(
            gradient: rank == 1
                ? LinearGradient(
                    colors: [
                      Color(0xFFFFE082),
                      Color(0xFFFFC107)
                    ], // light gold → rich gold
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : rank == 2
                    ? LinearGradient(
                        colors: [Color(0xFFE0E0E0), Color(0xFFB0BEC5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : rank == 3
                        ? LinearGradient(
                            colors: [
                              Color(0xFFD7CCC8),
                              Color.fromARGB(255, 191, 133, 114)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : rank == userProvider.userDetails.id
                            ? const LinearGradient(
                                colors: [
                                  AppColors.lightBlue,
                                  Color.fromARGB(255, 129, 191, 224)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
            color: rank == 1
                ? null
                : rank == 2
                    ? null
                    : rank == 3
                        ? null
                        : AppColors.lightGrey,
            // borderRadius: BorderRadius.circular(16),
            border: rank == 1
                ? null
                : rank == 2
                    ? null
                    : rank == 3
                        ? null
                        : Border.all(
                            color: const Color.fromARGB(232, 209, 209, 209),
                            width: 1),
            // boxShadow: userProvider.userDetails.id == userId
            // ? [
            //   BoxShadow(
            //     color: Colors.black.withAlpha(120),
            //     blurRadius: 2,
            //     offset: const Offset(0, 2),
            //   ),
            // ]
            // : [],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
            child: Row(
              children: [
                // Profile + Rank Badge
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(image),
                      backgroundColor: Colors.grey[300],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: rank == 1
                            ? const LinearGradient(
                                colors: [Colors.amber, Colors.deepOrange],
                              )
                            : rank == 2
                                ? LinearGradient(
                                    colors: [Colors.grey, Colors.blueGrey],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : rank == 3
                                    ? LinearGradient(
                                        colors: [
                                          Color(0xFFD7CCC8),
                                          Color.fromARGB(255, 92, 68, 60)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                    : null,
                        color: rank == 1
                            ? null
                            : rank == 2
                                ? null
                                : rank == 3
                                    ? null
                                    : AppColors.primaryGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: rank == 1 || rank == 2 || rank == 3
                          ? Icon(
                              HugeIcons.strokeRoundedAward05,
                              color: Colors.white,
                              size: 16,
                            )
                          //  rank == 1
                          //     ?
                          //     const Icon(
                          //         HugeIcons.strokeRoundedCrown,
                          //         color: Colors.white,
                          //         size: 16,
                          //       )
                          //     : rank == 2
                          //         ? const Icon(
                          //             HugeIcons.strokeRoundedGold,
                          //             color: Colors.white,
                          //             size: 16,
                          //           )
                          //         : rank == 3
                          //             ? const Icon(
                          //                 HugeIcons.strokeRoundedAward05,
                          //                 color: Colors.white,
                          //                 size: 16,
                          //               )
                          : Text(
                              "$rank",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                // Name + Score
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        score,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
        
                // Rank Display
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      rank == 1
                          ? FluentIcons.crown_16_filled
                          : rank == 2
                              ? HugeIcons.strokeRoundedMedalSecondPlace
                              : rank == 3
                                  ? HugeIcons.strokeRoundedMedalThirdPlace
                                  : HugeIcons.strokeRoundedAward04,
                      color: rank == 1 ? Colors.amber[900] : AppColors.black,
                      size: 28,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Rank #$rank",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: rank == 1 ? Colors.amber[900] : Colors.black87,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
