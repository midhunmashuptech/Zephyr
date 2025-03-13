import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class NotificationCard extends StatelessWidget {
  final String heading;
  final String subheading;
  final String time;
  final String image;

  const NotificationCard({
    super.key,
    required this.heading,
    required this.subheading,
    required this.image,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.orangeGradient,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: MediaQuery.of(context).size.width * 0.3 > 100
                        ? 100
                        : MediaQuery.of(context).size.width * 0.3,
                    width: MediaQuery.of(context).size.width * 0.5 > 150
                        ? 150
                        : MediaQuery.of(context).size.width * 0.5,
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(image,fit: BoxFit.fill),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          heading,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          time,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                subheading,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
               
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
