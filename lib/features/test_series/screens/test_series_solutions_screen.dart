import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zephyr/constants/config.dart';

class TestSeriesSolutionsScreen extends StatefulWidget {
  final String type;
  final String testid;
  final String userid;
  const TestSeriesSolutionsScreen(
      {super.key,
      required this.type,
      required this.testid,
      required this.userid});

  @override
  State<TestSeriesSolutionsScreen> createState() =>
      _TestSeriesSolutionsScreenState();
}

class _TestSeriesSolutionsScreenState extends State<TestSeriesSolutionsScreen> {
  late final WebViewController _supportController;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _supportController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(
          '${viewTestSolution}/${widget.type}/${widget.userid}/${widget.testid}'));
  }

  Future<void> _handleRefresh() async {
    await _supportController.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: _handleRefresh,
              child: WebViewWidget(controller: _supportController),
            ),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
