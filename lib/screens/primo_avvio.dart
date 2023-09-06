import 'package:ask_enzo_app/main.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_elevated_button.dart';
import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:ask_enzo_app/widgets/MediaWidgets/slider_immagini.dart';
import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:flutter/services.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The `PrimoAvvio` class represents the initial screen of an app and displays a carousel of images, a
/// welcome message, and a button to start exploring the app.
class PrimoAvvio extends ConsumerWidget {
  const PrimoAvvio({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationNotifier = ref.read(navigationProvider.notifier);
    globalScreenWidth = MediaQuery.of(context).size.width;
    globalScreenHeight = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .65,
            child: CarouselWithIndicator(
              imgList: createWidgetList4SliderFromsAsset(
                  Configurazione.imgListAssets),
              logo: true,
            ),
          ),
          const CustomText(
            text: 'Benvenuto',
            color: Configurazione.colorePrimario,
            fontSize: 60,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: const CustomText(
              text:
                  'Scopri Brindisi con Ask Enzo per visitare la città e rendere unico il tuo soggiorno.\n',
              centered: true,
            ),
          ),
          const Spacer(),
          CustomElevatedButton(
            title: 'Start Discovering',
            fun: () => navigationNotifier.pushReplacement('/home'),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
