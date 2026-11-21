import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class FollowUpConfirmedScreen extends StatelessWidget {
  const FollowUpConfirmedScreen({super.key});

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
              const Text('Follow-up scheduled', textAlign: TextAlign.center, style: AppText.h1),
              const SizedBox(height: 6),
              const Text('Nadeen will be reminded 24 hours before.', textAlign: TextAlign.center, style: AppText.caption),
              const SizedBox(height: 24),
              const Card(
                child: Column(
                  children: [
                    ListTile(leading: Icon(Icons.person_outline), title: Text('Nadeen Ayman')),
                    Divider(),
                    ListTile(leading: Icon(Icons.calendar_today_outlined), title: Text('Wed 11 Nov · 10:30')),
                    Divider(),
                    ListTile(leading: Icon(Icons.videocam_outlined), title: Text('Video call')),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: AppDecor.bottomPadding,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.doctorHome,
                ModalRoute.withName(AppRoutes.index),
              ),
              child: const Text('Back to home'),
            ),
          ),
        ),
      ),
    );
  }
}
