import 'package:flutter/material.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

/// The `_PrivacyScreenState` class is a stateful widget that builds a scaffold with no app bar and
/// displays the text "Privacy" as the body.
class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body: Text('Privacy'),
    );
  }
}
