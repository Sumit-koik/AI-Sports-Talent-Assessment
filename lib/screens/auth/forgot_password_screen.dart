import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/auth_scaffold.dart';
import '../../widgets/brand_mark.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _sent = true;
    });
  }

  @override
  Widget build(BuildContext context) => AuthScaffold(
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            IconButton(onPressed: () => Navigator.pop(context), alignment: Alignment.centerLeft, padding: EdgeInsets.zero, icon: const Icon(Icons.arrow_back_rounded), tooltip: 'Go back'),
            const SizedBox(height: 36),
            const Center(child: BrandMark(size: 72)),
            const SizedBox(height: 24),
            Text(_sent ? 'Check your inbox' : 'Reset your password', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(_sent ? 'A mock reset link has been sent to ${_emailController.text.trim()}.' : 'Enter your email and we will send a link to reset your password.', textAlign: TextAlign.center),
            const SizedBox(height: 28),
            if (_sent)
              Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: BorderRadius.circular(16)), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.check_circle_rounded, color: Theme.of(context).colorScheme.primary), const SizedBox(width: 12), const Expanded(child: Text('Success. This is a local demo, so no real email was sent.'))]))
            else ...[
              TextFormField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email address', prefixIcon: Icon(Icons.mail_outline_rounded)), validator: (value) => value == null || !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim()) ? 'Enter a valid email address' : null),
              const SizedBox(height: 20),
              FilledButton(onPressed: _isLoading ? null : _sendResetLink, style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Send reset link')),
            ],
            const SizedBox(height: 18),
            TextButton(onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login), child: Text(_sent ? 'Back to login' : 'Remember your password? Login')),
          ]),
        ),
      );
}