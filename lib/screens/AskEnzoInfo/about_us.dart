import 'package:flutter/material.dart';

/// The AboutUsScreen class is a StatefulWidget in Dart.
class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

/// The `_AboutUsScreenState` class is a stateful widget that builds a scaffold with a null app bar and
/// a body containing the text 'AboutUs'.
class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body: Text('AboutUs'),
    );
  }
}
