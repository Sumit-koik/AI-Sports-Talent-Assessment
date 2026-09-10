import 'package:flutter/material.dart';

class TrainingExercise {
  const TrainingExercise({required this.name, required this.targetMetric, required this.difficulty, required this.duration, required this.sets, required this.icon, required this.color, required this.description});

  final String name;
  final String targetMetric;
  final String difficulty;
  final String duration;
  final String sets;
  final IconData icon;
  final Color color;
  final String description;
}