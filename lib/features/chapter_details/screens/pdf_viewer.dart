import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatelessWidget {
  const PdfViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Pdf Viewer"),
      ),
      body: SfPdfViewer.network(
        "https://d2p9rkckgtge3j.cloudfront.net/files/1674d0d53135e3d7d056d40a99a3df6434UID16.pdf"
      )
    );
  }
}