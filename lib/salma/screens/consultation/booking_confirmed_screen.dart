import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class BookingConfirmedScreen extends StatelessWidget {
  const BookingConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.background,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: AppDecor.pagePadding,
            children: [
              const SizedBox(height: 32),
              const Center(
                child: CircleAvatar(
                  radius: 44,
                  backgroundColor: AppColors.greenBg,
                  child: Icon(Icons.check, size: 44, color: AppColors.green),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Booking confirmed', textAlign: TextAlign.center, style: AppText.h1),
              const SizedBox(height: 6),
              const Text("We'll remind you 1 hour before.", textAlign: TextAlign.center, style: AppText.caption),
              const SizedBox(height: 24),
              const Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.avatarBg,
                        child: Text('CW', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.navy)),
                      ),
                      title: Text('Dr. Cecily Welsh'),
                      subtitle: Text('Endocrinologist'),
                    ),
                    Divider(),
                    ListTile(leading: Icon(Icons.calendar_today_outlined), title: Text('Tue 27 Oct · 10:30')),
                    ListTile(leading: Icon(Icons.videocam_outlined), title: Text('Video call · \$45 paid')),
                    ListTile(leading: Icon(Icons.edit_note), title: Text('Follow-up on blood sugar levels')),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: AppDecor.bottomPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.visitDetails),
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('View visit'),
                ),
                const SizedBox(height: 10),
                // TODO: link to the Documents "Share with doctor" screen
                OutlinedButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opens Share with doctor (Documents flow)')),
                  ),
                  child: const Text('Share documents with doctor'),
                ),
                TextButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to calendar')),
                  ),
                  child: const Text('Add to calendar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
