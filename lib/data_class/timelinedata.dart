import 'package:flutter/material.dart';

class TimelineItemData {
  final String title;
  final String subtitle;
  final String time;
  final Color color;

  const TimelineItemData({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
  });
}