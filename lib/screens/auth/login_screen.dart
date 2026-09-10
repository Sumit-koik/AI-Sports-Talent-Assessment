import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/brand_mark.dart';
import '../../widgets/auth_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 850));
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
  }

  void _continueAsGuest() => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);

  @override
  Widget build(BuildContext context) => AuthScaffold(
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const BrandMark(size: 72),
            const SizedBox(height: 24),
            Text('Welcome back', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 6),
            const Text('Sign in to keep building your athlete profile.'),
            const SizedBox(height: 28),
            TextFormField(controller: _emailController, keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next, decoration: const InputDecoration(labelText: 'Email address', prefixIcon: Icon(Icons.mail_outline_rounded)), validator: _validateEmail),
            const SizedBox(height: 16),
            TextFormField(controller: _passwordController, obscureText: _obscurePassword, textInputAction: TextInputAction.done, onFieldSubmitted: (_) => _login(), decoration: InputDecoration(labelText: 'Password', prefixIcon: const Icon(Icons.lock_outline_rounded), suffixIcon: IconButton(onPressed: () => setState(() => _obscurePassword = !_obscurePassword), icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined), tooltip: _obscurePassword ? 'Show password' : 'Hide password')), validator: (value) => value == null || value.length < 6 ? 'Use at least 6 characters' : null),
            Row(children: [
              Checkbox(value: _rememberMe, onChanged: (value) => setState(() => _rememberMe = value ?? false)),
              const Text('Remember me'),
              const Spacer(),
              TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.forgotPassword), child: const Text('Forgot password?')),
            ]),
            const SizedBox(height: 12),
            FilledButton(onPressed: _isLoading ? null : _login, style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Login')),
            const SizedBox(height: 22),
            Center(child: Wrap(alignment: WrapAlignment.center, children: [const Text("Don't have an account? "), TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.registration), child: const Text('Create account'))])),
            const Divider(height: 28),
            TextButton.icon(onPressed: _continueAsGuest, icon: const Icon(Icons.person_outline_rounded), label: const Text('Continue as guest')),
          ]),
        ),
      );
}

String? _validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) return 'Enter your email address';
  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())) return 'Enter a valid email address';
  return null;
}

