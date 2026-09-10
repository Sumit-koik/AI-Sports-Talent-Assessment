import 'package:flutter/material.dart';

import '../models/assessment_history_item.dart';

class AssessmentHistoryCard extends StatelessWidget {
  const AssessmentHistoryCard({super.key, required this.assessment, required this.onTap});

  final AssessmentHistoryItem assessment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final date = '${assessment.date.day.toString().padLeft(2, '0')} ${_month(assessment.date.month)} ${assessment.date.year}';
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 46, height: 46, decoration: BoxDecoration(color: const Color(0xFFE4F2B5), borderRadius: BorderRadius.circular(14)), child: Icon(_sportIcon(assessment.sport), color: const Color(0xFF176B45))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(assessment.sport, style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 3), Text(date, style: Theme.of(context).textTheme.bodyMedium)])),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('${assessment.overallScore}', style: Theme.of(context).textTheme.headlineSmall), Text('Score', style: Theme.of(context).textTheme.bodyMedium)]),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right_rounded),
            ]),
            const SizedBox(height: 16),
            Row(children: [_Metric(label: 'Speed', score: assessment.speed), _Metric(label: 'Agility', score: assessment.agility), _Metric(label: 'Balance', score: assessment.balance)]),
          ]),
        ),
      ),
    );
  }

  static String _month(int month) => const ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][month];

  static IconData _sportIcon(String sport) => switch (sport) {
        'Football' => Icons.sports_soccer_rounded,
        'Cricket' => Icons.sports_cricket_rounded,
        'Basketball' => Icons.sports_basketball_rounded,
        'Tennis' => Icons.sports_tennis_rounded,
        _ => Icons.sports_rounded,
      };
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.score});
  final String label;
  final int score;

  @override
  Widget build(BuildContext context) => Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: Theme.of(context).textTheme.bodyMedium), const SizedBox(height: 5), ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: score / 100, minHeight: 5)), const SizedBox(height: 4), Text('$score', style: Theme.of(context).textTheme.labelLarge)]));
}