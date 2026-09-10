import 'package:flutter/material.dart';

import '../../data/assessment_history_data.dart';
import '../../models/assessment_history_item.dart';
import '../../routes/app_routes.dart';
import '../../widgets/assessment_history_card.dart';

enum _HistorySort { newest, highest, lowest }

class AssessmentHistoryScreen extends StatefulWidget {
  const AssessmentHistoryScreen({super.key});

  @override
  State<AssessmentHistoryScreen> createState() => _AssessmentHistoryScreenState();
}

class _AssessmentHistoryScreenState extends State<AssessmentHistoryScreen> {
  String _filter = 'All';
  _HistorySort _sort = _HistorySort.newest;

  List<AssessmentHistoryItem> get _visibleAssessments {
    final assessments = AssessmentHistoryData.records.where((item) => _filter == 'All' || item.sport == _filter).toList();
    assessments.sort((a, b) {
      switch (_sort) {
        case _HistorySort.newest:
          return b.date.compareTo(a.date);
        case _HistorySort.highest:
          return b.overallScore.compareTo(a.overallScore);
        case _HistorySort.lowest:
          return a.overallScore.compareTo(b.overallScore);
      }
    });
    return assessments;
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.sizeOf(context).width < 600 ? 20.0 : 56.0;
    final filters = ['All', 'Football', 'Cricket', 'Basketball', 'Tennis'];
    final filterChips = filters.map((filter) => Padding(padding: const EdgeInsets.only(right: 8), child: ChoiceChip(label: Text(filter), selected: _filter == filter, onSelected: (_) => setState(() => _filter = filter)))).toList();
    final assessmentCards = _visibleAssessments.map((assessment) => Padding(padding: const EdgeInsets.only(bottom: 12), child: AssessmentHistoryCard(assessment: assessment, onTap: () => Navigator.pushNamed(context, AppRoutes.assessmentResult, arguments: assessment.sport)))).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Assessment History')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(padding, 16, padding, 36),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 860),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text('Your assessment journey', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 6),
                const Text('Review previous performances and track your progress over time.'),
                const SizedBox(height: 24),
                SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: filterChips)),
                const SizedBox(height: 14),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  const Text('Sort by'),
                  const SizedBox(width: 8),
                  DropdownButton<_HistorySort>(value: _sort, underline: const SizedBox.shrink(), items: const [DropdownMenuItem(value: _HistorySort.newest, child: Text('Newest')), DropdownMenuItem(value: _HistorySort.highest, child: Text('Highest Score')), DropdownMenuItem(value: _HistorySort.lowest, child: Text('Lowest Score'))], onChanged: (value) => setState(() => _sort = value ?? _HistorySort.newest)),
                ]),
                const SizedBox(height: 8),
                AnimatedSwitcher(duration: const Duration(milliseconds: 250), child: _visibleAssessments.isEmpty ? const Padding(padding: EdgeInsets.all(40), child: Text('No assessments match this filter.', textAlign: TextAlign.center)) : Column(key: ValueKey('$_filter$_sort'), children: assessmentCards)),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}