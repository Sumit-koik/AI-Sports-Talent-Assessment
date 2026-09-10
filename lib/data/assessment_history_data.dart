import '../models/assessment_history_item.dart';

class AssessmentHistoryData {
  static final records = [
    AssessmentHistoryItem(sport: 'Football', date: DateTime(2026, 9, 8), overallScore: 87, speed: 89, agility: 84, balance: 91),
    AssessmentHistoryItem(sport: 'Football', date: DateTime(2026, 9, 1), overallScore: 82, speed: 84, agility: 80, balance: 86),
    AssessmentHistoryItem(sport: 'Cricket', date: DateTime(2026, 8, 25), overallScore: 79, speed: 76, agility: 81, balance: 80),
    AssessmentHistoryItem(sport: 'Basketball', date: DateTime(2026, 8, 18), overallScore: 85, speed: 88, agility: 90, balance: 83),
    AssessmentHistoryItem(sport: 'Tennis', date: DateTime(2026, 8, 11), overallScore: 76, speed: 74, agility: 79, balance: 77),
    AssessmentHistoryItem(sport: 'Cricket', date: DateTime(2026, 8, 3), overallScore: 73, speed: 71, agility: 75, balance: 78),
  ];
}