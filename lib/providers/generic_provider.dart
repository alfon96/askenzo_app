import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ask_enzo_app/data/lingue.dart';
import 'package:ask_enzo_app/models/countries.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// The `enum States` is defining an enumeration that represents the different states or choices that
/// can be made in the application. In this case, it defines two states: `language` and `country`. These
/// states are used to access specific elements in the state list of the `GenericProvider` class. By
/// using an enum, it provides a more readable and type-safe way to access these elements.
enum States {
  language,
  country,
}

/// The `GenericProvider` class is a state notifier that manages the language and country choices, and
/// provides a method to check if the device is online.
class GenericProvider extends StateNotifier<List> {
  GenericProvider()
      : super([
          Languages.italiano,
          countries[107],
        ]);

  bool toggleLanguageChoice(Languages language) {
    if (state[1] != language) {
      state = [
        language,
        state[States.country.index],
      ];
      toggleOnChosenLanguage(language);
      return true;
    }
    return false;
  }

  void toggleOnChosenLanguage(Languages language) {
    // Italy : 107
    // United Kingdom : 233
    // France :  73
    // Germany : 80

    if (language == Languages.italiano) {
      toggleChosenCountry(countries[107]);
    } else if (language == Languages.english) {
      toggleChosenCountry(countries[233]);
    } else if (language == Languages.french) {
      toggleChosenCountry(countries[73]);
    } else {
      toggleChosenCountry(countries[80]);
    }
  }

  bool toggleChosenCountry(Country country) {
    if (state[0] != country) {
      state = [
        state[States.language.index],
        country,
      ];

      return true;
    }
    return false;
  }

  Future<bool> isDeviceOnline() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}

/// The code `final genericProvider = StateNotifierProvider<GenericProvider, List>((ref) { return
/// GenericProvider(); });` is creating a provider called `genericProvider` using the
/// `StateNotifierProvider` class from the `flutter_riverpod` package.
final genericProvider = StateNotifierProvider<GenericProvider, List>((ref) {
  return GenericProvider();
});
