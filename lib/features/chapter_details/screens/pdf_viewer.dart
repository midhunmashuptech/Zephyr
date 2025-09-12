import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:zephyr/features/chapter_details/provider/enrolled_chapter_details_provider.dart';

class PdfViewer extends StatelessWidget {
  String url;
  PdfViewer({
    required this.url,
    super.key});

  EnrolledChapterDetailsProvider enrolledChapterDetailsProvider =
      EnrolledChapterDetailsProvider();
  @override
  Widget build(BuildContext context) {
    enrolledChapterDetailsProvider = context.watch<EnrolledChapterDetailsProvider>();
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text("Pdf Viewer"),
        ),
        body: SfPdfViewer.network(url));
  }
}
