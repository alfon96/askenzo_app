import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/data/lingue.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/providers/users_provider.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:flutter/material.dart';
import 'package:ask_enzo_app/widgets/cardsandbuttons/elevated_button_with_bck_img.dart';
import 'package:ask_enzo_app/widgets/cardsandbuttons/text_button_with_bck_img.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ask_enzo_app/providers/generic_provider.dart';

/// The class `ScreenContenuti` is a stateful widget that extends `ConsumerStatefulWidget` in Dart.
class ScreenContenuti extends ConsumerStatefulWidget {
  const ScreenContenuti({super.key});

  @override
  ConsumerState<ScreenContenuti> createState() => _ScreenContenutiState();
}

/// The `_ScreenContenutiState` class is a stateful widget that builds the UI for the `ScreenContenuti`
/// screen, displaying different buttons and handling navigation based on user login status.
class _ScreenContenutiState extends ConsumerState<ScreenContenuti> {
  @override
  Widget build(BuildContext context) {
    final heightAskEnzo = MediaQuery.of(context).size.height * .425;
    final heightDiscover = MediaQuery.of(context).size.height * .15;
    final spaceBetweenWidgets = MediaQuery.of(context).size.height * .035;
    final heightExperiences = heightDiscover;
    final languageApp = ref.watch(genericProvider)[0];
    final navigationNotifier = ref.read(navigationProvider.notifier);
    final bool isLoggedIn = ref.watch(userProvider)[0] != null;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: [
              ElevatedButtonBackground(
                height: heightAskEnzo,
                width: double.infinity,
                backgroundImagePath: 'assets/images/contenuti/ask_enzo.jpg',
                btnBackgroundColor:
                    Configurazione.coloreBoxBackgroundAskEnzoContenuti,
                btnFunction: () {},
                btnText: LingueScreenContenuti.contenuti[languageApp]?[0],
                opacity: .4,
              ),
              SizedBox(
                height: spaceBetweenWidgets,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  children: [
                    TextButtonBackground(
                      height: heightDiscover,
                      width: double.infinity,
                      backgroundImagePath:
                          'assets/images/contenuti/discover_brindisi.jpg',
                      btnBackgroundColor:
                          Configurazione.coloreBoxBackgroundDiscoverContenuti,
                      btnFunction: () {
                        isLoggedIn
                            ? navigationNotifier.push(homeDiscoverRoute)
                            : showCustomSnackBar(ScaffoldMessenger.of(context),
                                'Login necessario',
                                forceLink: true);
                      },
                      btnText: LingueScreenContenuti.contenuti[languageApp]?[1],
                      opacity: .4,
                      fontSize: 23,
                    ),
                    SizedBox(
                      height: spaceBetweenWidgets,
                    ),
                    TextButtonBackground(
                      height: heightExperiences,
                      width: double.infinity,
                      backgroundImagePath:
                          'assets/images/contenuti/experiences.jpg',
                      btnBackgroundColor: Configurazione
                          .coloreBoxBackgroundExperiencesContenuti,
                      btnFunction: () {
                        isLoggedIn
                            ? navigationNotifier.push(listaEsperienzeRoute)
                            : showCustomSnackBar(ScaffoldMessenger.of(context),
                                'Login necessario',
                                forceLink: true);
                      },
                      btnText: LingueScreenContenuti.contenuti[languageApp]?[2],
                      opacity: .4,
                      fontSize: 23,
                    ),
                    SizedBox(
                      height: spaceBetweenWidgets,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
