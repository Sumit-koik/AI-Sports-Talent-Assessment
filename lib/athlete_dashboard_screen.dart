
import 'package:flutter/material.dart';

class AthleteDashboardScreen extends StatelessWidget {
  const AthleteDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        title: const Text('SPORTIQ'),
        backgroundColor: const Color(0xFF16A765),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile coming soon')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome, Athlete!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Assess your skills. Track your progress.',
                style: TextStyle(color: Colors.blueGrey),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF16A765),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.sports, size: 42, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'Ready to assess your skills?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Choose a sport to begin.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Choose Your Sport',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _SportCard(
                icon: Icons.sports_cricket,
                title: 'Cricket',
                subtitle: 'Bowling assessment',
                onTap: () => _showMessage(context, 'Cricket'),
              ),
              const SizedBox(height: 12),
              _SportCard(
                icon: Icons.sports_soccer,
                title: 'Football',
                subtitle: 'Dribbling assessment',
                onTap: () => _showMessage(context, 'Football'),
              ),
              const SizedBox(height: 28),
              const Text(
                'Your Progress',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.history,
                    color: Color(0xFF16A765),
                  ),
                  title: const Text('Assessment History'),
                  subtitle: const Text('View previous assessments'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showMessage(context, 'History'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void _showMessage(BuildContext context, String item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$item selected. More features coming soon.')),
    );
  }
}

class _SportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SportCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE0F5E9),
          child: Icon(icon, color: const Color(0xFF16A765)),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
