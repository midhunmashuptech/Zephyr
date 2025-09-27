// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:zephyr/constants/config.dart';

// class TestWebview extends StatefulWidget {
//   const TestWebview({super.key});

//   @override
//   State<TestWebview> createState() => _TestWebviewState();
// }

// class _TestWebviewState extends State<TestWebview> {
//   late final WebViewController _testController;
//   bool _isLoading = true;
//   @override
//   void initState() {
//     super.initState();
//     _testController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (url) {
//             setState(() => _isLoading = true);
//           },
//           onPageFinished: (url) {
//             setState(() => _isLoading = false);
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(testUrl));
    
//   }
//   Future<void> _handleRefresh() async {
//     await _testController.reload();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             RefreshIndicator(
//               onRefresh: _handleRefresh,
//               child: WebViewWidget(controller: _testController),
//             ),
//             if (_isLoading)
//               const Center(child: CircularProgressIndicator()),
//           ],
//         ),
//       ),
//     );
//   }
// }
