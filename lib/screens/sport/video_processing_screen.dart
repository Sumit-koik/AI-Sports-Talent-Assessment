import 'dart:async';

import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class _ProcessingStage {
  const _ProcessingStage(this.label);
  final String label;
}

class VideoProcessingScreen extends StatefulWidget {
  const VideoProcessingScreen({super.key, required this.sportName});
  final String sportName;

  @override
  State<VideoProcessingScreen> createState() => _VideoProcessingScreenState();
}

class _VideoProcessingScreenState extends State<VideoProcessingScreen> {
  static const _stages = [
    _ProcessingStage('Video uploaded'),
    _ProcessingStage('Preparing frames'),
    _ProcessingStage('Detecting body movement'),
    _ProcessingStage('Extracting movement features'),
    _ProcessingStage('Calculating performance metrics'),
    _ProcessingStage('Generating assessment'),
  ];

  Timer? _stageTimer;
  int _completedStages = 1;

  @override
  void initState() {
    super.initState();
    _stageTimer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_completedStages >= _stages.length) {
        timer.cancel();
        Navigator.pushReplacementNamed(context, AppRoutes.assessmentResult, arguments: widget.sportName);
        return;
      }
      setState(() => _completedStages++);
    });
  }

  @override
  void dispose() {
    _stageTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = _completedStages / _stages.length;
    return Scaffold(
      appBar: AppBar(title: const Text('AI assessment processing')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                _ProcessingHero(sportName: widget.sportName, progress: progress),
                const SizedBox(height: 28),
                Text('Analysis progress', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 14),
                ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: progress, minHeight: 8)),
                const SizedBox(height: 22),
                Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(children: [
                  for (var index = 0; index < _stages.length; index++) _StageRow(stage: _stages[index].label, isComplete: index < _completedStages, isCurrent: index == _completedStages && _completedStages < _stages.length),
                ]))),
                const SizedBox(height: 20),
                Text('Building a mock performance summary for ${widget.sportName}.', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProcessingHero extends StatelessWidget {
  const _ProcessingHero({required this.sportName, required this.progress});
  final String sportName;
  final double progress;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Theme.of(context).colorScheme.primary, const Color(0xFF0D3D2B)]), borderRadius: BorderRadius.circular(24)),
        child: Column(children: [
          Stack(alignment: Alignment.center, children: [SizedBox(width: 104, height: 104, child: CircularProgressIndicator(value: progress, strokeWidth: 7, backgroundColor: const Color(0x40FFFFFF), color: Theme.of(context).colorScheme.secondaryContainer)), const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 42)]),
          const SizedBox(height: 20),
          Text('Analyzing Your Performance', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white)),
          const SizedBox(height: 8),
          Text('$sportName assessment in progress', style: const TextStyle(color: Color(0xD9FFFFFF))),
        ]),
      );
}

class _StageRow extends StatelessWidget {
  const _StageRow({required this.stage, required this.isComplete, required this.isCurrent});
  final String stage;
  final bool isComplete;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(children: [
          AnimatedSwitcher(duration: const Duration(milliseconds: 220), child: isComplete ? Icon(Icons.check_circle_rounded, key: const ValueKey('complete'), color: Theme.of(context).colorScheme.primary, size: 22) : isCurrent ? SizedBox(key: const ValueKey('current'), width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Theme.of(context).colorScheme.primary)) : Icon(Icons.radio_button_unchecked_rounded, key: const ValueKey('pending'), color: Theme.of(context).colorScheme.outline, size: 22)),
          const SizedBox(width: 12),
          Expanded(child: Text(stage, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: isComplete || isCurrent ? null : Theme.of(context).colorScheme.onSurface.withValues(alpha: .45)))),
          if (isCurrent) Text('Working', style: Theme.of(context).textTheme.bodyMedium),
        ]),
      );
}