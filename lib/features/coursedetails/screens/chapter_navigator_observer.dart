import 'package:flutter/material.dart';

class ChapterNavigatorObserver extends NavigatorObserver {
  final ValueNotifier<bool> canPopNotifier;

  ChapterNavigatorObserver(this.canPopNotifier);

  void _updateCanPop(NavigatorState navigator) {
    canPopNotifier.value = navigator.canPop();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _updateCanPop(navigator!);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _updateCanPop(navigator!);
  }
}