import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/models/experience.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/providers/users_provider.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:ask_enzo_app/widgets/MediaWidgets/custom_cached_network_image.dart';
import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:ask_enzo_app/extensions/extensions.dart';
import 'package:ask_enzo_app/providers/generic_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ask_enzo_app/data/lingue.dart';

const double heightCard = 180;
const double heightImageBox = heightCard * .7;
const double heightTextBox = heightCard * .3;

class ExperienceItemCard extends ConsumerStatefulWidget {
  const ExperienceItemCard({super.key, required this.experience});
  final UpdateExperienceModel experience;

  @override
  ConsumerState<ExperienceItemCard> createState() => _ExperienceItemCardState();
}

class _ExperienceItemCardState extends ConsumerState<ExperienceItemCard> {
  String getTitle(Languages languageApp) {
    return widget.experience.title.capitalize();
  }

  String getDifficulty(Languages languageApp) =>
      difficultyMap[widget.experience.difficultyId]!.capitalize();

  String getDuration(Languages languageApp) =>
      '${LingueExperience.experienceScreen[languageApp]?[1]} :  ${widget.experience.duration} h';

  bool isLiked(List likeList) {
    if (likeList.contains(widget.experience.id)) return true;
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<int> likeList = ref.watch(userProvider)[1];
    final languageApp = ref.watch(genericProvider)[0];
    final navigationNotifier = ref.read(navigationProvider.notifier);
    bool isExperienceLiked = isLiked(likeList);

    Future<bool?> likeHandle() async {
      setState(() {
        isExperienceLiked = !isExperienceLiked;
      });
      ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
      ref
          .read(userProvider.notifier)
          .toggleLike(scaffold, widget.experience.id);
      // Gestione lista like
      if (likeList.contains(widget.experience.id)) {
        likeList.remove(widget.experience.id);
      } else {
        likeList.add(widget.experience.id);
      }
      return true;
    }

    return SizedBox(
      child: Card(
        elevation: 20, // aumenta l'altezza dell'ombra
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: Colors.white24, width: 1),
        ),
        color: Colors.white,
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          child: InkWell(
            onTap: () => navigationNotifier.push(dettagliEsperienzaRoute,
                arguments: widget.experience),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Stack(children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(''),
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: heightImageBox,
                        child: CustomCachedNetworkImage(
                          imgPath: widget.experience.imgPreviewPath,
                        )),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Configurazione.sfondoPrezzoLike,
                        ),
                        child: CustomText(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          text: formatPrice(widget.experience.price),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: Colors.transparent,
                          height: 60,
                          width: 60,
                          child: FractionallySizedBox(
                            widthFactor: 0.55, // 50% of parent's width
                            heightFactor: 0.55, // 50% of parent's height
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Configurazione.sfondoPrezzoLike,
                              ),
                              child: LikeButton(
                                size: 20,
                                animationDuration:
                                    const Duration(milliseconds: 900),
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                likeCountPadding: EdgeInsets.zero,
                                isLiked: isExperienceLiked,
                                onTap: (value) => likeHandle(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(3),
                                color: difficultyColorMap[
                                    widget.experience.difficultyId]),
                            child: CustomText(
                              text: getDifficulty(
                                languageApp,
                              ),
                              fontSize: 12,
                              contentPaddingL: 5,
                              contentPaddingR: 5,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      CustomText(
                        text: getTitle(languageApp),
                        color: Configurazione.colorePrimario,
                        fontSize: 16,
                      ),
                      CustomText(
                        text: getDuration(languageApp),
                        color: Configurazione.colorePrimario,
                        fontSize: 12,
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
