import 'package:flutter/material.dart';

class AssessmentInfoCard extends StatelessWidget {
  const AssessmentInfoCard({super.key, required this.title, required this.icon, required this.items});

  final String title;
  final IconData icon;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [Icon(icon, color: primary), const SizedBox(width: 10), Text(title, style: Theme.of(context).textTheme.titleMedium)]),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.check_rounded, size: 18, color: primary), const SizedBox(width: 8), Expanded(child: Text(item))]),
                )),
          ],
        ),
      ),
    );
  }
}