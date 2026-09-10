import 'package:flutter/material.dart';

import '../../app/app.dart';
import '../../data/athlete_profile_data.dart';
import '../../routes/app_routes.dart';
import '../../widgets/athlete_profile_card.dart';

class AthleteProfileScreen extends StatelessWidget {
  const AthleteProfileScreen({super.key});

  void _showMessage(BuildContext context, String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

  void _showAppearance(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Appearance', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            const Text('Choose how SportAssess looks on this device.'),
            const SizedBox(height: 12),
            const _AppearanceOption(label: 'System default', icon: Icons.brightness_auto_outlined, mode: ThemeMode.system),
            const _AppearanceOption(label: 'Light theme', icon: Icons.light_mode_outlined, mode: ThemeMode.light),
            const _AppearanceOption(label: 'Dark theme', icon: Icons.dark_mode_outlined, mode: ThemeMode.dark),
          ]),
        ),
      ),
    );
  }

  void _showLanguage(BuildContext context) {
    showDialog<void>(context: context, builder: (context) => SimpleDialog(title: const Text('Language'), children: [SimpleDialogOption(onPressed: () => Navigator.pop(context), child: const Text('English')), SimpleDialogOption(onPressed: () => Navigator.pop(context), child: const Text('Hindi')), SimpleDialogOption(onPressed: () => Navigator.pop(context), child: const Text('Spanish'))]));
  }

  void _showInfo(BuildContext context, String title, String message) => showDialog<void>(context: context, builder: (context) => AlertDialog(title: Text(title), content: Text(message), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))]));

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.sizeOf(context).width < 600 ? 20.0 : 56.0;
    final profile = AthleteProfileData.mockProfile;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Settings')),
      body: SafeArea(child: SingleChildScrollView(padding: EdgeInsets.fromLTRB(padding, 16, padding, 36), child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 760), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _ProfileHeader(profile: profile),
        const SizedBox(height: 18),
        AthleteProfileCard(profile: profile, showEditButton: false),
        const SizedBox(height: 16),
        _ProfileStats(),
        const SizedBox(height: 28),
        Text('Account', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        _SettingsCard(children: [
          _SettingsTile(icon: Icons.edit_outlined, title: 'Edit Profile', onTap: () => Navigator.pushNamed(context, AppRoutes.profileEdit)),
          _SettingsTile(icon: Icons.assignment_outlined, title: 'My Assessments', onTap: () => Navigator.pushNamed(context, AppRoutes.assessments)),
          _SettingsTile(icon: Icons.bar_chart_rounded, title: 'Performance Statistics', onTap: () => Navigator.pushNamed(context, AppRoutes.detailedAnalysis, arguments: profile.preferredSport)),
          _SettingsTile(icon: Icons.fitness_center_outlined, title: 'Training Recommendations', onTap: () => Navigator.pushNamed(context, AppRoutes.trainingRecommendations, arguments: profile.preferredSport)),
        ]),
        const SizedBox(height: 22),
        Text('Preferences & support', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        _SettingsCard(children: [
          _SettingsTile(icon: Icons.notifications_none_rounded, title: 'Notifications', onTap: () => _showMessage(context, 'Notifications are enabled locally')),
          _SettingsTile(icon: Icons.palette_outlined, title: 'Appearance', onTap: () => _showAppearance(context), trailing: ValueListenableBuilder<ThemeMode>(valueListenable: themeModeNotifier, builder: (_, mode, child) => Text(_themeModeLabel(mode), style: Theme.of(context).textTheme.bodyMedium))),
          _SettingsTile(icon: Icons.language_outlined, title: 'Language', onTap: () => _showLanguage(context), trailing: const Text('English')),
          _SettingsTile(icon: Icons.help_outline_rounded, title: 'Help & Support', onTap: () => _showInfo(context, 'Help & Support', 'This local demo includes guided assessment screens. Support messaging will be connected in a future phase.')),
          _SettingsTile(icon: Icons.info_outline_rounded, title: 'About', onTap: () => _showInfo(context, 'About SportAssess', 'SportAssess helps athletes understand their potential through structured performance assessment.')),
        ]),
        const SizedBox(height: 22),
        OutlinedButton.icon(onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false), icon: const Icon(Icons.logout_rounded), label: const Text('Logout'), style: OutlinedButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error, side: BorderSide(color: Theme.of(context).colorScheme.error.withValues(alpha: .35)), padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
      ]))))),
    );
  }

  static String _themeModeLabel(ThemeMode mode) => switch (mode) { ThemeMode.light => 'Light', ThemeMode.dark => 'Dark', ThemeMode.system => 'System' };
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.profile});
  final dynamic profile;

  @override
  Widget build(BuildContext context) => Row(children: [const CircleAvatar(radius: 30, backgroundColor: Color(0xFFE4F2B5), child: Icon(Icons.person_rounded, color: Color(0xFF176B45), size: 34)), const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(profile.fullName, style: Theme.of(context).textTheme.headlineSmall), const SizedBox(height: 3), const Text('Athlete profile')]))]);
}

class _ProfileStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(children: [Expanded(child: _Stat(value: '87', label: 'Overall score', icon: Icons.insights_rounded)), const SizedBox(width: 10), Expanded(child: _Stat(value: '6', label: 'Assessments', icon: Icons.assignment_turned_in_outlined))]);
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, required this.icon});
  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [Icon(icon, color: Theme.of(context).colorScheme.primary), const SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value, style: Theme.of(context).textTheme.titleLarge), Text(label, style: Theme.of(context).textTheme.bodyMedium)])])));
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Card(child: Column(children: children));
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.icon, required this.title, required this.onTap, this.trailing});
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => ListTile(onTap: onTap, leading: Icon(icon, color: Theme.of(context).colorScheme.primary), title: Text(title), trailing: trailing ?? const Icon(Icons.chevron_right_rounded));
}

class _AppearanceOption extends StatelessWidget {
  const _AppearanceOption({required this.label, required this.icon, required this.mode});
  final String label;
  final IconData icon;
  final ThemeMode mode;

  @override
  Widget build(BuildContext context) => ListTile(leading: Icon(icon), title: Text(label), trailing: themeModeNotifier.value == mode ? const Icon(Icons.check_rounded) : null, onTap: () { themeModeNotifier.value = mode; Navigator.pop(context); });
}