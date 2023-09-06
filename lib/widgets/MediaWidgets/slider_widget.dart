import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ask_enzo_app/data/configurazione.dart';

/// The `CarouselWithIndicator` class is a stateful widget that displays a carousel of images with an
/// indicator, and has an option to display a logo.
class SliderWidgets extends StatefulWidget {
  const SliderWidgets({
    super.key,
    required this.widgets,
  });

  final List<Widget> widgets;
  @override
  State<StatefulWidget> createState() {
    return _SliderWidgetsState();
  }
}
/// The _SliderWidgetsState class is a stateful widget in Dart.

class _SliderWidgetsState extends State<SliderWidgets> {
/// The `_CarouselWithIndicatorState` class is a stateful widget that displays a carousel of images with
/// indicators and a logo.
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.red),
        Column(
          children: [
            CarouselSlider(
              items: widget.widgets,
              carouselController: _controller,
              options: CarouselOptions(
                  autoPlay: false,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  height: 450,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.widgets.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.light
                                ? Configurazione.coloreDotsDarkMode
                                : Configurazione.coloreDotsLightMode)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }
}
