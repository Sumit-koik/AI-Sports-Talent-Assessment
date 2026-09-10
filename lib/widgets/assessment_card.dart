import 'package:flutter/material.dart';

import '../models/assessment.dart';

class AssessmentCard extends StatelessWidget {
  const AssessmentCard({super.key, required this.assessment, required this.onTap});

  final Assessment assessment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(children: [
              CircleAvatar(backgroundColor: Color(assessment.colorValue), child: const Icon(Icons.insights_rounded, color: Color(0xFF176B45))),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(assessment.title, style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 4), Text('${assessment.category} assessment  •  2 days ago', style: Theme.of(context).textTheme.bodyMedium)])),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('${assessment.score}', style: Theme.of(context).textTheme.headlineSmall), Text('Score', style: Theme.of(context).textTheme.bodyMedium)]),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right_rounded),
            ]),
          ),
        ),
      );
}