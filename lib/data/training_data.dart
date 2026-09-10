import 'package:flutter/material.dart';

import '../models/training_exercise.dart';

class TrainingData {
  static const recommendations = [
    TrainingExercise(name: 'Sprint Training', targetMetric: 'Improve acceleration', difficulty: 'Beginner / Intermediate', duration: '12 min', sets: '3 sets', icon: Icons.directions_run_rounded, color: Color(0xFFD9EBFF), description: 'Short, controlled bursts to build explosive speed.'),
    TrainingExercise(name: 'Agility Ladder', targetMetric: 'Improve agility', difficulty: 'Intermediate', duration: '15 min', sets: '4 sets', icon: Icons.grid_view_rounded, color: Color(0xFFE4F2B5), description: 'Quick-footwork patterns for sharper changes of direction.'),
    TrainingExercise(name: 'Balance Training', targetMetric: 'Improve stability', difficulty: 'Beginner', duration: '10 min', sets: '3 sets', icon: Icons.accessibility_new_rounded, color: Color(0xFFFFE4BA), description: 'Single-leg control drills to strengthen body stability.'),
    TrainingExercise(name: 'Technique Drills', targetMetric: 'Improve sports-specific technique', difficulty: 'Intermediate', duration: '18 min', sets: '4 sets', icon: Icons.auto_awesome_rounded, color: Color(0xFFE8DFFF), description: 'Focused repetitions to make your movement more efficient.'),
  ];
}