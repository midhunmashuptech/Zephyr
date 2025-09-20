import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zephyr/constants/app_constants.dart';

class RankCard extends StatelessWidget {
  final String name;
  final String score;
  final int rank;
  final String image;

  const RankCard({
    super.key,
    required this.name,
    required this.score,
    required this.rank,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    bool isTopRank = rank == 1;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: isTopRank
              ? const LinearGradient(
                  colors: [Color(0xFFFFE082), Color(0xFFFFC107)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isTopRank ? null : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
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
                      gradient: isTopRank
                          ? const LinearGradient(
                              colors: [Colors.amber, Colors.deepOrange],
                            )
                          : null,
                      color: isTopRank ? null : AppColors.primaryGreen,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: isTopRank
                        ? const Icon(
                            HugeIcons.strokeRoundedAward05,
                            color: Colors.white,
                            size: 16,
                          )
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
                        color: isTopRank ? Colors.black87 : Colors.black54,
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
                    isTopRank
                        ? HugeIcons.strokeRoundedAward01
                        : HugeIcons.strokeRoundedAward05,
                    color: isTopRank ? Colors.amber[800] : Colors.orange,
                    size: 28,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Rank #$rank",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isTopRank ? Colors.amber[900] : Colors.black87,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
