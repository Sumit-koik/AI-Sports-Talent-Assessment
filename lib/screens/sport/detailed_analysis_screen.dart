import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../models/dashboard_item.dart';
import '../../widgets/performance_card.dart';

class DetailedAnalysisScreen extends StatelessWidget {
  const DetailedAnalysisScreen({super.key, required this.sportName});

  final String sportName;

  static const metrics = [
    PerformanceMetric(label: 'Speed', score: 89, icon: Icons.bolt_rounded, color: Color(0xFFD9EBFF)),
    PerformanceMetric(label: 'Agility', score: 84, icon: Icons.shuffle_rounded, color: Color(0xFFE4F2B5)),
    PerformanceMetric(label: 'Balance', score: 91, icon: Icons.accessibility_new_rounded, color: Color(0xFFFFE4BA)),
    PerformanceMetric(label: 'Technique', score: 86, icon: Icons.auto_awesome_rounded, color: Color(0xFFE8DFFF)),
    PerformanceMetric(label: 'Consistency', score: 85, icon: Icons.track_changes_rounded, color: Color(0xFFD6F1E1)),
  ];

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.sizeOf(context).width < 600 ? 20.0 : 56.0;
    return Scaffold(
      appBar: AppBar(title: const Text('Detailed Performance Analysis')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(padding, 16, padding, 36),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                _AnalysisHeader(sportName: sportName),
                const SizedBox(height: 26),
                _SectionHeading(title: 'Performance Overview', subtitle: 'Your movement profile compared with an athlete benchmark.'),
                const SizedBox(height: 12),
                _OverviewCard(metrics: metrics),
                const SizedBox(height: 26),
                _SectionHeading(title: 'Physical Metrics', subtitle: 'Raw performance indicators from your assessment.'),
                const SizedBox(height: 12),
                _MetricGrid(metrics: metrics.sublist(0, 3)),
                const SizedBox(height: 26),
                _SectionHeading(title: 'Movement Quality', subtitle: 'How efficiently and consistently you moved.'),
                const SizedBox(height: 12),
                const _ProgressInsight(title: 'Movement control', score: 88, description: 'Strong control through changes of direction.', icon: Icons.accessibility_new_rounded),
                const SizedBox(height: 10),
                const _ProgressInsight(title: 'Body alignment', score: 82, description: 'Keep your trunk stable during acceleration.', icon: Icons.straighten_rounded),
                const SizedBox(height: 26),
                _SectionHeading(title: 'Technique', subtitle: 'Skill execution and form quality.'),
                const SizedBox(height: 12),
                _MetricGrid(metrics: metrics.sublist(3)),
                const SizedBox(height: 26),
                _SectionHeading(title: 'Consistency', subtitle: 'Repeatability across recorded movement attempts.'),
                const SizedBox(height: 12),
                const _ProgressInsight(title: 'Attempt consistency', score: 85, description: 'Your movement pattern stayed reliable across attempts.', icon: Icons.repeat_rounded),
                const SizedBox(height: 26),
                _BenchmarkCard(metrics: metrics),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnalysisHeader extends StatelessWidget {
  const _AnalysisHeader({required this.sportName});
  final String sportName;

  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Theme.of(context).colorScheme.primary, const Color(0xFF0D3D2B)]), borderRadius: BorderRadius.circular(24)), child: Row(children: [Container(width: 56, height: 56, decoration: BoxDecoration(color: const Color(0x33FFFFFF), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.analytics_rounded, color: Colors.white, size: 30)), const SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('MOCK ATHLETE REPORT', style: TextStyle(color: Color(0xB3FFFFFF), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1)), const SizedBox(height: 5), Text('$sportName movement analysis', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)), const SizedBox(height: 4), const Text('Compared against a recreational athlete benchmark', style: TextStyle(color: Color(0xD9FFFFFF)))]))]));
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 3), Text(subtitle, style: Theme.of(context).textTheme.bodyMedium)]);
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({required this.metrics});
  final List<PerformanceMetric> metrics;

  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(20), child: LayoutBuilder(builder: (context, constraints) {
        final chart = SizedBox(width: constraints.maxWidth < 560 ? 250 : 310, height: constraints.maxWidth < 560 ? 250 : 310, child: CustomPaint(painter: _RadarPainter(values: metrics.map((metric) => metric.score / 100).toList(), benchmark: const [0.78, 0.76, 0.80, 0.77, 0.75], color: Theme.of(context).colorScheme.primary)));
        final details = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Overall profile', style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 8), const Text('Your strongest area is balance, with speed and technique also above the benchmark.'), const SizedBox(height: 16), const _Legend(color: Color(0xFF176B45), label: 'Your score'), const SizedBox(height: 8), const _Legend(color: Color(0xFFB8BDB8), label: 'Benchmark')]);
        return constraints.maxWidth < 560 ? Column(children: [chart, const SizedBox(height: 12), details]) : Row(children: [chart, const SizedBox(width: 24), Expanded(child: details)]);
      })));
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)), const SizedBox(width: 8), Text(label, style: Theme.of(context).textTheme.bodyMedium)]);
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.metrics});
  final List<PerformanceMetric> metrics;

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, constraints) {
        final columns = constraints.maxWidth >= 700 ? 3 : 2;
        return GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: metrics.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.6), itemBuilder: (_, index) => PerformanceCard(metric: metrics[index]));
      });
}

class _ProgressInsight extends StatelessWidget {
  const _ProgressInsight({required this.title, required this.score, required this.description, required this.icon});
  final String title;
  final int score;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(icon, color: Theme.of(context).colorScheme.primary), const SizedBox(width: 10), Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium)), Text('$score', style: Theme.of(context).textTheme.titleLarge)]), const SizedBox(height: 10), ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: score / 100, minHeight: 7)), const SizedBox(height: 9), Text(description)])));
}

class _BenchmarkCard extends StatelessWidget {
  const _BenchmarkCard({required this.metrics});
  final List<PerformanceMetric> metrics;

  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Benchmark comparison', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 6), const Text('Your score is shown against a mock benchmark for each dimension.'), const SizedBox(height: 18), ...metrics.map((metric) => Padding(padding: const EdgeInsets.only(bottom: 14), child: Row(children: [SizedBox(width: 88, child: Text(metric.label)), Expanded(child: Stack(alignment: Alignment.centerLeft, children: [ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: metric.score / 100, minHeight: 8)), FractionallySizedBox(widthFactor: metric.score / 100, child: Align(alignment: Alignment.centerRight, child: Container(width: 2, height: 14, color: Theme.of(context).colorScheme.primary)))]),), const SizedBox(width: 12), Text('${metric.score} / 80', style: Theme.of(context).textTheme.bodyMedium)])))])));
}

class _RadarPainter extends CustomPainter {
  _RadarPainter({required this.values, required this.benchmark, required this.color});
  final List<double> values;
  final List<double> benchmark;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * .38;
    final gridPaint = Paint()..style = PaintingStyle.stroke..strokeWidth = 1..color = const Color(0xFFCBD3CC);
    final benchmarkPaint = Paint()..style = PaintingStyle.fill..color = const Color(0x302F4938);
    final valuePaint = Paint()..style = PaintingStyle.fill..color = color.withValues(alpha: .28);
    final outlinePaint = Paint()..style = PaintingStyle.stroke..strokeWidth = 2.5..color = color;
    for (var level = 1; level <= 4; level++) {
      canvas.drawPath(_polygon(center, radius * level / 4, 5), gridPaint);
    }
    canvas.drawPath(_polygon(center, radius, 5, values: benchmark), benchmarkPaint);
    canvas.drawPath(_polygon(center, radius, 5, values: benchmark), gridPaint);
    canvas.drawPath(_polygon(center, radius, 5, values: values), valuePaint);
    canvas.drawPath(_polygon(center, radius, 5, values: values), outlinePaint);
    for (var index = 0; index < 5; index++) {
      final point = _point(center, radius, index, 5);
      canvas.drawLine(center, point, gridPaint);
      canvas.drawCircle(_point(center, radius, index, 5, value: values[index]), 4, Paint()..color = color);
    }
  }

  Path _polygon(Offset center, double radius, int sides, {List<double>? values}) {
    final path = Path();
    for (var index = 0; index < sides; index++) {
      final point = _point(center, radius, index, sides, value: values?[index] ?? 1);
      if (index == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    return path;
  }

  Offset _point(Offset center, double radius, int index, int sides, {double value = 1}) {
    final angle = -math.pi / 2 + (2 * math.pi * index / sides);
    return center + Offset(math.cos(angle), math.sin(angle)) * radius * value;
  }

  @override
  bool shouldRepaint(covariant _RadarPainter oldDelegate) => oldDelegate.values != values || oldDelegate.color != color;
}