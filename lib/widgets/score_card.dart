import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({super.key, required this.score, required this.label});

  final int score;
  final String label;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('$score', style: Theme.of(context).textTheme.headlineSmall), const SizedBox(width: 4), Padding(padding: const EdgeInsets.only(bottom: 3), child: Text('/100', style: Theme.of(context).textTheme.bodyMedium))]),
            const SizedBox(height: 10),
            ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: score / 100, minHeight: 6)),
          ]),
        ),
      );
}