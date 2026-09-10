import 'package:flutter/material.dart';

class SportOption {
  const SportOption({required this.name, required this.description, required this.icon, required this.color});

  final String name;
  final String description;
  final IconData icon;
  final Color color;
}

class PerformanceMetric {
  const PerformanceMetric({required this.label, required this.score, required this.icon, required this.color});

  final String label;
  final int score;
  final IconData icon;
  final Color color;
}