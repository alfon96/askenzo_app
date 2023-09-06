import 'package:ask_enzo_app/data/lingue.dart';
import 'package:ask_enzo_app/extensions/extensions.dart';
import 'package:ask_enzo_app/models/discovery.dart';
import 'package:ask_enzo_app/providers/data_provider.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/screens/home.dart';
import 'package:ask_enzo_app/widgets/AppBar/app_bar.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_elevated_button.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/discover_card.dart';
import 'package:ask_enzo_app/widgets/Drawer/custom_drawer.dart';
import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:ask_enzo_app/models/data.dart';
import 'package:ask_enzo_app/providers/generic_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The DiscoverScreen class is a stateful widget that displays content based on a selected category.
class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({
    super.key,
    required this.selectedCategory,
  });

  final ContentCategory selectedCategory;

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

/// The `_DiscoverScreenState` class is responsible for building the UI of the DiscoverScreen widget,
/// including the app bar, end drawer, and a list of discovery items fetched from the server.
class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  String getTitle(Languages languageApp) {
    int index = LingueDiscovery.discoveryScreen[Languages.english]!
        .indexOf(widget.selectedCategory.name.capitalize());
    return LingueDiscovery.discoveryScreen[languageApp]?[index];
  }

  @override
  Widget build(BuildContext context) {
    ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
    final languageApp = ref.watch(genericProvider)[0];
    return WillPopScope(
      onWillPop: () async {
        final navigationNotifier = ref.read(navigationProvider.notifier);
        navigationNotifier.pop();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(title: getTitle(languageApp)),
        endDrawer: const CustomDrawer(),
        body: FutureBuilder(
            future: ref
                .read(discoveryProvider.notifier)
                .fetchData(scaffold, widget.selectedCategory.index + 1),
            builder: (BuildContext context,
                AsyncSnapshot<List<UpdateDiscoveryModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text:
                            'Errore nella richiesta al server, \nDettaglio errore: ${snapshot.error}',
                        centered: true,
                      ),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                        title: 'Torna alla Home',
                        fun: () =>
                            globalNavigatorKey.currentState?.pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                List<UpdateDiscoveryModel> experiences = snapshot.data!;

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    itemBuilder: (context, item) {
                      return DiscoverItemCard(
                        discovery: experiences[item],
                      );
                    },
                    itemCount: experiences.length,
                  ),
                );
              }
            }),
      ),
    );
  }
}
