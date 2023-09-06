import 'package:ask_enzo_app/api/api.dart';
import 'package:ask_enzo_app/api/api_host.dart';
import 'package:ask_enzo_app/api/api_tourist.dart';
import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/models/host.dart';
import 'package:ask_enzo_app/models/tourist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The `enum UserStates` is defining an enumeration called `UserStates` with two possible values:
/// `userData` and `likeList`. This enumeration is used to represent different states of the user in the
/// application. It can be used to determine which data should be displayed or which actions should be
/// performed based on the current state of the user.
enum UserStates {
  userData,
  likeList,
}

/// The `UserProvider` class is a state notifier that handles user authentication, login, logout, and
/// updating user data.
class UserProvider extends StateNotifier<List> {
  UserProvider()
      : super([
          null,
          [0]
        ]);
// Da cambiare inizializzazione da debugUser a null, TO DO
  Future<bool> login(
    ScaffoldMessengerState scaffold, {
    bool isTourist = true,
    String email = '',
    String password = '',
  }) async {
    if (isTourist) {
      if (await apiTouristLogin(
        scaffold,
        email: email,
        password: password,
      )) {
        // Update headers to send the received token in the following api requests.
        List state = await loginUtility(scaffold);

        updateState(state);
        return true;
      }
    } else {
      if (await apiHostLogin(scaffold, email: email, password: password)) {
        // Update headers to send the received token in the foloeing api requests.
        updateHeaders();
        // Get host data to be used to display their home page.
        Host? userData = await apiHostGetMyInfo(scaffold);

        updateState([userData, null]);
      }
    }
    return false;
  }

  Future<List> loginUtility(ScaffoldMessengerState scaffold) async {
    updateHeaders();
    List<int> likes = await apiTouristGetMyLikes(scaffold);
    Tourist? userData = await apiTouristGetMyInfo(scaffold);

    return [userData, likes];
  }

  void getLikeList(ScaffoldMessengerState scaffold) async {
    List<int> likes = await apiTouristGetMyLikes(scaffold);
    updateState([state[0], likes]);
  }

  void toggleLike(ScaffoldMessengerState scaffold, int experienceId) async {
    await apiTouristToggleLike(scaffold, experienceId: experienceId);
    //List<int> likes = await apiTouristGetMyLikes(scaffold);
    updateState([state[0], state[1]]);
  }

  Future<List<int>> refreshUserLikes(ScaffoldMessengerState scaffold) async {
    List<int> likes = await apiTouristGetMyLikes(scaffold);

    updateState([state[0], likes]);
    return likes;
  }

  void toggleRefreshUserData(ScaffoldMessengerState scaffold) async {
    Tourist? userData = await apiTouristGetMyInfo(scaffold);

    updateState([userData, state[1]]);
  }

  void logout() {
    kAuthentication.jwt = null;
    // This line must go after kAuthentication.jwt update.
    updateHeaders();

    state = [null];
  }

  void updateState(List nextState) {
    state = nextState;
  }
}

/// The code `final userProvider = StateNotifierProvider<UserProvider, List>((ref) {
///   return UserProvider();
/// });` is creating a `StateNotifierProvider` named `userProvider`. This provider is responsible for
/// managing the state of the user in the application. It takes two type parameters: `UserProvider` as
/// the state notifier class and `List` as the type of state that will be managed.
final userProvider = StateNotifierProvider<UserProvider, List>((ref) {
  return UserProvider();
});

/// The code `Tourist debugUser = Tourist(...)` is creating an instance of the `Tourist` class and
/// assigning it to the variable `debugUser`. This instance represents a tourist user with specific
/// properties such as email, image profile, name, surname, state ID, and telephone number. It is likely
/// used for debugging or testing purposes.
Tourist debugUser = Tourist(
    email: 'grizzo@gmail.com',
    imgProfile: 'null',
    name: 'Giulia',
    stateId: 1,
    surname: 'Rizzo',
    telephone: '395948241846');
