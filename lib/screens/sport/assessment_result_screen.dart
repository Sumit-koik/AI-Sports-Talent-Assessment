import 'package:flutter/material.dart';

import '../../models/dashboard_item.dart';
import '../../routes/app_routes.dart';
import '../../widgets/performance_card.dart';

class AssessmentResultScreen extends StatelessWidget {
  const AssessmentResultScreen({super.key, required this.sportName});
  final String sportName;

  static const _metrics = [
    PerformanceMetric(label: 'Speed', score: 89, icon: Icons.bolt_rounded, color: Color(0xFFD9EBFF)),
    PerformanceMetric(label: 'Agility', score: 84, icon: Icons.shuffle_rounded, color: Color(0xFFE4F2B5)),
    PerformanceMetric(label: 'Balance', score: 91, icon: Icons.accessibility_new_rounded, color: Color(0xFFFFE4BA)),
    PerformanceMetric(label: 'Technique', score: 86, icon: Icons.auto_awesome_rounded, color: Color(0xFFE8DFFF)),
    PerformanceMetric(label: 'Consistency', score: 85, icon: Icons.track_changes_rounded, color: Color(0xFFD6F1E1)),
  ];

  void _showMockFeedback(BuildContext context, String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.sizeOf(context).width < 600 ? 20.0 : 56.0;
    return Scaffold(
      appBar: AppBar(title: const Text('Your Performance Result')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(padding, 16, padding, 36),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 820),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                _ResultHero(sportName: sportName),
                const SizedBox(height: 28),
                _SectionTitle(title: 'Performance metrics', caption: 'A balanced snapshot of your latest assessment'),
                const SizedBox(height: 12),
                LayoutBuilder(builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 700 ? 3 : 2;
                  return GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: _metrics.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: columns == 3 ? 1.7 : 1.55), itemBuilder: (_, index) => PerformanceCard(metric: _metrics[index]));
                }),
                const SizedBox(height: 28),
                const _InsightSection(title: 'Overall Performance', icon: Icons.insights_rounded, child: Text('Your result shows a well-rounded athletic profile, with balance and speed emerging as clear strengths.')),
                const SizedBox(height: 12),
                const _InsightSection(title: 'Strengths', icon: Icons.star_outline_rounded, accent: Color(0xFF176B45), child: _BulletList(items: ['Excellent balance', 'Good movement consistency', 'Strong body control'])),
                const SizedBox(height: 12),
                const _InsightSection(title: 'Areas to Improve', icon: Icons.arrow_upward_rounded, accent: Color(0xFFB15C00), child: _BulletList(items: ['Improve acceleration', 'Improve movement efficiency'])),
                const SizedBox(height: 12),
                const _InsightSection(title: 'AI-style Feedback', icon: Icons.auto_awesome_rounded, accent: Color(0xFF176B45), child: Text('Your overall performance shows strong athletic potential. Focus on acceleration and movement efficiency to improve your score.')),
                const SizedBox(height: 12),
                const _InsightSection(title: 'Recommended Training', icon: Icons.fitness_center_rounded, child: _BulletList(items: ['Add short acceleration sprints twice a week.', 'Practice controlled direction changes.', 'Repeat movement drills with consistent form.'])),
                const SizedBox(height: 28),
                _ActionGrid(onAction: (action) {
                  if (action == 'View Detailed Analysis') {
                    Navigator.pushNamed(context, AppRoutes.detailedAnalysis, arguments: sportName);
                  } else if (action == 'Training Recommendations') {
                    Navigator.pushNamed(context, AppRoutes.trainingRecommendations, arguments: sportName);
                  } else {
                    _showMockFeedback(context, '$action is mocked locally');
                  }
                }),
                const SizedBox(height: 12),
                TextButton.icon(onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false), icon: const Icon(Icons.home_outlined), label: const Text('Back to dashboard')),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultHero extends StatelessWidget {
  const _ResultHero({required this.sportName});
  final String sportName;

  @override
  Widget build(BuildContext context) {
    final score = Column(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: .87),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return SizedBox(
              width: 148,
              height: 148,
              child: Stack(alignment: Alignment.center, children: [
                CircularProgressIndicator(value: value, strokeWidth: 10, backgroundColor: const Color(0x40FFFFFF), color: Theme.of(context).colorScheme.secondaryContainer),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('87', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white)), const Text('/ 100', style: TextStyle(color: Color(0xD9FFFFFF), fontWeight: FontWeight.w600))]),
              ]),
            );
          },
        ),
        const SizedBox(height: 10),
        const Text('OVERALL SCORE', style: TextStyle(color: Color(0xB3FFFFFF), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1)),
      ],
    );
    final copy = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('ASSESSMENT COMPLETE', style: TextStyle(color: Color(0xB3FFFFFF), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1)),
      const SizedBox(height: 10),
      Text('Your Performance Result', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white)),
      const SizedBox(height: 8),
      Text('$sportName assessment', style: const TextStyle(color: Color(0xD9FFFFFF))),
      const SizedBox(height: 18),
      const Text('A strong result with clear opportunities to keep improving.', style: TextStyle(color: Color(0xD9FFFFFF), height: 1.4)),
    ]);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Theme.of(context).colorScheme.primary, const Color(0xFF0D3D2B)]), borderRadius: BorderRadius.circular(24)),
      child: LayoutBuilder(builder: (context, constraints) => constraints.maxWidth < 560 ? Column(children: [score, const SizedBox(height: 20), copy]) : Row(children: [score, const SizedBox(width: 28), Expanded(child: copy)])),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.caption});
  final String title;
  final String caption;

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 3), Text(caption, style: Theme.of(context).textTheme.bodyMedium)]);
}

class _InsightSection extends StatelessWidget {
  const _InsightSection({required this.title, required this.icon, required this.child, this.accent});
  final String title;
  final IconData icon;
  final Widget child;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Icon(icon, color: accent ?? Theme.of(context).colorScheme.primary), const SizedBox(width: 10), Text(title, style: Theme.of(context).textTheme.titleMedium)]),
          const SizedBox(height: 12),
          child,
        ]),
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: items.map((item) => Padding(padding: const EdgeInsets.only(bottom: 7), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('•  '), Expanded(child: Text(item))]))).toList());
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid({required this.onAction});
  final ValueChanged<String> onAction;

  @override
  Widget build(BuildContext context) {
    final actions = [('View Detailed Analysis', Icons.analytics_outlined), ('Training Recommendations', Icons.fitness_center_outlined), ('Save Result', Icons.bookmark_outline_rounded), ('Share Result', Icons.share_outlined)];
    return LayoutBuilder(builder: (context, constraints) {
      final columns = constraints.maxWidth >= 700 ? 4 : 2;
      return GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: actions.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: columns == 4 ? 1.35 : 1.8), itemBuilder: (_, index) {
        final action = actions[index];
        return OutlinedButton.icon(onPressed: () => onAction(action.$1), icon: Icon(action.$2, size: 18), label: Text(action.$1, textAlign: TextAlign.center), style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))));
      });
    });
  }
}