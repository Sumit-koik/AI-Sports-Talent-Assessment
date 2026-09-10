import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class _OnboardingPage {
  const _OnboardingPage({required this.title, required this.description, required this.icon, required this.accent});

  final String title;
  final String description;
  final IconData icon;
  final Color accent;
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _pages = [
    _OnboardingPage(title: 'Discover Your Potential', description: 'Assess your athletic abilities using structured sports performance analysis.', icon: Icons.insights_rounded, accent: Color(0xFFE4F2B5)),
    _OnboardingPage(title: 'Record Your Performance', description: 'Submit your sports performance video and prepare for assessment.', icon: Icons.videocam_rounded, accent: Color(0xFFD9EBFF)),
    _OnboardingPage(title: 'Understand Your Performance', description: 'View performance scores, strengths, weaknesses and personalized feedback.', icon: Icons.query_stats_rounded, accent: Color(0xFFFFE4BA)),
  ];

  final _pageController = PageController();
  int _currentPage = 0;

  bool get _isFinalPage => _currentPage == _pages.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_isFinalPage) {
      _finishOnboarding();
      return;
    }
    _pageController.nextPage(duration: const Duration(milliseconds: 380), curve: Curves.easeOutCubic);
  }

  void _finishOnboarding() => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.sizeOf(context).width < 600 ? 24.0 : 64.0;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(padding, 20, padding, 20),
          child: Column(children: [
            Align(alignment: Alignment.centerRight, child: TextButton(onPressed: _finishOnboarding, child: const Text('Skip'))),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (page) => setState(() => _currentPage = page),
                itemBuilder: (context, index) => _OnboardingPageView(page: _pages[index]),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(_pages.length, (index) => _PageIndicator(isActive: index == _currentPage))),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _nextPage,
                icon: Icon(_isFinalPage ? Icons.check_rounded : Icons.arrow_forward_rounded),
                label: Text(_isFinalPage ? 'Get Started' : 'Next'),
                style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _OnboardingPageView extends StatelessWidget {
  const _OnboardingPageView({required this.page});
  final _OnboardingPage page;

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, constraints) {
        final visualSize = constraints.maxHeight < 520 ? 190.0 : 270.0;
        return Center(
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(width: visualSize, height: visualSize, decoration: BoxDecoration(color: page.accent, shape: BoxShape.circle), child: Icon(page.icon, size: visualSize * .42, color: const Color(0xFF176B45))),
              const SizedBox(height: 44),
              Text(page.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 14),
              ConstrainedBox(constraints: const BoxConstraints(maxWidth: 520), child: Text(page.description, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge)),
            ]),
          ),
        );
      });
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.isActive});
  final bool isActive;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: isActive ? 26 : 8,
        height: 8,
        decoration: BoxDecoration(color: isActive ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outlineVariant, borderRadius: BorderRadius.circular(8)),
      );
}