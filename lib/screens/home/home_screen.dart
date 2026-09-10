import 'package:flutter/material.dart';

import '../../core/responsive.dart';
import '../../data/mock_data.dart';
import '../../routes/app_routes.dart';
import '../../widgets/assessment_card.dart';
import '../../widgets/brand_mark.dart';
import '../../widgets/performance_card.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/score_card.dart';
import '../../widgets/sport_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.horizontalPadding(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(padding, 20, padding, 36),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _DashboardHeader(onProfile: () => Navigator.pushNamed(context, AppRoutes.profile)),
                const SizedBox(height: 26),
                _HeroCard(onStart: () => Navigator.pushNamed(context, AppRoutes.sportSelection)),
                const SizedBox(height: 32),
                _SectionHeader(title: 'Choose Your Sport', action: 'See all', onAction: () => _showMessage(context, 'Sport directory coming soon')),
                const SizedBox(height: 12),
                _SportsSection(onSportTap: (sport) => _showMessage(context, '${sport.name} assessment selected')),
                const SizedBox(height: 32),
                _SectionHeader(title: 'Performance summary', action: 'View results', onAction: () => Navigator.pushNamed(context, AppRoutes.assessments)),
                const SizedBox(height: 12),
                _PerformanceSection(),
                const SizedBox(height: 32),
                _SectionHeader(title: 'Recent assessment', action: 'History', onAction: () => Navigator.pushNamed(context, AppRoutes.assessments)),
                const SizedBox(height: 12),
                AssessmentCard(assessment: MockData.assessments.first, onTap: () => Navigator.pushNamed(context, AppRoutes.assessments)),
                const SizedBox(height: 32),
                Text('Quick actions', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                _QuickActions(onStart: () => Navigator.pushNamed(context, AppRoutes.sportSelection), onResults: () => Navigator.pushNamed(context, AppRoutes.assessmentResult, arguments: 'Football'), onHistory: () => Navigator.pushNamed(context, AppRoutes.assessments), onProfile: () => Navigator.pushNamed(context, AppRoutes.profile)),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  static void _showMessage(BuildContext context, String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({required this.onProfile});
  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) => Row(children: [
        const BrandMark(size: 46),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Good Morning, Athlete!', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 3), Text('Alex Morgan', style: Theme.of(context).textTheme.bodyMedium)])),
        IconButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You are all caught up'))), icon: const Icon(Icons.notifications_none_rounded), tooltip: 'Notifications'),
        InkWell(onTap: onProfile, borderRadius: BorderRadius.circular(24), child: const CircleAvatar(radius: 22, backgroundColor: Color(0xFFE4F2B5), child: Icon(Icons.person_rounded, color: Color(0xFF176B45)))),
      ]);
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.onStart});
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.94, end: 1),
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeOutCubic,
        builder: (context, scale, child) => Transform.scale(scale: scale, alignment: Alignment.center, child: child),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Theme.of(context).colorScheme.primary, const Color(0xFF0D3D2B)]),
            borderRadius: BorderRadius.circular(24),
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            final content = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: const Color(0x26FFFFFF), borderRadius: BorderRadius.circular(20)), child: const Text('YOUR NEXT BREAKTHROUGH', style: TextStyle(color: Color(0xD9FFFFFF), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1))),
              const SizedBox(height: 16),
              Text('Ready to test your potential?', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white)),
              const SizedBox(height: 8),
              const Text('Take a guided assessment and turn your performance into a clear next step.', style: TextStyle(color: Color(0xD9FFFFFF), height: 1.4)),
              const SizedBox(height: 20),
              PrimaryButton(label: 'Start Assessment', icon: Icons.play_arrow_rounded, onPressed: onStart),
            ]);
            return constraints.maxWidth < 560 ? content : Row(children: [Expanded(child: content), const Padding(padding: EdgeInsets.only(right: 24), child: Icon(Icons.insights_rounded, size: 112, color: Color(0x40FFFFFF)))]);
          }),
        ),
      );
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.action, required this.onAction});
  final String title;
  final String action;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: Theme.of(context).textTheme.titleLarge), TextButton(onPressed: onAction, child: Text(action))]);
}

class _SportsSection extends StatelessWidget {
  const _SportsSection({required this.onSportTap});
  final ValueChanged<dynamic> onSportTap;

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 760;
        if (!isWide) {
          return SizedBox(height: 138, child: ListView.separated(scrollDirection: Axis.horizontal, itemCount: MockData.sports.length, separatorBuilder: (_, index) => const SizedBox(width: 12), itemBuilder: (_, index) => SizedBox(width: 132, child: SportCard(sport: MockData.sports[index], onTap: () => onSportTap(MockData.sports[index])))));
        }
        return GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: MockData.sports.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, crossAxisSpacing: 12, childAspectRatio: .65), itemBuilder: (_, index) => SportCard(sport: MockData.sports[index], onTap: () => onSportTap(MockData.sports[index])));
      });
}

class _PerformanceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, constraints) {
        final columns = constraints.maxWidth >= 760 ? 4 : 2;
        return Column(children: [
          ScoreCard(score: 81, label: 'Overall Score'),
          const SizedBox(height: 12),
          GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: MockData.performance.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: constraints.maxWidth >= 760 ? 1.65 : 1.7), itemBuilder: (_, index) => PerformanceCard(metric: MockData.performance[index])),
        ]);
      });
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.onStart, required this.onResults, required this.onHistory, required this.onProfile});
  final VoidCallback onStart;
  final VoidCallback onResults;
  final VoidCallback onHistory;
  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    final actions = [
      (label: 'Start Assessment', icon: Icons.play_circle_outline_rounded, onTap: onStart),
      (label: 'My Results', icon: Icons.insights_outlined, onTap: onResults),
      (label: 'Assessment History', icon: Icons.history_rounded, onTap: onHistory),
      (label: 'Profile', icon: Icons.person_outline_rounded, onTap: onProfile),
    ];
    return LayoutBuilder(builder: (context, constraints) {
      final columns = constraints.maxWidth >= 760 ? 4 : 2;
      return GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: actions.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 2.15), itemBuilder: (_, index) {
        final action = actions[index];
        return Card(child: InkWell(onTap: action.onTap, borderRadius: BorderRadius.circular(20), child: Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: Row(children: [Icon(action.icon, color: Theme.of(context).colorScheme.primary), const SizedBox(width: 10), Expanded(child: Text(action.label, style: Theme.of(context).textTheme.labelLarge)), const Icon(Icons.arrow_outward_rounded, size: 17)]))));
      });
    });
  }
}