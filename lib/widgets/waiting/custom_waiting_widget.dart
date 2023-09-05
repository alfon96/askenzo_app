import 'package:flutter/material.dart';

class CustomWaitingWidget extends StatelessWidget {
  const CustomWaitingWidget(
      {super.key,
      required this.isWaiting,
      required this.child,
      this.alignment = Alignment.center});

  final bool isWaiting;
  final Widget child;
  final Alignment alignment;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: alignment, children: [
      child,
      if (isWaiting) const Center(child: CircularProgressIndicator())
    ]);
  }
}
