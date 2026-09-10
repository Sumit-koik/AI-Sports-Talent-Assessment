import 'package:flutter/material.dart';

import '../models/dashboard_item.dart';

class PerformanceCard extends StatelessWidget {
  const PerformanceCard({super.key, required this.metric});

  final PerformanceMetric metric;

  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(12), child: LayoutBuilder(builder: (context, constraints) {
        final icon = Container(width: 42, height: 42, decoration: BoxDecoration(color: metric.color, borderRadius: BorderRadius.circular(13)), child: Icon(metric.icon, color: const Color(0xFF176B45), size: 21));
        if (constraints.maxWidth < 140) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [icon, const SizedBox(height: 6), Text(metric.label, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium), const SizedBox(height: 2), Text('${metric.score}', style: Theme.of(context).textTheme.titleMedium)]);
        }
        return Row(children: [icon, const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(metric.label, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium), const SizedBox(height: 4), Text('${metric.score}', style: Theme.of(context).textTheme.titleLarge)])), Text('%', style: Theme.of(context).textTheme.bodyMedium)]);
      })));
}