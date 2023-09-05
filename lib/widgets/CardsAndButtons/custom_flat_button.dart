import 'package:ask_enzo_app/widgets/MediaWidgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton({
    super.key,
    required this.btnText,
    required this.btnFunction,
    required this.btnHeight,
    required this.btnUrl,
    this.borderRadius = 0,
  });
  final String btnUrl;
  final String btnText;
  final double btnHeight;
  final Function btnFunction;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => btnFunction(),
      child: ClipRRect(
        borderRadius: borderRadius > 0
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.circular(0),
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(90, 4, 30, 51),
              borderRadius: borderRadius > 0
                  ? BorderRadius.circular(borderRadius)
                  : null),
          height: btnHeight,
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              Opacity(
                opacity: 0.75,
                child: CustomCachedNetworkImage(
                  imgPath: btnUrl,
                ),
              ),
              SizedBox(
                height: btnHeight,
                child: Center(
                  child: Text(
                    btnText,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
