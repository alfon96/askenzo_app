import 'package:ask_enzo_app/api/api_tourist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

final refresherProvider = StateNotifierProvider<RefresherProvider, bool>((ref) {
  return RefresherProvider();
});
