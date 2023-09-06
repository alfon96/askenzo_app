import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/models/discovery.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/screens/Profiles/user_home_profile.dart';
import 'package:ask_enzo_app/widgets/AppBar/app_bar.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_elevated_button.dart';
import 'package:ask_enzo_app/widgets/Drawer/custom_drawer.dart';
import 'package:ask_enzo_app/widgets/MediaWidgets/custom_cached_network_image.dart';
import 'package:ask_enzo_app/widgets/MediaWidgets/slider_widget.dart';
import 'package:ask_enzo_app/widgets/MediaWidgets/video.dart';
import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:ask_enzo_app/extensions/extensions.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscoverDetailScreen extends ConsumerStatefulWidget {
  const DiscoverDetailScreen({super.key, required this.discovery});
  final UpdateDiscoveryModel discovery;

  @override
  ConsumerState<DiscoverDetailScreen> createState() =>
      _DiscoverDetailScreenState();
}

/// The `_DiscoverDetailScreenState` class is responsible for building the UI of the
/// DiscoverDetailScreen and handling user interactions.
class _DiscoverDetailScreenState extends ConsumerState<DiscoverDetailScreen> {
  Widget makeSlider(List<String> videoUrls) {
    List<Widget> widgetList = [];

    for (String video in videoUrls) {
      widgetList.add(PlayVideoWidget(url: video));
    }

    return SliderWidgets(widgets: widgetList);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final navigationNotifier = ref.read(navigationProvider.notifier);
        navigationNotifier.pop();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(title: widget.discovery.title.capitalize()),
        endDrawer: const CustomDrawer(),
        bottomNavigationBar: null,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 450,
                child: Center(
                  child: Swiper(
                    itemBuilder: (context, index) {
                      return CustomCachedNetworkImage(
                        imgPath: widget.discovery.imgPaths[index],
                      );
                    },
                    itemCount: widget.discovery.imgPaths.length,
                    pagination: const SwiperPagination(),
                    control: const SwiperControl(),
                    autoplay: false,
                  ),
                ),
              ),
              const SizedBox(height: spacingHeight),
              CustomText(
                text: widget.discovery.title.capitalize(),
                fontSize: 22,
                fontWeight: FontWeight.w600,
                centered: true,
                color: Configurazione.colorePrimario,
              ),
              const SizedBox(height: spacingHeight),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                      title: 'Monumenti',
                      fun: () {},
                    ),
                    const SizedBox(width: 20),
                    CustomElevatedButton(
                      title: 'Video',
                      fun: () {},
                    ),
                  ]),
              const SizedBox(height: spacingHeight / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(FontAwesomeIcons.heart),
                  ),
                  const SizedBox(width: spacingHeight),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.message),
                  ),
                ],
              ),
              const SizedBox(height: spacingHeight / 2),
              Divider(
                height: 10,
                thickness: 2,
                color: Colors.grey[400],
                indent: 20,
                endIndent: 20,
              ),
              const SizedBox(height: spacingHeight / 2),
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
              const SizedBox(height: spacingHeight / 2),
              CustomText(
                text: widget.discovery.description.capitalize(),
                maxLines: 60,
                fontSize: 15,
                fontWeight: FontWeight.w200,
                contentPaddingL: 20.0,
                contentPaddingR: 20.0,
              ),
              widget.discovery.kindId == 1 &&
                      widget.discovery.videoPaths.isNotEmpty
                  ? makeSlider(widget.discovery.videoPaths)
                  : const SizedBox(height: 10),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
