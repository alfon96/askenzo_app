import 'package:ask_enzo_app/api/api_host.dart';
import 'package:ask_enzo_app/api/api_tourist.dart';
import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/models/host.dart';
import 'package:ask_enzo_app/models/tourist.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:flutter/material.dart';

/// The `saveItem` function saves a `TouristRegister` or `HostRegister` object and handles the
/// appropriate actions based on the type of object.
/// 
/// Args:
///   scaffold (ScaffoldMessengerState): The scaffold parameter is of type ScaffoldMessengerState, which
/// is used to show snackbars or other messages to the user.
///   tourist (TouristRegister): An optional parameter of type TouristRegister, which represents the
/// details of a tourist.
///   host (HostRegister): The `host` parameter is of type `HostRegister`, which represents the
/// registration information for a host.
///   navigationNotifier: The `navigationNotifier` is a notifier object that is used to notify the UI
/// when the navigation needs to be updated or changed. It is typically used to navigate to a different
/// screen or update the current screen based on the result of the save operation.
Future<void> saveItem(
  ScaffoldMessengerState scaffold,
  TouristRegister? tourist,
  HostRegister? host,
  navigationNotifier,
) async {
  if (tourist != null) {
    await touristHandle(scaffold, tourist, navigationNotifier);
  } else if (host != null) {
    await hostHandle(scaffold, host, navigationNotifier);
  }
}

/// The function `touristHandle` handles the registration process for a tourist, displaying a success
/// message and navigating to the home route if the registration is successful.
/// 
/// Args:
///   scaffold (ScaffoldMessengerState): The scaffold parameter is the state of the ScaffoldMessenger
/// widget. It is used to show snackbar messages.
///   tourist (TouristRegister): A nullable TouristRegister object that represents the tourist being
/// registered.
///   navigationNotifier: It seems like `navigationNotifier` is an object that is responsible for
/// managing the navigation within the app. It might have methods like `pushReplacement` to navigate to
/// a new screen and replace the current screen in the navigation stack.
Future<void> touristHandle(
  ScaffoldMessengerState scaffold,
  TouristRegister? tourist,
  navigationNotifier,
) async {
  if (tourist != null) {
    if (await apiTouristRegister(scaffold, tourist: tourist)) {
      showCustomSnackBar(scaffold, 'Registrazione avvenuta con successo.');
      navigationNotifier.pushReplacement(homeRoute);
    }
  }
}

/// The `hostHandle` function registers a host using an API call, shows a success message, and navigates
/// to the home route.
/// 
/// Args:
///   scaffold (ScaffoldMessengerState): The `scaffold` parameter is of type `ScaffoldMessengerState`
/// and is used to show a snackbar message.
///   host (HostRegister): The `host` parameter is of type `HostRegister?`, which means it can either be
/// `null` or an instance of the `HostRegister` class.
///   navigationNotifier: The `navigationNotifier` is an object that is responsible for managing the
/// navigation within the application. It is used to push and replace routes in the application's
/// navigation stack.
Future<void> hostHandle(
  ScaffoldMessengerState scaffold,
  HostRegister? host,
  navigationNotifier,
) async {
  if (host != null) {
    if (await apiHostRegister(scaffold, host: host)) {
      showCustomSnackBar(scaffold, 'Registrazione avvenuta con successo.');
      navigationNotifier.pushReplacement(homeRoute);
    }
  }
}
