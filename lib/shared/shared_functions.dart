import 'dart:async';
import 'dart:convert';

import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/data/lingue.dart';
import 'package:ask_enzo_app/main.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/screens/Forms/login_screen.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_elevated_button.dart';
import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

/// The function `getLocation` returns a `Future` that resolves to a string representing the latitude
/// and longitude of the current position.
/// 
/// Returns:
///   The method is returning a String that represents the latitude and longitude of the current
/// position.
Future<String?> getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  return '${position.latitude} ${position.longitude}';
}

/// The function takes a list of image assets and returns a list of widgets, each containing an image
/// from the asset.
/// 
/// Args:
///   imgList: The `imgList` parameter is a list of image paths or URLs.
/// 
/// Returns:
///   a list of Widgets.
List<Widget> createWidgetList4SliderFromsAsset(imgList) {
  return imgList
      .map<Widget>(
        (item) => Container(
          width: double.infinity,
          color: Colors.grey,
          margin: const EdgeInsets.only(
            top: 0,
          ),
          child: Image.asset(
            item,
            fit: BoxFit.fill,
            errorBuilder: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      )
      .toList();
}

/// The function `formatPrice` takes a map of prices and formats them as a string with the currency
/// symbol and decimal places.
/// 
/// Args:
///   priceMap (Map<String, double>): A map that contains the prices of different items. The keys in the
/// map represent the names of the items, and the values represent their corresponding prices.
/// 
/// Returns:
///   a formatted string representing the prices in the given priceMap.
String formatPrice(Map<String, double> priceMap) {
  String result = "";
  priceMap.forEach((key, price) {
    if (price == 0.0) result = "Free";
    final format = NumberFormat("#,##0.00", "it_EU");

    String formattedPrice = format.format(price);

    // Rimuove la parte decimale se è .00
    if (formattedPrice.endsWith(".00")) {
      formattedPrice = formattedPrice.substring(0, formattedPrice.length - 3);
    }

    result = ' $formattedPrice $key';
  });
  return result;
}

// FORM FUNCTIONS
/// The function `isEmailValid` checks if an email is valid and returns an error message if it is not.
/// 
/// Args:
///   email (String): The email address to be validated. It is of type String? which means it can be
/// either a valid email address or null.
///   languageApp (Languages): The `languageApp` parameter is an optional parameter of type `Languages`
/// with a default value of `Languages.italiano`. It is used to specify the language for the validation
/// error message. Defaults to Languages
/// 
/// Returns:
///   The function isEmailValid returns a String value. If the email is valid, it returns null. If the
/// email is null or invalid, it returns a validation error message in the specified language.
String? isEmailValid(String? email,
    {Languages languageApp = Languages.italiano}) {
  if (email == null) {
    return LingueValidazioneForm.testoValidazione[languageApp]![0];
  }

  String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regex = RegExp(pattern);

  if (regex.hasMatch(email)) {
    return null;
  } else {
    return LingueValidazioneForm.testoValidazione[languageApp]![0];
  }
}

/// The function `isPasswordValid` checks if a password meets certain criteria and returns an error
/// message if it does not.
/// 
/// Args:
///   password (String): The password parameter is a nullable String that represents the password to be
/// validated.
///   languageApp (Languages): The `languageApp` parameter is an optional parameter of type `Languages`
/// with a default value of `Languages.italiano`. It is used to specify the language for the validation
/// error message. Defaults to Languages
/// 
/// Returns:
///   a String value. If the password is valid according to the specified pattern, the function returns
/// null. Otherwise, it returns a validation error message in the specified language.
String? isPasswordValid(String? password,
    {Languages languageApp = Languages.italiano}) {
  if (password == null) {
    return LingueValidazioneForm.testoValidazione[languageApp]![1];
  }

  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9].*?[0-9]).{8,}$';
  RegExp regex = RegExp(pattern);

  if (regex.hasMatch(password)) {
    return null;
  } else {
    return LingueValidazioneForm.testoValidazione[languageApp]![1];
  }
}

/// The function checks if the confirmation password matches the input password and returns an error
/// message if they don't match.
/// 
/// Args:
///   inputPassword (String): The input password that the user entered.
///   confirmationPassword (String): The `confirmationPassword` parameter is a nullable String that
/// represents the password entered by the user for confirmation.
///   languageApp (Languages): The `languageApp` parameter is an optional parameter of type `Languages`
/// with a default value of `Languages.italiano`. It is used to specify the language for the validation
/// message. Defaults to Languages
/// 
/// Returns:
///   a String value.
String? isConfirmationPasswordValid(
    String inputPassword, String? confirmationPassword,
    {Languages languageApp = Languages.italiano}) {
  if (confirmationPassword == null) {
    return LingueValidazioneForm.testoValidazione[languageApp]![2];
  }
  if (inputPassword.trim() == confirmationPassword.trim()) {
    return null;
  } else {
    return LingueValidazioneForm.testoValidazione[languageApp]![2];
  }
}

/// The function `isNameSurnameValid` checks if a given name or surname is valid by using a regular
/// expression pattern.
/// 
/// Args:
///   name (String): A nullable String representing a name or surname.
///   languageApp (Languages): The `languageApp` parameter is an optional parameter of type `Languages`
/// with a default value of `Languages.italiano`. It is used to specify the language for the validation
/// error message. Defaults to Languages
/// 
/// Returns:
///   a String value.
String? isNameSurnameValid(String? name,
    {Languages languageApp = Languages.italiano}) {
  if (name == null) {
    return LingueValidazioneForm.testoValidazione[languageApp]![3];
  }
  String pattern = r'^[a-zA-Z ]+$';
  RegExp regex = RegExp(pattern);
  if (regex.hasMatch(name)) {
    return null;
  } else {
    return LingueValidazioneForm.testoValidazione[languageApp]![3];
  }
}

/// The function `isPhoneNumberValid` checks if a phone number is valid and returns an error message if
/// it is not.
/// 
/// Args:
///   phone (String): A nullable String representing a phone number.
///   languageApp (Languages): The `languageApp` parameter is an optional parameter of type `Languages`
/// with a default value of `Languages.italiano`. It is used to specify the language for the validation
/// error message. Defaults to Languages
/// 
/// Returns:
///   a String value.
String? isPhoneNumberValid(String? phone,
    {Languages languageApp = Languages.italiano}) {
  if (phone == null) {
    return LingueValidazioneForm.testoValidazione[languageApp]![4];
  }
  RegExp regex = RegExp(r'^\d{9,}$');

  if (regex.hasMatch(phone)) {
    return null;
  } else {
    return LingueValidazioneForm.testoValidazione[languageApp]![4];
  }
}

/// The function `encodePassword` takes a password as input, converts it to bytes, generates a SHA-256
/// hash, and returns the hash as a string.
/// 
/// Args:
///   password (String): The parameter "password" is a string that represents the password that needs to
/// be encoded.
/// 
/// Returns:
///   the SHA-256 hash of the input password as a string.
String encodePassword(String password) {
  var bytes = utf8.encode(password); // Converti la stringa in bytes
  var digest = sha256.convert(bytes); // Genera l'hash SHA-256
  return digest.toString(); // Restituisci l'hash come stringa
}

/// The function `showDecisionDialog` displays an AlertDialog with custom text and buttons, and returns
/// a Future<bool> that completes with true or false based on the user's decision.
/// 
/// Args:
///   context (BuildContext): The `BuildContext` object represents the location in the widget tree where
/// the dialog should be shown. It is typically obtained from the `BuildContext` parameter in the
/// `build` method of a widget.
///   dialogText (List<String>): A list of strings containing the text to be displayed in the dialog.
/// The list should have four elements in the following order:
/// 
/// Returns:
///   The function `showDecisionDialog` returns a `Future<bool>`.
Future<bool> showDecisionDialog(BuildContext context, List<String> dialogText) {
  Completer<bool> completer = Completer<bool>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: CustomText(
          text: dialogText[0],
          isTitle: true,
          fontSize: 18,
        ),
        content: SizedBox(
          height: 120,
          child: Center(
            child: CustomText(
              text: dialogText[1],
              centered: true,
            ),
          ),
        ),
        actions: <Widget>[
          CustomElevatedButton(
            title: dialogText[2],
            fun: () => completer.complete(false),
            bkgColor: const Color.fromARGB(255, 141, 141, 141),
          ),
          CustomElevatedButton(
            bkgColor: Colors.blue,
            fun: () => completer.complete(true),
            title: dialogText[3],
          ),
        ],
      );
    },
  );

  return completer.future;
}

/// The function `showInfoBottomSheet` displays a modal bottom sheet with a custom message.
/// 
/// Args:
///   context (BuildContext): The `BuildContext` is a required parameter in Flutter that represents the
/// location in the widget tree where the bottom sheet will be shown. It is typically obtained from the
/// `BuildContext` of the current widget.
///   message (String): The `message` parameter is a string that represents the text message to be
/// displayed in the bottom sheet.
/// 
/// Returns:
///   a showModalBottomSheet widget.
void showInfoBottomSheet(BuildContext context, String message) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: Container(
          color: Configurazione.colorePrimario,
          padding: const EdgeInsets.all(5.0),
          height: 90,
          child: Center(
            child: CustomText(
              text: message,
              color: Colors.white,
            ),
          ),
        ),
      );
    },
  );
}

/// The function `showOfflineInfoBottomSheet` shows a bottom sheet with an offline message using a given
/// `BuildContext` and `GlobalKey<ScaffoldState>`.
/// 
/// Args:
///   context (BuildContext): The current build context of the widget tree.
///   scaffoldKey (GlobalKey<ScaffoldState>): A GlobalKey<ScaffoldState> that is used to access the
/// ScaffoldState of the current Scaffold widget. This is necessary to show the bottom sheet within the
/// scaffold.
/// 
/// Returns:
///   the result of calling the `showInfoBottomSheet` function.
void showOfflineInfoBottomSheet(
    BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return showInfoBottomSheet(
      scaffoldKey.currentContext!,
      // Use the GlobalKey's context here
      'Attualmente il dispositivo è offline, questa funzione è disabilitata.');
}

/// The function `runFunctionIfOnline` checks if the device is online and runs a given function if it
/// is, otherwise it shows an offline information bottom sheet.
/// 
/// Args:
///   fun (Function): The `fun` parameter is a function that will be executed if the device is online.
///   isDeviceOnline (bool): A boolean value indicating whether the device is currently online or not.
///   context (BuildContext): The BuildContext is an object that represents the location of a widget
/// within the widget tree. It is typically used to access the theme, media query, and other properties
/// of the current app.
///   scaffoldKey (GlobalKey<ScaffoldState>): The scaffoldKey is a GlobalKey<ScaffoldState> that is used
/// to access the state of a Scaffold widget. It is typically used to show snackbars or bottom sheets
/// within the scaffold.
void runFunctionIfOnline(Function fun, bool isDeviceOnline,
    BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  if (isDeviceOnline) {
    fun();
  } else {
    showOfflineInfoBottomSheet(context, scaffoldKey);
  }
}

/// The `showCustomSnackBar` function displays a custom SnackBar with an optional login button and a
/// close button.
/// 
/// Args:
///   scaffoldMessenger (ScaffoldMessengerState): The scaffoldMessenger parameter is of type
/// ScaffoldMessengerState and is used to show and hide the snackbar within the scaffold widget.
///   message (String): The message parameter is a string that represents the text content of the
/// SnackBar. It is the main message that will be displayed to the user.
///   forceLink (bool): The `forceLink` parameter is a boolean value that determines whether to show a
/// login button in the snackbar. If `forceLink` is set to `true`, the login button will be displayed
/// regardless of the authentication status. If `forceLink` is set to `false` (default value. Defaults
/// to false
void showCustomSnackBar(
    ScaffoldMessengerState scaffoldMessenger, String message,
    {bool forceLink = false}) {
  // Questa variabile serve per capire quando è necessario mostrare il pulsante di login
  bool isAdditionalInfo =
      kAuthentication.jwt == null && checkRouteName() || forceLink;

  scaffoldMessenger.hideCurrentSnackBar();
  scaffoldMessenger.showSnackBar(
    SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(11),
          topRight: Radius.circular(11),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      backgroundColor: Configurazione.colorePrimario,
      content: SizedBox(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: isAdditionalInfo
                  ? globalScreenWidth * .62
                  : globalScreenWidth * .8,
              child: Center(
                child: CustomText(
                  text: message,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
            //const Spacer(),
            if (isAdditionalInfo)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    scaffoldMessenger.hideCurrentSnackBar();
                    routeNames.add(loginRoute);
                    globalNavigatorKey.currentState?.push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: CustomText(
                      text: 'Accedi',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            IconButton(
              splashRadius: 25,
              iconSize: 20,
              padding: EdgeInsets.zero,
              onPressed: () => scaffoldMessenger.hideCurrentSnackBar(),
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}

/// The function checks if the last route name in a list is equal to a specific login route name and
/// returns true if it is not.
/// 
/// Returns:
///   a boolean value.
bool checkRouteName() {
  if (routeNames.isNotEmpty) {
    if (routeNames.last == loginRoute) {
      return false;
    }
  }
  return true;
}

/// The function `singleLinkHealthCheck` checks the health of a single link by making an HTTP GET
/// request and returning `true` if the response status code is less than 400, otherwise it returns
/// `false`.
/// 
/// Args:
///   url (String): The `url` parameter is a string that represents the URL of the link that needs to be
/// checked for health.
/// 
/// Returns:
///   a `Future<bool>`.
Future<bool> singleLinkHealthCheck(String url) async {
  try {
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode < 400) {
      return true;
    }
  } catch (e) {
    return false;
  }
  return false;
}

/// The function `getFileNameWithExtension` takes an image path as input and returns the file name with
/// extension.
/// 
/// Args:
///   imagePath (String): The imagePath parameter is a string that represents the path of an image file.
/// 
/// Returns:
///   the file name with extension from the given image path.
String getFileNameWithExtension(String imagePath) {
  final lastIndex = imagePath.lastIndexOf('/');
  if (lastIndex != -1 && lastIndex < imagePath.length - 1) {
    return imagePath.substring(lastIndex + 1);
  }
  return '';
}
