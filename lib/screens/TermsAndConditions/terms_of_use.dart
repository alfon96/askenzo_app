import 'package:flutter/material.dart';

/// The PrivacyScreen class is a StatefulWidget in Dart.
/// The TermsOfUseScreen class is a StatefulWidget in Dart that represents a screen displaying terms of
/// use.
class TermsOfUseScreen extends StatefulWidget {
  const TermsOfUseScreen({super.key});

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

/// The `_TermsOfUseScreenState` class is a stateful widget that builds a scaffold with a null app bar
/// and a body containing the text 'TermsOfUse'.
class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body: Text('TermsOfUse'),
    );
  }
}
