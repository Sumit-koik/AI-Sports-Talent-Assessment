import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/auth_scaffold.dart';
import '../../widgets/brand_mark.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  DateTime? _dateOfBirth;
  String? _gender;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(context: context, firstDate: DateTime(1950), lastDate: DateTime.now(), initialDate: DateTime(2005));
    if (date != null) setState(() => _dateOfBirth = date);
  }

  Future<void> _createAccount() async {
    setState(() => _submitted = true);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_dateOfBirth == null || _gender == null) {
      setState(() {});
      return;
    }
    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account created successfully')));
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
  }

  @override
  Widget build(BuildContext context) => AuthScaffold(
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            IconButton(onPressed: () => Navigator.pop(context), alignment: Alignment.centerLeft, padding: EdgeInsets.zero, icon: const Icon(Icons.arrow_back_rounded), tooltip: 'Go back'),
            const SizedBox(height: 12),
            const BrandMark(size: 64),
            const SizedBox(height: 20),
            Text('Create your account', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 6),
            const Text('Start your journey with a profile built around your potential.'),
            const SizedBox(height: 24),
            TextFormField(controller: _nameController, textInputAction: TextInputAction.next, decoration: const InputDecoration(labelText: 'Full name', prefixIcon: Icon(Icons.badge_outlined)), validator: (value) => value == null || value.trim().length < 2 ? 'Enter your full name' : null),
            const SizedBox(height: 14),
            TextFormField(controller: _emailController, keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next, decoration: const InputDecoration(labelText: 'Email address', prefixIcon: Icon(Icons.mail_outline_rounded)), validator: _validateRegistrationEmail),
            const SizedBox(height: 14),
            TextFormField(controller: _phoneController, keyboardType: TextInputType.phone, textInputAction: TextInputAction.next, decoration: const InputDecoration(labelText: 'Phone number', prefixIcon: Icon(Icons.phone_outlined)), validator: (value) => value == null || value.trim().length < 7 ? 'Enter a valid phone number' : null),
            const SizedBox(height: 14),
            TextFormField(controller: _passwordController, obscureText: _obscurePassword, textInputAction: TextInputAction.next, decoration: InputDecoration(labelText: 'Password', prefixIcon: const Icon(Icons.lock_outline_rounded), suffixIcon: IconButton(onPressed: () => setState(() => _obscurePassword = !_obscurePassword), icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined))), validator: (value) => value == null || value.length < 6 ? 'Use at least 6 characters' : null),
            const SizedBox(height: 14),
            TextFormField(controller: _confirmController, obscureText: _obscureConfirm, textInputAction: TextInputAction.done, decoration: InputDecoration(labelText: 'Confirm password', prefixIcon: const Icon(Icons.verified_user_outlined), suffixIcon: IconButton(onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm), icon: Icon(_obscureConfirm ? Icons.visibility_outlined : Icons.visibility_off_outlined))), validator: (value) => value != _passwordController.text ? 'Passwords do not match' : null),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(child: OutlinedButton.icon(onPressed: _pickDate, icon: const Icon(Icons.calendar_month_outlined), label: Text(_dateOfBirth == null ? 'Date of birth' : '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}'), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15), alignment: Alignment.centerLeft))),
              const SizedBox(width: 12),
              Expanded(child: DropdownButtonFormField<String>(initialValue: _gender, decoration: const InputDecoration(labelText: 'Gender'), items: const [DropdownMenuItem(value: 'Female', child: Text('Female')), DropdownMenuItem(value: 'Male', child: Text('Male')), DropdownMenuItem(value: 'Prefer not to say', child: Text('Prefer not to say'))], onChanged: (value) => setState(() => _gender = value))),
            ]),
            if (_submitted && (_dateOfBirth == null || _gender == null)) Padding(padding: const EdgeInsets.only(top: 8), child: Text(_dateOfBirth == null ? 'Select your date of birth and gender' : 'Select your gender', style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12))),
            const SizedBox(height: 22),
            FilledButton(onPressed: _isLoading ? null : _createAccount, style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Create account')),
          ]),
        ),
      );
}

String? _validateRegistrationEmail(String? value) {
  if (value == null || value.trim().isEmpty) return 'Enter your email address';
  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())) return 'Enter a valid email address';
  return null;
}