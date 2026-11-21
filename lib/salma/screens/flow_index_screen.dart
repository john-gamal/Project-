import 'package:flutter/material.dart';

import '../routes.dart';
import '../theme.dart';

/// Review-only launcher: jump to any screen. Not part of the real app.
class FlowIndexScreen extends StatelessWidget {
  const FlowIndexScreen({super.key});

  static const _consultation = [
    ('1 · Choose doctor', AppRoutes.chooseDoctor),
    ('2 · Doctor profile', AppRoutes.doctorProfile),
    ('3 · Book visit', AppRoutes.bookVisit),
    ('4 · Booking confirmed', AppRoutes.bookingConfirmed),
    ('5 · Visit details', AppRoutes.visitDetails),
    ('6 · Secure room check', AppRoutes.secureRoom),
    ('7 · Waiting room', AppRoutes.waitingRoom),
    ('8 · Video call', AppRoutes.videoCall),
    ('9 · Audio call', AppRoutes.audioCall),
    ('10 · Connection lost (reconnecting)', AppRoutes.connectionLost),
    ('10b · Connection lost (after 5 attempts)', AppRoutes.connectionFailed),
    ('11 · Visit ended', AppRoutes.visitEnded),
    ('12 · Visit report', AppRoutes.visitReport),
  ];

  static const _doctor = [
    ('1 · Doctor home', AppRoutes.doctorHome),
    ('2 · Patient file', AppRoutes.patientFile),
    ('3 · Call (doctor side)', AppRoutes.videoCallDoctor),
    ('4 · Visit summary', AppRoutes.visitSummary),
    ('5 · New prescription', AppRoutes.newPrescription),
    ('6 · Review & sign', AppRoutes.reviewSign),
    ('7 · Saved to medical record', AppRoutes.savedRecord),
    ('8 · Follow-up', AppRoutes.followUp),
    ('9 · Follow-up confirmed', AppRoutes.followUpConfirmed),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.background,
      child: Scaffold(
        appBar: AppBar(title: const Text('MediCore · UI screens')),
        body: ListView(
          padding: AppDecor.pagePadding,
          children: [
            const Text('Consultation Flow', style: AppText.h2),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  for (final s in _consultation)
                    ListTile(
                      title: Text(s.$1, style: AppText.body),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.pushNamed(context, s.$2),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Doctor Flow', style: AppText.h2),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  for (final s in _doctor)
                    ListTile(
                      title: Text(s.$1, style: AppText.body),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.pushNamed(context, s.$2),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
