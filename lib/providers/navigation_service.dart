import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
List<String> routeNames = [];

class NavigationState {
  String currentRoute;
  Object? arguments;
  NavigationState(this.currentRoute, this.arguments);
}

class NavigationNotifier extends StateNotifier<NavigationState> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationNotifier()
      : navigatorKey = GlobalKey<NavigatorState>(),
        super(NavigationState('/', null)); // Assuming '/' is your initial route

  void push(String routeName, {Object? arguments}) {
    if (state.currentRoute == routeName && state.arguments == arguments) return;

    state = NavigationState(routeName, arguments);
    navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);

    // Information to be stored
    routeNames.add(routeName);
    globalNavigatorKey = navigatorKey;
  }

  void pushReplacement(String routeName, {Object? arguments}) {
    state = NavigationState(routeName, arguments);
    navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);

    // Information to be stored
    routeNames.add(routeName);
    globalNavigatorKey = navigatorKey;
  }

  void pop({Object? result}) {
    if (!navigatorKey.currentState!.canPop()) {
      showExitConfirmationDialog();

      // Information to be stored
      if (routeNames.isNotEmpty) {
        routeNames.removeLast();
      }
      globalNavigatorKey = navigatorKey;
    }

    navigatorKey.currentState!.pop(result);
    state = NavigationState('', null);
    // Note: You'll need to manage updating state.currentRoute when a pop occurs.
    // This is non-trivial since Flutter's Navigator doesn't provide an easy way to get the previous route.
  }

  NavigationState getState() {
    return state;
  }

  Future<bool> showExitConfirmationDialog() async {
    return await showDialog(
          context: navigatorKey.currentContext!,
          builder: (context) => AlertDialog(
            backgroundColor: const Color.fromARGB(255, 224, 224, 224),
            title: const Center(
              child: CustomText(
                text: 'Vuoi uscire dall\'applicazione?',
                centered: true,
                color: Configurazione.colorePrimario,
                fontSize: 18,
              ),
            ),
            actions: <Widget>[
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      state = NavigationState('/', null);
                    },
                    child: const CustomText(
                      text: 'No',
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      state = NavigationState('/', null);
                    },
                    child: const CustomText(
                      text: 'Sì',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ) ??
        false; // Ritorna false se l'utente preme al di fuori del dialogo
  }
}

final navigationProvider =
    StateNotifierProvider<NavigationNotifier, NavigationState>(
        (ref) => NavigationNotifier());
