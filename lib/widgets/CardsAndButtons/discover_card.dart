import 'package:ask_enzo_app/data/configurazione.dart';

import 'package:ask_enzo_app/models/discovery.dart';
import 'package:ask_enzo_app/providers/data_provider.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/widgets/MediaWidgets/custom_cached_network_image.dart';

import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:ask_enzo_app/extensions/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const double heightCard = 180;
const double heightImageBox = heightCard * .7;
const double heightTextBox = heightCard * .3;

class DiscoverItemCard extends ConsumerStatefulWidget {
  const DiscoverItemCard({super.key, required this.discovery});
  final UpdateDiscoveryModel discovery;

  @override
  ConsumerState<DiscoverItemCard> createState() => _DiscoverItemCardState();
}

class _DiscoverItemCardState extends ConsumerState<DiscoverItemCard> {
  // String getCategoryName(ContentCategory cat, Languages languageApp) {
  //   return LingueDiscovery.discoveryDetails[languageApp]!;
  // }
  String getDistance(Map<int, double>? listDistances) {
    if (widget.discovery.latitude == 0 && widget.discovery.longitude == 0) {
      return 'Piatto tipico';
    }
    if (listDistances == null || listDistances.isEmpty) {
      return '';
    } else {
      if (listDistances.containsKey(widget.discovery.id)) {
        return 'Distanza da te : ${listDistances[widget.discovery.id]!.toStringAsFixed(1)} km';
      } else {
        return '';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigationNotifier = ref.read(navigationProvider.notifier);
    final Map<int, double>? listDistances = ref.watch(distanceProvider);
    return SizedBox(
      child: InkWell(
        onTap: () => navigationNotifier.push(dettagliDiscoverRoute,
            arguments: widget.discovery),
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
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: heightImageBox,
                    child: CustomCachedNetworkImage(
                      imgPath: widget.discovery.imgPreviewPath,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const CustomText(
                        text: 'Punto di Interesse',
                        fontSize: 12,
                        color: Configurazione.colorePrimario,
                      ),
                      CustomText(
                        text: widget.discovery.title.capitalize(),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Configurazione.colorePrimario,
                      ),
                      CustomText(
                        text: getDistance(listDistances),
                        fontSize: 12,
                        color: Configurazione.colorePrimario,
                      ),
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
