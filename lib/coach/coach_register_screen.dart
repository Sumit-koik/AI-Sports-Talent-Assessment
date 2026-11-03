
import 'package:flutter/material.dart';

class CoachRegisterScreen extends StatefulWidget {
  const CoachRegisterScreen({super.key});

  @override
  State<CoachRegisterScreen> createState() =>
      _CoachRegisterScreenState();
}

class _CoachRegisterScreenState
    extends State<CoachRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _experienceController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedSport;

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  static const Color navy = Color(0xFF173B62);

  final List<String> sports = [
    'Cricket',
    'Football',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _experienceController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }


  void _register() {
    debugPrint('SPORTIQ: Coach Register button clicked');

    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the registration details.'),
        ),
      );
      debugPrint('SPORTIQ: Registration validation failed');
      return;
    }

    debugPrint('SPORTIQ: Registration validation successful');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registration successful! (Demo only)'),
        backgroundColor: Colors.green,
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }


  InputDecoration _decoration(
      String label,
      IconData icon,
      ) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Coach Registration'),
        backgroundColor: navy,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_add_alt_1,
                size: 65,
                color: navy,
              ),
              const SizedBox(height: 12),
              const Text(
                'Create Coach Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Join SPORTIQ and help athletes improve.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 28),

              // Full Name
              TextFormField(
                controller: _nameController,
                decoration: _decoration(
                  'Full Name',
                  Icons.person_outline,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter your full name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _decoration(
                  'Email Address',
                  Icons.email_outlined,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter your email';
                  }

                  if (!RegExp(
                    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                  ).hasMatch(value.trim())) {
                    return 'Enter a valid email';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Phone
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: _decoration(
                  'Phone Number',
                  Icons.phone_outlined,
                ),
                validator: (value) {
                  if (value == null ||
                      !RegExp(r'^[0-9]{10}$')
                          .hasMatch(value.trim())) {
                    return 'Enter a valid 10-digit number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Sport
              DropdownButtonFormField<String>(
                initialValue: _selectedSport,
                decoration: _decoration(
                  'Select Sport',
                  Icons.sports,
                ),
                items: sports.map((sport) {
                  return DropdownMenuItem(
                    value: sport,
                    child: Text(sport),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSport = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a sport';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Experience
              TextFormField(
                controller: _experienceController,
                keyboardType: TextInputType.number,
                decoration: _decoration(
                  'Coaching Experience (Years)',
                  Icons.workspace_premium_outlined,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter your experience';
                  }

                  final years = int.tryParse(value.trim());

                  if (years == null || years < 0 || years > 60) {
                    return 'Enter valid years (0-60)';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: _passwordController,
                obscureText: _hidePassword,
                decoration: _decoration(
                  'Password',
                  Icons.lock_outline,
                ).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _hidePassword = !_hidePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Minimum 6 characters required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Confirm Password
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _hideConfirmPassword,
                decoration: _decoration(
                  'Confirm Password',
                  Icons.lock_reset,
                ).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _hideConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _hideConfirmPassword =
                        !_hideConfirmPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 28),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    color: navy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
