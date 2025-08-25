import 'package:flutter/material.dart';

class ChapterAnalysisScreen extends StatefulWidget {
  const ChapterAnalysisScreen({super.key});

  @override
  State<ChapterAnalysisScreen> createState() => _ChapterAnalysisScreenState();
}

class _ChapterAnalysisScreenState extends State<ChapterAnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          Text("data"),
          Text("data"),
          Text("data")
        ],
      )
      ),
    );
  }
}