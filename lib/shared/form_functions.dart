import 'package:ask_enzo_app/api/api_host.dart';
import 'package:ask_enzo_app/api/api_tourist.dart';
import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/models/host.dart';
import 'package:ask_enzo_app/models/tourist.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:flutter/material.dart';

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
