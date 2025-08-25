import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zephyr/constants/app_constants.dart';

class CourseContentCard extends StatefulWidget {
  String title;
  String subtitle;
  Color bgcolor;
  IconData icon;
  IconData lockicon;

   CourseContentCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.bgcolor,
    required this.lockicon,
    super.key});

  @override
  State<CourseContentCard> createState() => _CourseContentCardState();
}

class _CourseContentCardState extends State<CourseContentCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                  color: AppColors.black.withAlpha(20),
                  spreadRadius: 2,
                  blurRadius: 2)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.16 > 120
                    ? 120
                    : MediaQuery.of(context).size.width * 0.16,
                height: MediaQuery.of(context).size.width * 0.16 > 120
                    ? 120
                    : MediaQuery.of(context).size.width * 0.16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: widget.bgcolor.withAlpha(20),
                ),
                child: Icon(widget.icon,
                  // FluentIcons.document_pdf_24_regular,
                  size: MediaQuery.of(context).size.width * 0.1 > 70
                      ? 70
                      : MediaQuery.of(context).size.width * 0.1,
                  color: widget.bgcolor,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(widget.subtitle,
                          style:
                              TextStyle(fontSize: 12, color: AppColors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(widget.lockicon)
            ],
          ),
        ),
      ),
    );
  }
}
