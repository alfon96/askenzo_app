import 'package:ask_enzo_app/models/data.dart';
import 'package:ask_enzo_app/models/discovery.dart';
import 'package:ask_enzo_app/models/experience.dart';
import 'package:ask_enzo_app/models/tourist.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/screens/AskEnzoInfo/about_us.dart';
import 'package:ask_enzo_app/screens/Discover/discover_detail_screen.dart';
import 'package:ask_enzo_app/screens/Discover/discover_home_page.dart';
import 'package:ask_enzo_app/screens/Discover/discover_screen.dart';
import 'package:ask_enzo_app/screens/Experiences/experience_details.dart';
import 'package:ask_enzo_app/screens/Forms/login_screen.dart';
import 'package:ask_enzo_app/screens/Forms/prenotazione_esperienza.dart';
import 'package:ask_enzo_app/screens/Forms/recupero_password.dart';
import 'package:ask_enzo_app/screens/Forms/register_host_screen.dart';
import 'package:ask_enzo_app/screens/Forms/register_user_screen.dart';
import 'package:ask_enzo_app/screens/Profiles/change_password.dart';
import 'package:ask_enzo_app/screens/Profiles/delete_account.dart';
import 'package:ask_enzo_app/screens/Profiles/edit_profile.dart';
import 'package:ask_enzo_app/screens/Profiles/user_home_profile.dart';
import 'package:ask_enzo_app/screens/TermsAndConditions/privacy.dart';
import 'package:ask_enzo_app/screens/TermsAndConditions/terms_of_use.dart';
import 'package:ask_enzo_app/screens/UserAccess/seleziona_profilo.dart';
import 'package:ask_enzo_app/screens/contenuti.dart';
import 'package:ask_enzo_app/screens/experiences/experience_screen.dart';
import 'package:ask_enzo_app/screens/home.dart';
import 'package:ask_enzo_app/screens/primo_avvio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ask_enzo_app/data/configurazione.dart';

double globalScreenWidth = 0;
double globalScreenHeight = 0;

/// The `main` function in Dart initializes the app and sets up the navigation and theme for the
/// `AskEnzo` widget.
void main() async {
  runApp(const ProviderScope(child: AskEnzo()));
}

/// The `AskEnzo` class is a Dart class that builds a MaterialApp widget with various theme
/// configurations and routes for different screens in an application.
class AskEnzo extends ConsumerWidget {
  const AskEnzo({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationNotifier = ref.read(navigationProvider.notifier);
    globalNavigatorKey = navigationNotifier.navigatorKey;
    return WillPopScope(
      onWillPop: () async {
        navigationNotifier.pop();
        return false; // Return false to prevent the default pop behavior
      },
      child: MaterialApp(
        
        navigatorKey: navigationNotifier.navigatorKey,
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Configurazione.colorePrimario,
            ),
          ),
          scaffoldBackgroundColor:
              Colors.white, // set the background color for the scaffold
          appBarTheme: const AppBarTheme(
            color: Color.fromARGB(
                255, 12, 86, 146), // set the background color for the app bar
            iconTheme: IconThemeData(
              color: Colors.white, // set the color for the icons in the app bar
            ),
          ),

          textTheme: const TextTheme(
            bodySmall: TextStyle(
              fontFamily: 'Poppins',
              color: Color.fromARGB(
                  255, 255, 3, 3), // set the default text color for the body
              fontSize: 12.0, // set the default font size for the body
            ),
            bodyMedium: TextStyle(
              fontFamily: 'Poppins',
              color: Color.fromARGB(
                  255, 0, 0, 0), // set the default text color for the body
              fontSize: 16.0, // set the default font size for the body
            ),
            titleSmall: TextStyle(
              fontFamily: 'Poppins',
              color: Color.fromARGB(
                  255, 12, 86, 146), // set the font size for subtitle text
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
            titleMedium: TextStyle(
              fontFamily: 'Poppins',
              color: Color.fromARGB(
                  255, 12, 86, 146), // set the font size for subtitle text
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
            titleLarge: TextStyle(
              fontFamily: 'Poppins',
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 54,
            ),
          ),

          listTileTheme: const ListTileThemeData(
              dense: true,
              textColor: Color.fromARGB(255, 0, 25, 46),
              style: ListTileStyle.drawer),
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor:
                Color.fromARGB(255, 246, 248, 250), // Set the background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  top:
                      Radius.circular(16.0)), // Set the shape and corner radius
            ),
          ),
        ),
        home: const PrimoAvvio(),
        routes: {
          // bottomBar
          contenutiRoute: (context) => const ScreenContenuti(),
          homeRoute: (context) => HomePage(
              index: ModalRoute.of(context)!.settings.arguments as int?),
          discoverRoute: (context) => const DiscoverHome(),
          // users
          loginRoute: (context) => const LoginScreen(),
          registratiHomeRoute: (context) => const SelectProfileScreen(),
          registratiUserRoute: (context) => const RegisterUserScreen(),
          registratiHostRoute: (context) => const RegisterHostScreen(),
          recuperoPasswordRoute: (context) => const RecuperoPassword(),
          // esperienze
          listaEsperienzeRoute: (context) => const ExperiencesScreen(),
          dettagliEsperienzaRoute: (context) => ExperienceDetailScreen(
              experience: ModalRoute.of(context)!.settings.arguments
                  as UpdateExperienceModel),
          prenotazioneEsperienzaRoute: (context) =>
              const FormPrenotazioniEsperienze(),
          //discover
          homeDiscoverRoute: (context) => const DiscoverHome(),
          listaDiscoverRoute: (context) => DiscoverScreen(
              selectedCategory: ModalRoute.of(context)!.settings.arguments
                  as ContentCategory),
          dettagliDiscoverRoute: (context) => DiscoverDetailScreen(
              discovery: ModalRoute.of(context)!.settings.arguments
                  as UpdateDiscoveryModel),
          //drawer
          aboutUsRoute: (context) => const AboutUsScreen(),
          privacyRoute: (context) => const PrivacyScreen(),
          terminiUsoRoute: (context) => const TermsOfUseScreen(),
          // profile pages

          editProfileRoute: (context) => EditProfileScreen(
              user: ModalRoute.of(context)!.settings.arguments as Tourist),
          changePasswordRoute: (context) => ChangePasswordScreen(
              user: ModalRoute.of(context)!.settings.arguments as Tourist),
          userHomeRoute: (context) => UserHomeProfile(
              user: ModalRoute.of(context)!.settings.arguments as Tourist),
          deleteAccountRoute: (context) => const DeleteProfile(),

          // editServicesRoute: (context) => const PrivacyScreen(),
          // bookedExperiencesRoute: (context) => const TermsOfUseScreen(),
          // changePasswordRoute: (context) => const AboutUsScreen(),
          // segnalazioniRoute: (context) => const PrivacyScreen(),
          //
        },
        // final navigationNotifier = ref.read(navigationProvider.notifier);
        // navigationNotifier.push(prenotazioneEsperienzaRoute),
        // navigationNotifier.pop(context),
      ),
    );
  }
}
