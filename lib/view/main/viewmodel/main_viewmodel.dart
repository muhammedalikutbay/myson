import 'package:flutter/material.dart';

class MainViewModel extends ChangeNotifier {
  int _currentIndex = 0; // Home is default
  int get currentIndex => _currentIndex;

  final Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
  };

  void setIndex(int index) {
    if (_currentIndex == index) {
      // If tapping the same tab, pop to the root of that tab
      navigatorKeys[index]?.currentState?.popUntil((route) => route.isFirst);
      return;
    }
    _currentIndex = index;
    notifyListeners();
  }

  Future<bool> handleWillPop() async {
    final currentNavigator = navigatorKeys[_currentIndex]?.currentState;
    if (currentNavigator == null) return true;

    if (currentNavigator.canPop()) {
      currentNavigator.pop();
      return false; // Handled back press internally
    }
    return true; // Let system handle exit if at root of tab
  }
}
