import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SampleChapterPdfViewer extends StatelessWidget {
  final String title;
  final String url;
  const SampleChapterPdfViewer({super.key, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text(title),
        ),
        body: SafeArea(child: SfPdfViewer.network(url)));
  }
}