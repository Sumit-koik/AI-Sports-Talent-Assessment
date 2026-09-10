import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/assessment_info_card.dart';

class SportPreparationScreen extends StatelessWidget {
  const SportPreparationScreen({super.key, required this.sportName});
  final String sportName;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.sizeOf(context).width < 600 ? 20.0 : 56.0;
    return Scaffold(
      appBar: AppBar(title: const Text('Assessment preparation')),
      body: SafeArea(child: SingleChildScrollView(padding: EdgeInsets.fromLTRB(padding, 16, padding, 32), child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 760), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _AssessmentHeader(sportName: sportName),
        const SizedBox(height: 24),
        Text('Assessment details', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        const AssessmentInfoCard(title: 'Instructions', icon: Icons.fact_check_outlined, items: ['Keep the full body visible.', 'Use a stable camera.', 'Perform the requested movement.', 'Stop if you feel discomfort.']),
        const SizedBox(height: 12),
        const AssessmentInfoCard(title: 'Required equipment', icon: Icons.sports_handball_outlined, items: ['Sports clothing and comfortable shoes.', 'A clear space for movement.', 'A phone or camera for recording.']),
        const SizedBox(height: 12),
        const AssessmentInfoCard(title: 'Video recording guidelines', icon: Icons.videocam_outlined, items: ['Record in landscape mode where possible.', 'Keep the entire movement in frame.', 'Avoid cuts or filters in the video.']),
        const SizedBox(height: 12),
        const AssessmentInfoCard(title: 'Recommended camera setup', icon: Icons.camera_alt_outlined, items: ['Position the camera at waist height.', 'Stand approximately 4 metres away.', 'Face a light source for a clear view.']),
        const SizedBox(height: 12),
        const AssessmentInfoCard(title: 'Duration', icon: Icons.timer_outlined, items: ['Allow around 10 minutes for this assessment.', 'Each movement should take about 30 seconds.']),
        const SizedBox(height: 24),
        FilledButton.icon(onPressed: () => Navigator.pushNamed(context, AppRoutes.videoSubmission, arguments: {'sportName': sportName}), icon: const Icon(Icons.videocam_rounded), label: const Text('Start Recording'), style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
        const SizedBox(height: 12),
        OutlinedButton.icon(onPressed: () => Navigator.pushNamed(context, AppRoutes.videoSubmission, arguments: {'sportName': sportName}), icon: const Icon(Icons.upload_file_rounded), label: const Text('Upload Video'), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
      ]))))),
    );
  }
}

class _AssessmentHeader extends StatelessWidget {
  const _AssessmentHeader({required this.sportName});
  final String sportName;

  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Theme.of(context).colorScheme.primary, const Color(0xFF0D3D2B)]), borderRadius: BorderRadius.circular(24)), child: Row(children: [Container(width: 64, height: 64, decoration: BoxDecoration(color: const Color(0x33FFFFFF), borderRadius: BorderRadius.circular(18)), child: const Icon(Icons.sports_score_rounded, color: Colors.white, size: 36)), const SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('SELECTED SPORT', style: TextStyle(color: Color(0xB3FFFFFF), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1)), const SizedBox(height: 5), Text('$sportName Assessment', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white)), const SizedBox(height: 4), const Text('Assessment Type  •  Foundational performance', style: TextStyle(color: Color(0xD9FFFFFF)))]))]));
}

