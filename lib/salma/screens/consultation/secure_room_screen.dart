import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class SecureRoomScreen extends StatefulWidget {
  const SecureRoomScreen({super.key});

  @override
  State<SecureRoomScreen> createState() => _SecureRoomScreenState();
}

class _SecureRoomScreenState extends State<SecureRoomScreen> {
  // Real value = the system permission (read-only in the final app).
  bool _camera = true;
  bool _mic = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.background,
      child: Scaffold(
        appBar: AppBar(title: const Text('Secure room')),
        body: ListView(
          padding: AppDecor.pagePadding,
          children: [
            const SizedBox(height: 8),
            const Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.greenBg,
                child: Icon(Icons.shield_outlined, size: 40, color: AppColors.green),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Private room for this visit', textAlign: TextAlign.center, style: AppText.h1),
            const SizedBox(height: 6),
            const Text(
              'Visit #HC-5521 · only verified participants can enter.',
              textAlign: TextAlign.center,
              style: AppText.caption,
            ),
            const SizedBox(height: 20),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.blueBg,
                      child: Icon(Icons.person_outline, color: AppColors.blue),
                    ),
                    title: const Text('You'),
                    subtitle: const Text('Identity verified'),
                    trailing: Chip(
                      label: Text('Verified', style: AppText.caption.copyWith(color: AppColors.greenText)),
                      backgroundColor: AppColors.greenBg,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.lavenderBg,
                      child: Icon(Icons.medical_services_outlined, color: AppColors.lavender),
                    ),
                    title: const Text('Dr. Cecily Welsh'),
                    subtitle: const Text('License verified'),
                    trailing: Chip(
                      label: Text('Verified', style: AppText.caption.copyWith(color: AppColors.greenText)),
                      backgroundColor: AppColors.greenBg,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.videocam_outlined),
                    title: const Text('Camera access'),
                    subtitle: const Text('Allow during visit'),
                    value: _camera,
                    onChanged: (v) => setState(() => _camera = v),
                  ),
                  const Divider(),
                  SwitchListTile(
                    secondary: const Icon(Icons.mic_none),
                    title: const Text('Microphone access'),
                    subtitle: const Text('Allow during visit'),
                    value: _mic,
                    onChanged: (v) => setState(() => _mic = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton.icon(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Camera and microphone work')),
                ),
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Test camera and mic'),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: AppDecor.bottomPadding,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.waitingRoom),
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Enter room'),
            ),
          ),
        ),
      ),
    );
  }
}
