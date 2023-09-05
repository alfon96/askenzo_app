import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/data/lingue.dart';
import 'package:ask_enzo_app/providers/data_provider.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/screens/Profiles/user_home_profile.dart';
import 'package:ask_enzo_app/widgets/AppBar/app_bar.dart';
import 'package:ask_enzo_app/widgets/Drawer/custom_drawer.dart';
import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:speech_balloon/speech_balloon.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_flat_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ask_enzo_app/providers/generic_provider.dart';
import 'package:ask_enzo_app/models/data.dart';

final random = Random();

const double btnHeight = 150;
const double spacing = 20;

class DiscoverHome extends ConsumerStatefulWidget {
  const DiscoverHome({super.key});

  @override
  ConsumerState<DiscoverHome> createState() => _DiscoverHomeState();
}

class _DiscoverHomeState extends ConsumerState<DiscoverHome> {
  bool showPopUp = true;

  @override
  Widget build(BuildContext context) {
    ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);

    final languageApp = ref.watch(genericProvider)[0];
    final navigationNotifier = ref.read(navigationProvider.notifier);
    ref.read(distanceProvider.notifier).fetchData(scaffold);

    return WillPopScope(
      onWillPop: () async {
        final navigationNotifier = ref.read(navigationProvider.notifier);
        navigationNotifier.pop();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(title: LingueDiscovery.linguaAppBar[languageApp]!),
        endDrawer: const CustomDrawer(),
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: spacingHeight),
                    CustomFlatButton(
                      btnText: LingueDiscovery.discoveryScreen[languageApp]?[0],
                      btnFunction: () => navigationNotifier.push(
                          listaDiscoverRoute,
                          arguments: ContentCategory.video),
                      btnHeight: btnHeight,
                      btnUrl:
                          'https://i0.wp.com/www.pugliavacanze.eu/wp-content/uploads/2021/05/Brindisi-Puglia.jpg?fit=550%2C367&ssl=1',
                    ),
                    const SizedBox(height: spacingHeight),
                    CustomFlatButton(
                      btnText: LingueDiscovery.discoveryScreen[languageApp]?[1],
                      btnFunction: () => navigationNotifier.push(
                          listaDiscoverRoute,
                          arguments: ContentCategory.food),
                      btnHeight: btnHeight,
                      btnUrl:
                          'https://www.guidapuglia.it/wp-content/uploads/2020/03/pesce-crudo-brindisi-1024x680.jpg',
                    ),
                    const SizedBox(height: spacingHeight),
                    CustomFlatButton(
                      btnText: LingueDiscovery.discoveryScreen[languageApp]?[2],
                      btnFunction: () => navigationNotifier.push(
                          listaDiscoverRoute,
                          arguments: ContentCategory.monuments),
                      btnHeight: btnHeight,
                      btnUrl:
                          'https://www.italyra.com/wp-content/uploads/2018/09/gallery-2-monumento-marinaio-brindisi-italyra.jpg',
                    ),
                    const SizedBox(height: spacingHeight),
                    CustomFlatButton(
                      btnText: LingueDiscovery.discoveryScreen[languageApp]?[3],
                      btnFunction: () => navigationNotifier.push(
                          listaDiscoverRoute,
                          arguments: ContentCategory.hotels),
                      btnHeight: btnHeight,
                      btnUrl:
                          'https://digital.ihg.com/is/image/ihg/smith-brindisi-7528491113-4x3',
                    ),
                    const SizedBox(height: spacingHeight * 2),
                  ],
                ),
              ),
              Positioned(
                bottom: -45,
                left: -20,
                child: FakePopUp(appLanguage: languageApp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FakePopUp extends ConsumerWidget {
  const FakePopUp({super.key, required this.appLanguage});
  final Languages appLanguage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
    final popupProvided = ref.read(popupProvider.notifier);

    return SizedBox(
      height: 200,
      width: 300,
      child: Row(children: [
        Row(
          children: [
            SizedBox(
              height: 120,
              width: 90,
              child: Image.asset(
                'assets/images/logo/logo_ask_enzo.png',
                fit: BoxFit.scaleDown,
              ),
            ),
            SpeechBalloon(
              width: 200,
              nipLocation: NipLocation.left,
              borderColor: Colors.black,
              color: Colors.white,
              borderRadius: 10,
              borderWidth: 1,
              child: Container(
                height: 80,
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child: FutureBuilder(
                    future: popupProvided.getOne(scaffold),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const CustomText(
                          contentPaddingL: 5,
                          contentPaddingR: 5,
                          text:
                              'Sapevi che a Brindisi ci sono molti monumenti?',
                          maxLines: 5,
                          color: Colors.black,
                          fontSize: 11,
                        );
                      }
                      if (snapshot.hasData) {
                        return CustomText(
                          text: snapshot.data,
                          maxLines: 5,
                          contentPaddingL: 5,
                          contentPaddingR: 5,
                          color: Colors.black,
                          fontSize: 11,
                        );
                      } else {
                        return const CustomText(
                          contentPaddingL: 5,
                          contentPaddingR: 5,
                          text:
                              'Sapevi che a Brindisi ci sono molti monumenti?',
                          maxLines: 5,
                          color: Colors.black,
                          fontSize: 11,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
