import 'package:flutter/material.dart';

import '../models/training_exercise.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({super.key, required this.exercise});

  final TrainingExercise exercise;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 58, height: 58, decoration: BoxDecoration(color: exercise.color, borderRadius: BorderRadius.circular(17)), child: Icon(exercise.icon, color: const Color(0xFF176B45), size: 30)),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(exercise.name, style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 4), Text(exercise.targetMetric, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600, fontSize: 13))])),
              Icon(Icons.chevron_right_rounded, color: Theme.of(context).colorScheme.outline),
            ]),
            const SizedBox(height: 14),
            Text(exercise.description, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            Wrap(spacing: 8, runSpacing: 8, children: [_MetaChip(icon: Icons.timer_outlined, label: exercise.duration), _MetaChip(icon: Icons.repeat_rounded, label: exercise.sets), _MetaChip(icon: Icons.signal_cellular_alt_rounded, label: exercise.difficulty)]),
          ]),
        ),
      );
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Chip(avatar: Icon(icon, size: 16), label: Text(label), visualDensity: VisualDensity.compact);
}