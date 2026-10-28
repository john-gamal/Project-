import 'package:flutter/material.dart';
import 'package:project/widgets/auth_header.dart';
import 'package:project/widgets/auth_scaffold.dart';
import '../core/app_routes.dart';
import '../core/app_theme.dart';
import '../widgets/app_buttons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email =
        (ModalRoute.of(context)?.settings.arguments as String?) ??
        'you@example.com';

    return Scaffold(
      body: AuthScaffold(
        header: AuthHeader(
          title: 'You are in !',
          subtitle: 'Signed in as $email',
        ),
        child: Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(34),
                topRight: Radius.circular(34),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quick actions',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 19),
                const Row(
                  children: [
                    Expanded(
                      child: _QuickAction(
                        icon: Icons.person_outline,
                        label: 'Profile',
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: _QuickAction(
                        icon: Icons.settings_outlined,
                        label: 'Settings',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _QuickAction(
                        icon: Icons.help_outline,
                        label: 'Help',
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const SizedBox(height: 24),
                OutlineActionButton(
                  label: 'Log out',
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.fill,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
