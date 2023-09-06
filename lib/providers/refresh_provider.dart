import 'package:ask_enzo_app/api/api_tourist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The `RefresherProvider` class is a state notifier that manages the refresh state and provides
/// methods to toggle the refresh state and refresh user data.
class RefresherProvider extends StateNotifier<bool> {
  RefresherProvider() : super(false);
  // STATES
  // 0 Refresh?

  void toggleRefresh() {
    state = !state;
  }

  void toggleRefreshUserData(ScaffoldMessengerState scaffold) {
    apiTouristGetMyInfo(scaffold);
    state = !state;
  }
}

/// This code is creating a `refresherProvider` object using the `StateNotifierProvider` class from the
/// `flutter_riverpod` package.
final refresherProvider = StateNotifierProvider<RefresherProvider, bool>((ref) {
  return RefresherProvider();
});
