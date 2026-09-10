import 'package:flutter/material.dart';

import '../../data/training_data.dart';
import '../../routes/app_routes.dart';
import '../../widgets/exercise_card.dart';

class TrainingRecommendationsScreen extends StatelessWidget {
  const TrainingRecommendationsScreen({super.key, required this.sportName});
  final String sportName;

  void _startTraining(BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Training session started in mock mode')));

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.sizeOf(context).width < 600 ? 20.0 : 56.0;
    return Scaffold(
      appBar: AppBar(title: const Text('Training recommendations')),
      body: SafeArea(child: SingleChildScrollView(padding: EdgeInsets.fromLTRB(padding, 16, padding, 36), child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 820), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _TrainingHeader(sportName: sportName),
        const SizedBox(height: 26),
        Text('Recommended Exercises', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 6),
        const Text('A focused plan built from your latest mock assessment results.'),
        const SizedBox(height: 14),
        LayoutBuilder(builder: (context, constraints) {
          final columns = constraints.maxWidth >= 700 ? 2 : 1;
          return GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: TrainingData.recommendations.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: columns == 2 ? 1.28 : 1.45), itemBuilder: (_, index) => ExerciseCard(exercise: TrainingData.recommendations[index]));
        }),
        const SizedBox(height: 24),
        FilledButton.icon(onPressed: () => _startTraining(context), icon: const Icon(Icons.play_arrow_rounded), label: const Text('Start Training'), style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
        const SizedBox(height: 8),
        TextButton.icon(onPressed: () => Navigator.pushNamed(context, AppRoutes.assessmentResult, arguments: sportName), icon: const Icon(Icons.arrow_back_rounded), label: const Text('Back to results')),
      ]))))),
    );
  }
}

class _TrainingHeader extends StatelessWidget {
  const _TrainingHeader({required this.sportName});
  final String sportName;

  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Theme.of(context).colorScheme.primary, const Color(0xFF0D3D2B)]), borderRadius: BorderRadius.circular(24)), child: Row(children: [Container(width: 56, height: 56, decoration: BoxDecoration(color: const Color(0x33FFFFFF), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.fitness_center_rounded, color: Colors.white, size: 30)), const SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('PERSONALIZED PLAN', style: TextStyle(color: Color(0xB3FFFFFF), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1)), const SizedBox(height: 5), Text('$sportName training focus', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)), const SizedBox(height: 4), const Text('Build on your strengths and target your next gains.', style: TextStyle(color: Color(0xD9FFFFFF)))]))]));
}