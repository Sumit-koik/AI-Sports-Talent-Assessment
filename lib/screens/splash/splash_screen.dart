import 'dart:async';

import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _navigationTimer = Timer(const Duration(milliseconds: 2200), _openOnboarding);
  }

  void _openOnboarding() {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colorScheme.primary, const Color(0xFF0D3D2B)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _SportMark(),
                  const SizedBox(height: 28),
                  Text('SportAssess', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white)),
                  const SizedBox(height: 10),
                  const Text('Discover Your Athletic Potential', style: TextStyle(color: Color(0xD9FFFFFF), fontSize: 16)),
                  const SizedBox(height: 52),
                  SizedBox(
                    width: 110,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.2, end: 1),
                      duration: const Duration(milliseconds: 1400),
                      curve: Curves.easeInOut,
                      builder: (context, value, child) => LinearProgressIndicator(value: value, minHeight: 4, borderRadius: BorderRadius.circular(4), backgroundColor: const Color(0x40FFFFFF), color: colorScheme.secondaryContainer),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SportMark extends StatelessWidget {
  const _SportMark();

  @override
  Widget build(BuildContext context) => Container(
        width: 104,
        height: 104,
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: BorderRadius.circular(32)),
        child: Stack(alignment: Alignment.center, children: [
          Icon(Icons.track_changes_rounded, size: 62, color: Theme.of(context).colorScheme.primary),
          const Positioned(right: 20, top: 20, child: Icon(Icons.bolt_rounded, size: 25, color: Color(0xFF176B45))),
        ]),
      );
}