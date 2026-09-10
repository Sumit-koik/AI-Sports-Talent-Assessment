import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class VideoSubmissionScreen extends StatefulWidget {
  const VideoSubmissionScreen({super.key, required this.sportName, this.hasRecordedVideo = false});
  final String sportName;
  final bool hasRecordedVideo;

  @override
  State<VideoSubmissionScreen> createState() => _VideoSubmissionScreenState();
}

class _VideoSubmissionScreenState extends State<VideoSubmissionScreen> {
  late bool _hasVideo;
  String _fileName = 'football_drill_01.mp4';
  String _duration = '00:32';

  @override
  void initState() {
    super.initState();
    _hasVideo = widget.hasRecordedVideo;
    if (_hasVideo) {
      _fileName = '${widget.sportName.toLowerCase()}_recording.mp4';
      _duration = '00:28';
    }
  }

  void _showMockFiles() {
    showModalBottomSheet<void>(context: context, showDragHandle: true, builder: (context) => SafeArea(child: Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 24), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Select a video', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          const Text('Choose a local mock video for this assessment.'),
          const SizedBox(height: 14),
          _MockFileTile(name: 'football_drill_01.mp4', duration: '00:32', onTap: () => _selectVideo('football_drill_01.mp4', '00:32')),
          _MockFileTile(name: 'training_session.mp4', duration: '01:08', onTap: () => _selectVideo('training_session.mp4', '01:08')),
        ]))));
  }

  void _selectVideo(String fileName, String duration) {
    Navigator.pop(context);
    setState(() {
      _hasVideo = true;
      _fileName = fileName;
      _duration = duration;
    });
  }

  void _submit() => Navigator.pushNamed(context, AppRoutes.videoProcessing, arguments: widget.sportName);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.sizeOf(context).width < 600 ? 20.0 : 56.0;
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Your Performance')),
      body: SafeArea(child: SingleChildScrollView(padding: EdgeInsets.fromLTRB(padding, 18, padding, 32), child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 720), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(widget.sportName, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 6),
        const Text('Choose how you want to capture your performance.'),
        const SizedBox(height: 24),
        Row(children: [Expanded(child: _ModeCard(icon: Icons.videocam_outlined, label: 'Record Video', selected: !_hasVideo, onTap: () => Navigator.pushNamed(context, AppRoutes.simulatedCamera, arguments: widget.sportName))), const SizedBox(width: 12), Expanded(child: _ModeCard(icon: Icons.upload_file_outlined, label: 'Upload Video', selected: _hasVideo, onTap: _showMockFiles))]),
        const SizedBox(height: 24),
        AnimatedSwitcher(duration: const Duration(milliseconds: 280), child: _hasVideo ? _VideoPreview(key: ValueKey(_fileName), fileName: _fileName, duration: _duration, onReplace: _showMockFiles) : const _EmptyVideoState(key: ValueKey('empty'))),
        const SizedBox(height: 24),
        FilledButton.icon(onPressed: _hasVideo ? _submit : null, icon: const Icon(Icons.send_rounded), label: const Text('Submit for Assessment'), style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
      ]))))),
    );
  }
}

class _ModeCard extends StatelessWidget {
  const _ModeCard({required this.icon, required this.label, required this.selected, required this.onTap});
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(color: selected ? Theme.of(context).colorScheme.primary.withValues(alpha: .1) : null, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: BorderSide(color: selected ? Theme.of(context).colorScheme.primary : Colors.transparent, width: 2)), child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18), child: Padding(padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10), child: Column(children: [Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28), const SizedBox(height: 8), Text(label, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium)]))));
}

class _EmptyVideoState extends StatelessWidget {
  const _EmptyVideoState({super.key});

  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(24), child: Column(children: [Icon(Icons.movie_creation_outlined, size: 58, color: Theme.of(context).colorScheme.outline), const SizedBox(height: 12), Text('No video selected', style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 5), const Text('Record a new video or upload a mock video to continue.', textAlign: TextAlign.center)])));
}

class _VideoPreview extends StatelessWidget {
  const _VideoPreview({super.key, required this.fileName, required this.duration, required this.onReplace});
  final String fileName;
  final String duration;
  final VoidCallback onReplace;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(height: 170, decoration: BoxDecoration(color: const Color(0xFF17211B), borderRadius: BorderRadius.circular(14)), child: const Center(child: Icon(Icons.play_circle_fill_rounded, color: Colors.white, size: 58))),
          const SizedBox(height: 14),
          Row(children: [
            const Icon(Icons.video_file_outlined),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(fileName, style: Theme.of(context).textTheme.titleMedium), Text('Duration  •  $duration', style: Theme.of(context).textTheme.bodyMedium)])),
            TextButton(onPressed: onReplace, child: const Text('Replace video')),
          ]),
        ]),
      ),
    );
  }
}

class _MockFileTile extends StatelessWidget {
  const _MockFileTile({required this.name, required this.duration, required this.onTap});
  final String name;
  final String duration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ListTile(onTap: onTap, contentPadding: EdgeInsets.zero, leading: const CircleAvatar(child: Icon(Icons.video_file_outlined)), title: Text(name), subtitle: Text('Duration  •  $duration'), trailing: const Icon(Icons.chevron_right_rounded));
}