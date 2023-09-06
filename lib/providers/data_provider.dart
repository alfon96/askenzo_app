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

/// The `ExperienceNotifier` class is a state notifier that fetches experience data and updates its
/// state accordingly.
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

/// The code `final experienceProvider = StateNotifierProvider<ExperienceNotifier,
/// List<UpdateExperienceModel>>((ref) {
///   return ExperienceNotifier();
/// });` is creating a provider called `experienceProvider` using the `StateNotifierProvider` class.
final experienceProvider =
    StateNotifierProvider<ExperienceNotifier, List<UpdateExperienceModel>>(
        (ref) {
  return ExperienceNotifier();
});

// DISCOVERY

/// The `DiscoveryNotifier` class is a state notifier that fetches discovery data and updates its state
/// accordingly.
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

/// The code `final discoveryProvider = StateNotifierProvider<DiscoveryNotifier,
/// List<UpdateDiscoveryModel>>((ref) {
///   return DiscoveryNotifier();
/// });` is creating a provider called `discoveryProvider` using the `StateNotifierProvider` class.
final discoveryProvider =
    StateNotifierProvider<DiscoveryNotifier, List<UpdateDiscoveryModel>>((ref) {
  return DiscoveryNotifier();
});

// DISTANCE PROVIDER
/// The `DistanceNotifier` class is a state notifier that fetches distance data and updates its state
/// with the fetched data.
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

/// The code `final distanceProvider = StateNotifierProvider<DistanceNotifier, Map<int, double>>((ref) {
///   return DistanceNotifier();
/// });` is creating a provider called `distanceProvider` using the `StateNotifierProvider` class.
final distanceProvider =
    StateNotifierProvider<DistanceNotifier, Map<int, double>>((ref) {
  return DistanceNotifier();
});

// POPUP

/// The `PopupNotifier` class is a state notifier that fetches popup data and provides a method to
/// retrieve a random popup text.
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

/// The code `final popupProvider = StateNotifierProvider<PopupNotifier, PopupModel?>((ref) {
///   return PopupNotifier();
/// });` is creating a provider called `popupProvider` using the `StateNotifierProvider` class.
final popupProvider = StateNotifierProvider<PopupNotifier, PopupModel?>((ref) {
  return PopupNotifier();
});

// CONNECTIVITY

/// The `ConnectivityNotifier` class is a state notifier that checks the device's connectivity and
/// updates its state accordingly.
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

/// The code `final connectivityProvider = StateNotifierProvider<ConnectivityNotifier, bool>((ref) {
/// return ConnectivityNotifier(); });` is creating a provider called `connectivityProvider` using the
/// `StateNotifierProvider` class.
final connectivityProvider =
    StateNotifierProvider<ConnectivityNotifier, bool>((ref) {
  return ConnectivityNotifier();
});
