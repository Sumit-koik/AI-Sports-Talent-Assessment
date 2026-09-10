import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/dashboard_item.dart';
import '../../routes/app_routes.dart';
import '../../widgets/sport_card.dart';

class SportSelectionScreen extends StatefulWidget {
  const SportSelectionScreen({super.key});

  @override
  State<SportSelectionScreen> createState() => _SportSelectionScreenState();
}

class _SportSelectionScreenState extends State<SportSelectionScreen> {
  SportOption? _selectedSport;

  void _continue() {
    final sport = _selectedSport;
    if (sport == null) return;
    Navigator.pushNamed(context, AppRoutes.sportPreparation, arguments: sport.name);
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.sizeOf(context).width < 600 ? 20.0 : 56.0;
    return Scaffold(
      appBar: AppBar(title: const Text('Select Your Sport')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(padding, 18, padding, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Choose your arena', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 6),
                const Text('Select a sport to tailor your next performance assessment.'),
                const SizedBox(height: 24),
                LayoutBuilder(builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 760 ? 3 : 2;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: MockData.sports.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: columns == 3 ? 1.25 : .95),
                    itemBuilder: (_, index) {
                      final sport = MockData.sports[index];
                      return SportCard(sport: sport, showDescription: true, isSelected: _selectedSport == sport, onTap: () => setState(() => _selectedSport = sport));
                    },
                  );
                }),
                const SizedBox(height: 24),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 240),
                  child: _selectedSport == null
                      ? const SizedBox(height: 54)
                      : Row(key: ValueKey(_selectedSport!.name), children: [Icon(Icons.check_circle_rounded, color: Theme.of(context).colorScheme.primary), const SizedBox(width: 8), Expanded(child: Text('${_selectedSport!.name} selected', style: Theme.of(context).textTheme.titleMedium))]),
                ),
                const SizedBox(height: 12),
                SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: _selectedSport == null ? null : _continue, icon: const Icon(Icons.arrow_forward_rounded), label: const Text('Continue'), style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))))),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}