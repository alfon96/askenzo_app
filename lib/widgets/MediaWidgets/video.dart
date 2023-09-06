import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

/// The `PlayVideoWidget` class is a stateful widget that represents a video player widget with a given
/// URL.
class PlayVideoWidget extends StatefulWidget {
/// The `SliderWidgets` class is a stateful widget that represents a collection of widgets that can be
/// displayed in a slider.
  const PlayVideoWidget({super.key, required this.url});
  final String url;

  @override
  State<PlayVideoWidget> createState() => _PlayVideoWidgetState();
}

/// The `_PlayVideoWidgetState` class is a stateful widget that displays a video player using the
/// `PodVideoPlayer` widget and handles the initialization and disposal of the `PodPlayerController`.
class _PlayVideoWidgetState extends State<PlayVideoWidget> {
  late final PodPlayerController controller;
  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(widget.url),
      podPlayerConfig: const PodPlayerConfig(
        videoQualityPriority: [720, 360],
        autoPlay: false,
      ),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: PodVideoPlayer(
        backgroundColor: Colors.white,
        onLoading: (context) =>
            const Center(child: CircularProgressIndicator()),
        onVideoError: () {
          return const CustomText(
            text: 'Problemi di caricamento del video.',
            color: Configurazione.colorePrimario,
            centered: true,
            fontSize: 17,
          );
        },
        controller: controller,
        matchVideoAspectRatioToFrame: true,
        matchFrameAspectRatioToVideo: true,
      ),
    );
  }
}
