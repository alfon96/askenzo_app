import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ask_enzo_app/data/configurazione.dart';

class CarouselWithIndicator extends StatefulWidget {
  const CarouselWithIndicator({
    super.key,
    required this.imgList,
    this.logo = false,
  });
  final List<Widget> imgList;
  final bool logo;
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
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
        Column(
          children: [
            CarouselSlider(
              items: widget.imgList,
              carouselController: _controller,
              options: CarouselOptions(
                  autoPlay: true,
                  // aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  enlargeCenterPage: false,
                  height: MediaQuery.of(context).size.height * .6,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imgList.asMap().entries.map((entry) {
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
        if (widget.logo)
          Positioned(
            right: 0,
            bottom: 40,
            child: GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  if (details.primaryVelocity! > 0) {
                    // Swipe right
                    _controller.previousPage();
                  } else if (details.primaryVelocity! < 0) {
                    // Swipe left
                    _controller.nextPage();
                  }
                },
                child: Image.asset('assets/images/logo/logo_ask_enzo.png')),
          ),
      ],
    );
  }
}
