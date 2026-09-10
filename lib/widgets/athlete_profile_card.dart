import 'package:flutter/material.dart';

import '../models/athlete_profile.dart';
import '../routes/app_routes.dart';

class AthleteProfileCard extends StatelessWidget {
  const AthleteProfileCard({super.key, required this.profile, this.showEditButton = true});

  final AthleteProfile profile;
  final bool showEditButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const CircleAvatar(radius: 34, backgroundColor: Color(0xFFE4F2B5), child: Icon(Icons.person_rounded, size: 38, color: Color(0xFF176B45))),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(profile.fullName, style: theme.textTheme.titleLarge), const SizedBox(height: 4), Text('${profile.preferredSport}  •  ${profile.experienceLevel}', style: theme.textTheme.bodyMedium), const SizedBox(height: 3), Text(profile.location, style: theme.textTheme.bodyMedium)])),
            if (showEditButton) IconButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.profileEdit), icon: const Icon(Icons.edit_outlined), tooltip: 'Edit profile'),
          ]),
          const SizedBox(height: 20),
          Wrap(spacing: 8, runSpacing: 8, children: [
            _ProfileTag(icon: Icons.height_rounded, label: profile.height),
            _ProfileTag(icon: Icons.monitor_weight_outlined, label: profile.weight),
            _ProfileTag(icon: Icons.sports_soccer_rounded, label: profile.position),
            _ProfileTag(icon: Icons.back_hand_outlined, label: profile.dominantSide),
          ]),
        ]),
      ),
    );
  }
}

class _ProfileTag extends StatelessWidget {
  const _ProfileTag({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Chip(avatar: Icon(icon, size: 16), label: Text(label), visualDensity: VisualDensity.compact);
}