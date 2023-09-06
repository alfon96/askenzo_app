
import 'package:ask_enzo_app/models/experience.dart';
import 'package:ask_enzo_app/providers/data_provider.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/providers/users_provider.dart';
import 'package:ask_enzo_app/widgets/AppBar/app_bar.dart';
import 'package:ask_enzo_app/widgets/Drawer/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/experience_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ask_enzo_app/providers/generic_provider.dart';
import 'package:ask_enzo_app/data/lingue.dart';

/// The `ExperiencesScreen` class is a widget that displays a list of experiences fetched from a server
/// and allows the user to interact with them.
class ExperiencesScreen extends ConsumerStatefulWidget {
  const ExperiencesScreen({super.key});

  @override
  ConsumerState<ExperiencesScreen> createState() => _ExperiencesScreenState();
}

/// The `_ExperiencesScreenState` class is responsible for building the UI of the ExperiencesScreen
/// widget in a Flutter app, including fetching data from a server and displaying it in a ListView.
class _ExperiencesScreenState extends ConsumerState<ExperiencesScreen> {
  @override
  Widget build(BuildContext context) {
    ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
    ref
        .read(userProvider.notifier)
        .refreshUserLikes(ScaffoldMessenger.of(context));
    final languageApp = ref.watch(genericProvider)[0];

    return WillPopScope(
      onWillPop: () async {
        final navigationNotifier = ref.read(navigationProvider.notifier);
        navigationNotifier.pop();
        return false;
      },
      child: Scaffold(
        appBar:
            CustomAppBar(title: LingueExperience.linguaAppBar[languageApp]!),
        endDrawer: const CustomDrawer(),
        body: FutureBuilder(
            future: ref.read(experienceProvider.notifier).fetchData(scaffold),
            builder: (BuildContext context,
                AsyncSnapshot<List<UpdateExperienceModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                  'Errore nella richiesta al server, \nDettaglio errore: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ));
              } else {
                List<UpdateExperienceModel> experiences = snapshot.data!;
                
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    itemBuilder: (context, item) {
                      return ExperienceItemCard(
                        experience: experiences[item],
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
