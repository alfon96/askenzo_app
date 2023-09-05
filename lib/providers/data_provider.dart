import 'package:ask_enzo_app/api/api.dart';
import 'package:ask_enzo_app/models/discovery.dart';
import 'package:ask_enzo_app/models/experience.dart';
import 'package:ask_enzo_app/models/popup.dart';
import 'package:ask_enzo_app/screens/Discover/discover_home_page.dart';
import 'package:ask_enzo_app/shared/position_handling.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// EXPERIENCE

class ExperienceNotifier extends StateNotifier<List<UpdateExperienceModel>> {
  ExperienceNotifier() : super([]);

  Future<List<UpdateExperienceModel>> fetchData(
      ScaffoldMessengerState scaffold) async {
    final experiences =
        await getExperienceList(scaffold, cursor: 0, limit: 200);
    if (experiences != null) {
      state = experiences;
      return state;
    } else {
      state = [];
      return experiences ?? [];
    }
  }
}

final experienceProvider =
    StateNotifierProvider<ExperienceNotifier, List<UpdateExperienceModel>>(
        (ref) {
  return ExperienceNotifier();
});

// DISCOVERY

class DiscoveryNotifier extends StateNotifier<List<UpdateDiscoveryModel>> {
  DiscoveryNotifier() : super([]);

  Future<List<UpdateDiscoveryModel>> fetchData(
      ScaffoldMessengerState scaffold, int category,
      {bool all = false}) async {
    final discoveries = await getDiscoveryList(scaffold,
        cursor: 0, limit: 200, category: category);
    if (discoveries != null) {
      state = discoveries;
      return state;
    } else {
      state = [];
      return discoveries ?? [];
    }
  }
}

//final String? userLocation = await getLocation();

final discoveryProvider =
    StateNotifierProvider<DiscoveryNotifier, List<UpdateDiscoveryModel>>((ref) {
  return DiscoveryNotifier();
});

// DISTANCE PROVIDER
class DistanceNotifier extends StateNotifier<Map<int, double>> {
  DistanceNotifier() : super({});

  Future<Map<int, double>?> fetchData(
    ScaffoldMessengerState scaffold,
  ) async {
    bool isPermitted = await handlePermission();
    if (isPermitted) {
      String? userPosition = await getLocation();

      Map<int, double>? distances = await getDistanceDiscoveriesList(scaffold,
          userPosition: userPosition!);
      if (distances != null) {
        state = distances;
      }
      return state;
    }
     return null;
  }
  
}

//final String? userLocation = await getLocation();

final distanceProvider =
    StateNotifierProvider<DistanceNotifier, Map<int, double>>((ref) {
  return DistanceNotifier();
});

// POPUP

class PopupNotifier extends StateNotifier<PopupModel?> {
  PopupNotifier() : super(null);

  Future<PopupModel?> fetchData(ScaffoldMessengerState scaffold) async {
    final popups = await getPopupList(scaffold, cursor: 0, limit: 200);
    if (popups != null) {
      state = popups;
      return popups;
    }
    state = null;
    return null;
  }

  Future<String?> getOne(ScaffoldMessengerState scaffold) async {
    fetchData(scaffold);
    if (state != null) {
      return state!.text[random.nextInt(state!.text.length)];
    }
    return null;
  }
}

final popupProvider = StateNotifierProvider<PopupNotifier, PopupModel?>((ref) {
  return PopupNotifier();
});

// CONNECTIVITY

class ConnectivityNotifier extends StateNotifier<bool> {
  ConnectivityNotifier() : super(false);

  void checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      state = false;
    } else {
      state = true;
    }
  }
}

final connectivityProvider =
    StateNotifierProvider<ConnectivityNotifier, bool>((ref) {
  return ConnectivityNotifier();
});
