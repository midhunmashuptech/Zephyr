import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/home/screens/home_screen.dart';
import 'package:zephyr/features/home/widgets/home_course_card.dart';

class AttendAiTestScreen extends StatefulWidget {
  final String userid;
  final String questionsCount;
  final String className;
  final String subject;
  final String chapter;
  final String topic;
  final String difficulty;

  const AttendAiTestScreen({
    Key? key,
    required this.userid,
    required this.questionsCount,
    required this.className,
    required this.subject,
    required this.chapter,
    required this.topic,
    required this.difficulty,
  }) : super(key: key);

  @override
  _AttendAiTestScreenState createState() => _AttendAiTestScreenState();
}

class _AttendAiTestScreenState extends State<AttendAiTestScreen> {
  late final WebViewController _webViewController;
  bool _isLoading = true;

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
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(
          '${attendAiTest}/${widget.userid}/${widget.questionsCount}/${widget.className}/${widget.subject}/${widget.chapter}/${widget.topic}/${widget.difficulty}'));
    debugPrint(
        '${attendAiTest}/${widget.userid}/${widget.questionsCount}/${widget.className}/${widget.subject}/${widget.chapter}/${widget.topic}/${widget.difficulty}');
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
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: WebViewWidget(controller: _webViewController),
            ),
            if (_isLoading)
              Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            Positioned(
              top: MediaQuery.of(context).padding.top - 6,
              left: 22,
              child: SafeArea(
                child: ClipOval(
                  child: Material(
                    color: Colors.white.withOpacity(0.85),
                    child: InkWell(
                      onTap: () async {
                        final shouldPop = await _onWillPop();
                        if (shouldPop) Navigator.of(context).maybePop();
                      },
                      child: const SizedBox(
                        width: 44,
                        height: 44,
                        child: Icon(Icons.arrow_back, color: Colors.black87),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
