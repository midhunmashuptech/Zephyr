import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/test_series/screens/test_attended_screen.dart';
import 'package:zephyr/features/test_series/screens/test_ongoing_screen.dart';
import 'package:zephyr/features/test_series/screens/test_upmoning_screen.dart';
import 'package:zephyr/features/test_series/widgets/test_tab_button.dart';

class TestSeriesScreen extends StatefulWidget {
  const TestSeriesScreen({super.key});

  @override
  State<TestSeriesScreen> createState() => _TestSeriesScreenState();
}

class _TestSeriesScreenState extends State<TestSeriesScreen> {
  int selectedIndex = 0;
  late final PageController _pageController;

  final List<Widget> tabs = const [
    TestOngoingScreen(),
    TestUpmoningScreen(),
    TestAttendedScreen(),
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
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                        'Test Series',
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
                          color: AppColors.primaryGreen,
                        ),
                        TabButton(
                          label: 'Upcoming',
                          selected: selectedIndex == 1,
                          onTap: () => _onTabSelected(1),
                          color: AppColors.primaryOrange,
                        ),
                        TabButton(
                          label: 'Attended',
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
