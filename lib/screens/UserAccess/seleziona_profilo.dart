import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/widgets/AppBar/app_bar.dart';
import 'package:ask_enzo_app/widgets/Drawer/custom_drawer.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const double spacing = 10;
const double btnHeight = 250;

class SelectProfileScreen extends ConsumerWidget {
  const SelectProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationNotifier = ref.read(navigationProvider.notifier);
    return Scaffold(
      appBar: const CustomAppBar(title: 'Ask Enzo'),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Seleziona profilo',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(height: spacing),
            CustomFlatButton(
              btnText: 'Tourist',
              btnFunction: () =>
                  navigationNotifier.push(registratiUserRoute),
              btnHeight: btnHeight,
              btnUrl:
                  'https://i0.wp.com/racolblegal.com/wp-content/uploads/2016/10/o-TOURIST-facebook.jpg?resize=768%2C384',
              borderRadius: 20,
            ),
            const SizedBox(height: spacing),
            CustomFlatButton(
              btnText: 'Host',
              btnFunction: () =>
                  navigationNotifier.push(registratiHostRoute),
              btnHeight: btnHeight,
              btnUrl:
                  'https://book.bestwestern.it/IT/immagini/98382/6d5246bd-ead4-45bd-a858-3c6f09e82193/mgp/best-western-hotel-nettuno---brindisi.jpg',
              borderRadius: 20,
            ),
          ]),
        ),
      ),
    );
  }
}
