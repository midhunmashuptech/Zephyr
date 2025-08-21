import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/live_class/screens/live_ongoing.dart';
import 'package:zephyr/features/live_class/screens/live_recording_screen.dart';
import 'package:zephyr/features/live_class/screens/live_upcoming.dart';
import 'package:zephyr/features/test_series/widgets/test_tab_button.dart';

class LiveTabviewDetails extends StatefulWidget {
  const LiveTabviewDetails({super.key});

  @override
  State<LiveTabviewDetails> createState() => _LiveTabviewDetailsState();
}

class _LiveTabviewDetailsState extends State<LiveTabviewDetails> {
  int selectedIndex = 0;
  late final PageController _pageController;

  final List<Widget> tabs = const [
    LiveOngoing(),
    LiveUpcoming(),
    LiveRecordingScreen()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void _onTabSelected(int index) {
    setState(() => selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Iconify(
                        MaterialSymbols.design_services,
                        color: AppColors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Live Classes',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        TabButton(
                          label: 'Ongoing',
                          selected: selectedIndex == 0,
                          onTap: () => _onTabSelected(0),
                          color: AppColors.primaryBlue,
                        ),
                        TabButton(
                          label: 'Upcoming',
                          selected: selectedIndex == 1,
                          onTap: () => _onTabSelected(1),
                          color: AppColors.primaryBlue,
                        ),
                        TabButton(
                          label: 'Recordings',
                          selected: selectedIndex == 2,
                          onTap: () => _onTabSelected(2),
                          color: AppColors.primaryBlue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => selectedIndex = index);
                },
                children: tabs,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
