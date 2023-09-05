import 'package:flutter/material.dart';

// Queste variaili servono per fare in modo di ritornare alla pagina precedente a quella del login,
// esse sarebbero state delle variabili osservate tramite provider, però questa architettura avrebbe fatto aggiornare le pagine
// prima di effettuare la navigazione.

var kColorScheme =
    ColorScheme.fromSeed(seedColor: Configurazione.colorePrimario);

// ROUTES //
const String primoAvvioRoute = '/';
const String contenutiRoute = '/contenuti';
const String homeRoute = '/home';
const String discoverRoute = '/discover';
// users
const String loginRoute = '/login';
const String registratiHomeRoute = '/registrati_home';
const String registratiUserRoute = '/registrati_user';
const String registratiHostRoute = '/registrati_host';
//const String registratiGuideRoute = '/select_profile';
const String recuperoPasswordRoute = '/recupero_password';
// esperienze
const String listaEsperienzeRoute = '/lista_esperienze';
const String dettagliEsperienzaRoute = '/dettagli_esperienza';
const String prenotazioneEsperienzaRoute = '/prenotazione_esperienza';
// discover
const String homeDiscoverRoute = '/home_discover';
const String listaDiscoverRoute = '/lista_discover';
const String dettagliDiscoverRoute = '/dettagli_discover';
// drawer
const String aboutUsRoute = '/about_us';
const String privacyRoute = '/privacy';
const String terminiUsoRoute = '/termini_uso';
// profile pages
const String editProfileRoute = '/EditProfileScreen';
const String editServicesRoute = '/EditProfileScreen';
const String bookedExperiencesRoute = '/EditProfileScreen';
const String changePasswordRoute = '/ChangePasswordScreen';
const String segnalazioniRoute = '/EditProfileScreen';
const String deleteAccountRoute = '/DeleteProfile';
const String userHomeRoute = '/userHomeScreen';

// CONFIGURAZIONE ASPETTO WIDGET //
class Configurazione {
  static const Color colorePrimario = Color.fromARGB(255, 37, 69, 90);
  static const Color coloreBackgroundPulsanti = Color.fromARGB(255, 37, 69, 90);
  static const Color coloreFontPulsanti = Colors.white;

  static const Color coloreBackgroundPulsantiLight =
      Color.fromARGB(255, 255, 255, 255);

  static const Color coloreForegroundPulsanti = Colors.white;
  static const Color coloreBackground = Color.fromARGB(255, 255, 255, 255);
  static const Color coloreDotsDarkMode = Color.fromARGB(255, 37, 69, 90);
  static const Color coloreDotsLightMode = Color.fromARGB(255, 37, 69, 90);
  static const Color coloreBoxDecoration = Color.fromARGB(255, 230, 175, 46);

  static const Color coloreBoxBackgroundAskEnzoContenuti = Color(0xFF3F4045);
  static const Color coloreBoxBackgroundExperiencesContenuti =
      Color(0xFF02111B);
  static const Color coloreBoxBackgroundDiscoverContenuti = Color(0xFF30292F);

  static const Color coloreBodyFont = Color.fromARGB(255, 37, 69, 90);
  static const double fontSizeTitleSmall = 17.0;
  static const double fontSizeTitleMedium = 24.0;
  static const double fontSizeTitleLarge = 56.0;

  static const double fontSizeBodySmall = 15.0;
  static const double fontSizeBodyMedium = 25.0;
  static const double fontSizeBodyLarge = 42.0;

  static const FontWeight fontWeightTitleSmall = FontWeight.w300;
  static const FontWeight fontWeightTitleMedium = FontWeight.w500;
  static const FontWeight fontWeightTitleLarge = FontWeight.w700;

  static const String fontFamilyTitle = 'PoppinsBold';
  static const String fontFamilyBody = 'PoppinsBlack';
  // FORMS
  static const Color coloreIconeInactive = Color.fromARGB(255, 122, 122, 122);
  static const Color coloreIconeActive = Color.fromARGB(255, 64, 137, 185);

  // Widget Esperienze
  // Font
  static const Color sfondoPrezzoLike = Color.fromARGB(206, 255, 255, 255);
  static const double fontSizeBodySmallExperience = 13.0;
  static const double fontSizeBodyMediumExperience = 13.0;
  static const double fontSizeBodyLargeExperience = 17.0;

  static const FontWeight fontWeightBodySmallExperience = FontWeight.w700;
  static const FontWeight fontWeightBodyMediumExperience = FontWeight.w700;
  static const FontWeight fontWeightBodyLargeExperience = FontWeight.w700;

  static const Color coloreBodySmallExperience = Colors.black;
  static const Color coloreBodyMediumExperience = Colors.black;
  static const Color coloreBodyLargeExperience = Colors.redAccent;

  // Widget Detail Experience Screens
  static const double fontSizeTitleSmallDetailExperience = 13.0;
  static const double fontSizeTitleMediumDetailExperience = 13.0;
  static const double fontSizeTitleLargeDetailExperience = 17.0;

  static const double fontSizeBodySmallDetailExperience = 13.0;
  static const double fontSizeBodyMediumDetailExperience = 13.0;
  static const double fontSizeBodyLargeDetailExperience = 17.0;

  static const FontWeight fontWeightBodySmallDetailExperience = FontWeight.w700;
  static const FontWeight fontWeightBodyMediumDetailExperience =
      FontWeight.w500;
  static const FontWeight fontWeightBodyLargeDetailExperience = FontWeight.w700;

  static const Color coloreBodySmallDetailExperience = Colors.black;
  static const Color coloreBodyMediumDetailExperience = Colors.black;
  static const Color coloreBodyLargeDetailExperience = Colors.redAccent;

  // Immagini di anteprima nella schermata home dell'app:
  static const List<String> imgListAssets = [
    'assets/images/primo_avvio/slider_1.jpg',
    'assets/images/primo_avvio/slider_2.jpg',
    'assets/images/primo_avvio/slider_3.jpg',
    'assets/images/primo_avvio/slider_4.jpg',
    'assets/images/primo_avvio/slider_5.jpg',
    'assets/images/primo_avvio/slider_6.jpg',
    'assets/images/primo_avvio/slider_7.jpg',
    'assets/images/primo_avvio/slider_8.jpg',
  ];

  // Pagina home user
  static const Color coloreDeleteAccount = Color.fromARGB(255, 221, 94, 74);

  static const String username = 'askenzo_admin';
  static const String password = 'askenzo_admin123';
  static const String apiAdminLoginURL = '$basePath/admin/login';
  static const String pathsDelimiter = ';';
  static const String basePath = 'https://a4ac-143-225-33-145.eu.ngrok.io';

  // EXPERIENCE ROUTES
  static const String apiCreateExperienceURL = '$basePath/experiences/new';
  static const String apiUpdateExperienceURL = '$basePath/experiences/update';
  static const String apiGetExperienceURL = '$basePath/experiences/single';
  static const String apiGetExperienceListURL = '$basePath/experiences/list';
  static const String apiDeleteExperienceURL = '$basePath/experiences/delete';
  // DISCOVERY ROUTES
  static const String apiCreateDiscoveryURL = '$basePath/discoveries/new';
  static const String apiUpdateDiscoveryURL = '$basePath/discoveries/update';
  static const String apiGetDiscoveryURL = '$basePath/discoveries/single';
  static const String apiGetDiscoveryListURL = '$basePath/discoveries/list';
  static const String apiDeleteDiscoveryURL = '$basePath/discoveries/delete';
  static const String apiGetDiscoveriesDistancesURL =
      '$basePath/discoveries/distance';
  // POPUP ROUTES
  static const String apiCreatePopupURL = '$basePath/popup/new';
  static const String apiUpdatePopupURL = '$basePath/popup/update';
  static const String apiGetPopupURL = '$basePath/popup/single';
  static const String apiGetPopupListURL = '$basePath/popup/list';
  static const String apiDeletePopupURL = '$basePath/popup/delete';
  // TOURIST
  static const String apiTouristGetMyInfo = '$basePath/tourist/me';
  static const String apiTouristUpdatePassword =
      '$basePath/tourist/update_my_password';
  static const String apiTouristUpdateInfo = '$basePath/tourist/update_my_info';
  static const String apiTouristRegister = '$basePath/tourist/register_me';
  static const String apiTouristLogin = '$basePath/tourist/login';
  static const String apiTouristDeleteMe = '$basePath/tourist/delete_me';
  static const String apiTouristGetMyLikes = '$basePath/tourist/my_likes_list';
  static const String apiTouristToggleLike = '$basePath/tourist/new_like';
// HOST
  static const String apiHostGetMyInfo = '$basePath/host/me';
  static const String apiHostUpdatePassword =
      '$basePath/host/update_my_password';
  static const String apiHostUpdateInfo = '$basePath/host/update_my_info';
  static const String apiHostRegister = '$basePath/host/register_me';
  static const String apiHostLogin = '$basePath/host/login';
  static const String apiHostDeleteMe = '$basePath/host/delete_me';
  // IMAGES
  static const String apiPostImage = '$basePath/images/new';
  static const String apiUpdateImage = '$basePath/images/update';
  static const String apiDeleteImage = '$basePath/images/delete';
}

Map<int, String> statesMap = {1: 'active', 2: 'inactive'};

Map<int, String> difficultyMap = {1: 'easy', 2: 'medium', 3: 'hard'};

Map<int, String> currencyMap = {1: '\$', 2: '€'};

Map<int, String> discoveryKindsMap = {
  1: 'Video',
  2: 'Food',
  3: 'Monuments',
  4: 'Hotels'
};

Map<int, Color> difficultyColorMap = {
  1: Colors.green,
  2: Colors.orange,
  3: Colors.red,
};

class Authentication {
  Authentication({this.jwt});
  String? jwt;
}

// PROD
Authentication kAuthentication = Authentication();
// DEBUG
// Authentication kAuthentication = Authentication(
//     jwt:
//         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo0OSwicm9sZSI6IlRvdXJpc3QiLCJleHAiOjE2ODY3MzY1NTB9.Dql1j90GXMqoUhF1qpZjphsiWOn7bAgEUlp9LTOb7_M');
