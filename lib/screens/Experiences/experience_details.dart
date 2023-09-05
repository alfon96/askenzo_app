import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/extensions/extensions.dart';
import 'package:ask_enzo_app/models/experience.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/screens/Profiles/user_home_profile.dart';
import 'package:ask_enzo_app/widgets/AppBar/app_bar.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_elevated_button.dart';
import 'package:ask_enzo_app/widgets/Drawer/custom_drawer.dart';
import 'package:ask_enzo_app/widgets/MediaWidgets/custom_cached_network_image.dart';
import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

String getAccessibilityDurationString(UpdateExperienceModel exp) {
  return exp.price.values.first == 0.0
      ? 'Accesso gratuito \nDurata ${exp.duration}'
      : 'A Pagamento \nQuota ${formatPrice(exp.price)} - Durata ${exp.duration}';
}

class ExperienceDetailScreen extends ConsumerStatefulWidget {
  const ExperienceDetailScreen({super.key, required this.experience});
  final UpdateExperienceModel experience;

  @override
  ConsumerState<ExperienceDetailScreen> createState() =>
      _ExperienceDetailScreenState();
}

class _ExperienceDetailScreenState
    extends ConsumerState<ExperienceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final navigationNotifier = ref.read(navigationProvider.notifier);
    return WillPopScope(
      onWillPop: () async {
        final navigationNotifier = ref.read(navigationProvider.notifier);
        navigationNotifier.pop();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(title: widget.experience.title),
        endDrawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 450,
                child: Swiper(
                  itemBuilder: (context, index) {
                    return CustomCachedNetworkImage(
                      imgPath: widget.experience.imgPaths[index],
                    );
                  },
                  itemCount: widget.experience.imgPaths.length,
                  pagination: const SwiperPagination(),
                  control: const SwiperControl(),
                  autoplay: false,
                ),
              ),
              const SizedBox(height: 20),
              CustomText(
                text: widget.experience.title,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                centered: true,
                color: Configurazione.colorePrimario,
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    color: difficultyColorMap[widget.experience.difficultyId],
                    child: CustomText(
                      contentPaddingL: 5,
                      contentPaddingR: 5,
                      text: difficultyMap[widget.experience.difficultyId]!
                          .capitalize(),
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CustomText(
                    text: ' - ${formatPrice(widget.experience.price)}',
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Configurazione.colorePrimario,
                  ),
                ],
              ),
              const SizedBox(height: spacingHeight),
              CustomText(
                text: getAccessibilityDurationString(widget.experience),
                fontSize: 16,
                color: Configurazione.colorePrimario,
                centered: true,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: spacingHeight),
              CustomElevatedButton(
                fun: () => navigationNotifier.push(prenotazioneEsperienzaRoute),
                title: 'Prenota',
              ),
              const SizedBox(height: spacingHeight),
              Divider(
                height: 20,
                thickness: 2,
                color: Colors.grey[400],
                indent: 20,
                endIndent: 20,
              ),
              const SizedBox(height: spacingHeight / 3),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const CustomText(
                  contentPaddingL: 20,
                  text: 'Descrizione',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Configurazione.colorePrimario,
                ),
              ),
              const SizedBox(height: spacingHeight / 4),
              CustomText(
                text: widget.experience.description.capitalize(),
                maxLines: 60,
                fontSize: 15,
                fontWeight: FontWeight.w200,
                contentPaddingL: 20.0,
                contentPaddingR: 20.0,
              ),
              const SizedBox(height: spacingHeight),
            ],
          ),
        ),
      ),
    );
  }
}
