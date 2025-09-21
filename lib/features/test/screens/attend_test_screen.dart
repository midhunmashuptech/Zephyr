import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/home/screens/home_screen.dart';
import 'package:zephyr/features/home/widgets/home_course_card.dart';

class TestAttendScreen extends StatefulWidget {
  final String type;
  final String testid;
  final String userid;
  final String title;
  const TestAttendScreen(
      {Key? key,
      required this.type,
      required this.testid,
      required this.userid,
      required this.title})
      : super(key: key);

  @override
  _TestAttendScreenState createState() => _TestAttendScreenState();
}

class _TestAttendScreenState extends State<TestAttendScreen> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'quizFinished',
        onMessageReceived: (JavaScriptMessage message) {
          if (mounted) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const BottomNavScreen()),
              );
            });
          }
        },
      )
      ..loadRequest(Uri.parse(
          '${attendTest}/${widget.type}/${widget.userid}/${widget.testid}')); // Construct the URL with parameters
    debugPrint(
        '${attendTest}/${widget.type}/${widget.userid}/${widget.testid}');
  }

  Future<bool> _onWillPop() async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Exit'),
        content: const Text(
            'Are you sure you want to go back? Your test progress may be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    if (shouldPop == true && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavScreen()),
      );
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Reload',
              onPressed: () {
                _webViewController.reload();
              },
            ),
          ],
        ),
        body: WebViewWidget(controller: _webViewController),
      ),
    );
  }
}
