import 'package:flutter/material.dart';

import '../../data/athlete_profile_data.dart';
import '../../routes/app_routes.dart';
import '../../widgets/auth_scaffold.dart';
import '../../widgets/brand_mark.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) => const _ProfileFormScreen(isEdit: false);
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => const _ProfileFormScreen(isEdit: true);
}

class _ProfileFormScreen extends StatefulWidget {
  const _ProfileFormScreen({required this.isEdit});
  final bool isEdit;

  @override
  State<_ProfileFormScreen> createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<_ProfileFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  late final TextEditingController _locationController;
  DateTime? _dateOfBirth;
  String? _gender;
  String? _sport;
  String? _experience;
  String? _position;
  String? _dominantSide;
  bool _isLoading = false;
  bool _submitted = false;

  static const _sports = ['Football', 'Cricket', 'Basketball', 'Volleyball', 'Tennis', 'Badminton', 'Athletics', 'Other'];
  static const _experienceLevels = ['Beginner', 'Intermediate', 'Advanced'];
  static const _genders = ['Female', 'Male', 'Prefer not to say'];
  static const _positions = ['Goalkeeper', 'Defender', 'Midfielder', 'Forward', 'All-rounder', 'Other'];
  static const _dominantSides = ['Right hand / foot', 'Left hand / foot', 'Both'];

  @override
  void initState() {
    super.initState();
    final profile = widget.isEdit ? AthleteProfileData.mockProfile : null;
    _nameController = TextEditingController(text: profile?.fullName);
    _heightController = TextEditingController(text: profile?.height.replaceAll(' cm', ''));
    _weightController = TextEditingController(text: profile?.weight.replaceAll(' kg', ''));
    _locationController = TextEditingController(text: profile?.location);
    _dateOfBirth = profile?.dateOfBirth;
    _gender = profile?.gender;
    _sport = profile?.preferredSport;
    _experience = profile?.experienceLevel;
    _position = profile?.position;
    _dominantSide = profile?.dominantSide;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(context: context, firstDate: DateTime(1950), lastDate: DateTime.now(), initialDate: _dateOfBirth ?? DateTime(2005));
    if (date != null) setState(() => _dateOfBirth = date);
  }

  Future<void> _saveProfile() async {
    setState(() => _submitted = true);
    final formIsValid = _formKey.currentState?.validate() ?? false;
    final selectionsAreValid = _dateOfBirth != null && _gender != null && _sport != null && _experience != null && _position != null && _dominantSide != null;
    if (!formIsValid || !selectionsAreValid) {
      setState(() {});
      return;
    }
    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(widget.isEdit ? 'Profile updated locally' : 'Profile created locally')));
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.profile, (route) => false);
  }

  @override
  Widget build(BuildContext context) => AuthScaffold(
        child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          IconButton(onPressed: () => Navigator.pop(context), alignment: Alignment.centerLeft, padding: EdgeInsets.zero, icon: const Icon(Icons.arrow_back_rounded), tooltip: 'Go back'),
          const SizedBox(height: 8),
          Center(child: Stack(alignment: Alignment.bottomRight, children: [const BrandMark(size: 84), IconButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Photo selection is mocked locally'))), style: IconButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary, foregroundColor: Theme.of(context).colorScheme.onPrimary), icon: const Icon(Icons.camera_alt_outlined, size: 18), tooltip: 'Change profile photo')])),
          const SizedBox(height: 18),
          Text(widget.isEdit ? 'Edit athlete profile' : 'Set up your athlete profile', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          Text(widget.isEdit ? 'Keep your details fresh and assessment-ready.' : 'Tell us about the athlete behind the effort.', textAlign: TextAlign.center),
          const SizedBox(height: 26),
          TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Full name', prefixIcon: Icon(Icons.badge_outlined)), validator: (value) => value == null || value.trim().length < 2 ? 'Enter your full name' : null),
          const SizedBox(height: 14),
          OutlinedButton.icon(onPressed: _pickDate, icon: const Icon(Icons.calendar_month_outlined), label: Text(_dateOfBirth == null ? 'Date of birth' : '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}'), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15), alignment: Alignment.centerLeft)),
          const SizedBox(height: 14),
          _dropdown(label: 'Gender', value: _gender, values: _genders, onChanged: (value) => setState(() => _gender = value)),
          const SizedBox(height: 14),
          Row(children: [Expanded(child: TextFormField(controller: _heightController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Height (cm)', prefixIcon: Icon(Icons.height_rounded)), validator: _numberValidator)), const SizedBox(width: 12), Expanded(child: TextFormField(controller: _weightController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Weight (kg)', prefixIcon: Icon(Icons.monitor_weight_outlined)), validator: _numberValidator))]),
          const SizedBox(height: 14),
          TextFormField(controller: _locationController, decoration: const InputDecoration(labelText: 'Location', prefixIcon: Icon(Icons.location_on_outlined)), validator: (value) => value == null || value.trim().isEmpty ? 'Enter your location' : null),
          const SizedBox(height: 14),
          _dropdown(label: 'Preferred sport', value: _sport, values: _sports, onChanged: (value) => setState(() => _sport = value)),
          const SizedBox(height: 14),
          _dropdown(label: 'Experience level', value: _experience, values: _experienceLevels, onChanged: (value) => setState(() => _experience = value)),
          const SizedBox(height: 14),
          _dropdown(label: 'Playing position', value: _position, values: _positions, onChanged: (value) => setState(() => _position = value)),
          const SizedBox(height: 14),
          _dropdown(label: 'Dominant hand / foot', value: _dominantSide, values: _dominantSides, onChanged: (value) => setState(() => _dominantSide = value)),
          if (_submitted && (_dateOfBirth == null || _gender == null || _sport == null || _experience == null || _position == null || _dominantSide == null))
            Padding(padding: const EdgeInsets.only(top: 8), child: Text('Complete your date of birth, gender, sport, experience, position and dominant side.', style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12))),
          const SizedBox(height: 24),
          FilledButton(onPressed: _isLoading ? null : _saveProfile, style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : Text(widget.isEdit ? 'Save changes' : 'Create profile')),
        ])),
      );

  Widget _dropdown({required String label, required String? value, required List<String> values, required ValueChanged<String?> onChanged}) => DropdownButtonFormField<String>(initialValue: value, decoration: InputDecoration(labelText: label), items: values.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(), onChanged: onChanged);
}

String? _numberValidator(String? value) {
  if (value == null || value.trim().isEmpty) return 'Required';
  if (double.tryParse(value) == null) return 'Enter a number';
  return null;
}