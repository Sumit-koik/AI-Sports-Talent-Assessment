import 'package:flutter/material.dart';

import '../models/assessment.dart';
import '../models/dashboard_item.dart';

class MockData {
  static const sports = [
    SportOption(name: 'Football', description: 'Speed, control and team play', icon: Icons.sports_soccer_rounded, color: Color(0xFFE4F2B5)),
    SportOption(name: 'Cricket', description: 'Power, precision and reaction', icon: Icons.sports_cricket_rounded, color: Color(0xFFD9EBFF)),
    SportOption(name: 'Basketball', description: 'Agility, movement and accuracy', icon: Icons.sports_basketball_rounded, color: Color(0xFFFFE4BA)),
    SportOption(name: 'Volleyball', description: 'Jump, reach and coordination', icon: Icons.sports_volleyball_rounded, color: Color(0xFFE8DFFF)),
    SportOption(name: 'Tennis', description: 'Footwork, balance and technique', icon: Icons.sports_tennis_rounded, color: Color(0xFFFFE6A8)),
    SportOption(name: 'Badminton', description: 'Reaction, speed and control', icon: Icons.sports_rounded, color: Color(0xFFD6F1E1)),
    SportOption(name: 'Athletics', description: 'Strength, speed and endurance', icon: Icons.directions_run_rounded, color: Color(0xFFFFD6D6)),
  ];

  static const performance = [
    PerformanceMetric(label: 'Speed', score: 78, icon: Icons.bolt_rounded, color: Color(0xFFD9EBFF)),
    PerformanceMetric(label: 'Agility', score: 84, icon: Icons.shuffle_rounded, color: Color(0xFFE4F2B5)),
    PerformanceMetric(label: 'Balance', score: 71, icon: Icons.accessibility_new_rounded, color: Color(0xFFFFE4BA)),
    PerformanceMetric(label: 'Technique', score: 88, icon: Icons.auto_awesome_rounded, color: Color(0xFFE8DFFF)),
  ];

  static const assessments = [
    Assessment(title: 'Vertical jump', category: 'Power', score: 87, icon: 0xe5d2, colorValue: 0xFFE6F4B8),
    Assessment(title: 'Sprint reaction', category: 'Speed', score: 74, icon: 0xe5c8, colorValue: 0xFFD6EBFF),
    Assessment(title: 'Agility ladder', category: 'Agility', score: 81, icon: 0xe3a4, colorValue: 0xFFFFE1B8),
  ];
}