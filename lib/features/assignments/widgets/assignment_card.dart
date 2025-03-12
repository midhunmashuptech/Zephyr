import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart' show AppColors;

class AssignmentCard extends StatelessWidget {
  final String heading;
  final String author;
  final String date;
  final String time;

  const AssignmentCard(
      {super.key,
      required this.heading,
      required this.author,
      required this.date,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.16 > 60
                    ? 60
                    : MediaQuery.of(context).size.width * 0.16,
                height: MediaQuery.of(context).size.width * 0.16 > 60
                    ? 60
                    : MediaQuery.of(context).size.width * 0.16,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(MediaQuery.of(context).size.width),
                  color: AppColors.primaryGreen,
                ),
                child: Icon(
                  Icons.assignment,
                  size: MediaQuery.of(context).size.width * 0.1 > 35
                      ? 35
                      : MediaQuery.of(context).size.width * 0.1,
                  color: AppColors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      heading,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(author,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400)),
                    Row(
                      children: [
                        Text("Due date:",style: TextStyle(fontSize: 12),),
                        Text(date ,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400,color: AppColors.primaryBlue)),
                        Text(" | $time",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400,color: AppColors.primaryBlue)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
        );
  }
}
