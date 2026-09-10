import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class SimulatedCameraScreen extends StatefulWidget {
  const SimulatedCameraScreen({super.key, required this.sportName});
  final String sportName;

  @override
  State<SimulatedCameraScreen> createState() => _SimulatedCameraScreenState();
}

class _SimulatedCameraScreenState extends State<SimulatedCameraScreen> {
  bool _isRecording = false;

  void _toggleRecording() {
    if (_isRecording) {
      Navigator.pushReplacementNamed(context, AppRoutes.videoSubmission, arguments: {'sportName': widget.sportName, 'hasRecordedVideo': true});
      return;
    }
    setState(() => _isRecording = true);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mock recording started')));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFF101512),
        appBar: AppBar(backgroundColor: Colors.transparent, foregroundColor: Colors.white, title: Text('${widget.sportName} recording')),
        body: SafeArea(child: Stack(children: [
          Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.person_outline_rounded, color: Color(0x80FFFFFF), size: 150), Text('Camera preview', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)), const SizedBox(height: 8), const Text('This is a simulated camera screen.', style: TextStyle(color: Color(0xB3FFFFFF)))])),
          Positioned(left: 24, right: 24, bottom: 24, child: Column(children: [if (_isRecording) const Padding(padding: EdgeInsets.only(bottom: 16), child: Text('RECORDING  •  00:04', style: TextStyle(color: Color(0xFFFF8A80), fontWeight: FontWeight.w700))), IconButton(onPressed: _toggleRecording, icon: Icon(_isRecording ? Icons.stop_rounded : Icons.fiber_manual_record_rounded, color: _isRecording ? Colors.white : const Color(0xFFFF6F61), size: 72), tooltip: _isRecording ? 'Stop mock recording' : 'Start mock recording')]))
        ])),
      );
}