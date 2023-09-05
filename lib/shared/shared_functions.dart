import 'dart:async';
import 'dart:convert';

import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/data/lingue.dart';
import 'package:ask_enzo_app/main.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/screens/Forms/login_screen.dart';
import 'package:ask_enzo_app/screens/home.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_elevated_button.dart';
import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

Future<String?> getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  return '${position.latitude} ${position.longitude}';
}

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

String encodePassword(String password) {
  var bytes = utf8.encode(password); // Converti la stringa in bytes
  var digest = sha256.convert(bytes); // Genera l'hash SHA-256
  return digest.toString(); // Restituisci l'hash come stringa
}

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

void showOfflineInfoBottomSheet(
    BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return showInfoBottomSheet(
      scaffoldKey.currentContext!,
      // Use the GlobalKey's context here
      'Attualmente il dispositivo è offline, questa funzione è disabilitata.');
}

void runFunctionIfOnline(Function fun, bool isDeviceOnline,
    BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  if (isDeviceOnline) {
    fun();
  } else {
    showOfflineInfoBottomSheet(context, scaffoldKey);
  }
}

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

bool checkRouteName() {
  if (routeNames.isNotEmpty) {
    if (routeNames.last == loginRoute) {
      return false;
    }
  }
  return true;
}

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

String getFileNameWithExtension(String imagePath) {
  final lastIndex = imagePath.lastIndexOf('/');
  if (lastIndex != -1 && lastIndex < imagePath.length - 1) {
    return imagePath.substring(lastIndex + 1);
  }
  return '';
}
