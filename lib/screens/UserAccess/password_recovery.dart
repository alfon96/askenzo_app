import 'package:flutter/material.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

/// The `_PasswordRecoveryScreenState` class is a stateful widget that builds a scaffold with a body
/// containing the text 'PasswordRecovery'.
class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body: Text('PasswordRecovery'),
    );
  }
}
