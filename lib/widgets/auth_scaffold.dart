import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.sizeOf(context).width < 600 ? 24.0 : 56.0;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(horizontalPadding, 20, horizontalPadding, 32),
          child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 520), child: child)),
        ),
      ),
    );
  }
}