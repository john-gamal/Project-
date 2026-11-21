import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class PatientFileScreen extends StatelessWidget {
  const PatientFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.background,
      child: Scaffold(
        appBar: AppBar(title: const Text('Patient file')),
        body: ListView(
          padding: AppDecor.pagePadding,
          children: [
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.lavenderBg,
                  child: Text('NA', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.lavender)),
                ),
                title: const Text('Nadeen Ayman'),
                subtitle: const Text('22 y · Female · O+'),
                trailing: Chip(
                  label: Text('Video 10:30', style: AppText.caption.copyWith(color: AppColors.redText)),
                  backgroundColor: AppColors.redBg,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Allergies first, as required by the UX fix.
            Card(
              color: AppColors.redBg,
              child: const Padding(
                padding: AppDecor.cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning_amber_rounded, color: AppColors.red, size: 20),
                        SizedBox(width: 6),
                        Text('Allergies', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.redText)),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Peanuts (severe) · Penicillin (moderate) · Pollen (mild)',
                      style: TextStyle(fontSize: 14, color: AppColors.redText),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Conditions', style: AppText.section),
            const SizedBox(height: 8),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text('Type 2 Diabetes'), backgroundColor: AppColors.white),
                Chip(label: Text('Hypertension'), backgroundColor: AppColors.white),
                Chip(label: Text('Asthma'), backgroundColor: AppColors.white),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Current medications', style: AppText.section),
            const SizedBox(height: 8),
            const Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.medication_outlined),
                    title: Text('Metformin 500 mg'),
                    subtitle: Text('Twice daily'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.medication_outlined),
                    title: Text('Lisinopril 10 mg'),
                    subtitle: Text('Once daily'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                onTap: () {},
                leading: const CircleAvatar(
                  backgroundColor: AppColors.blueBg,
                  child: Icon(Icons.folder_outlined, color: AppColors.blue),
                ),
                title: const Text('Shared by patient (2)'),
                subtitle: const Text('Chest X-ray, Lipid panel'),
                trailing: Chip(
                  label: Text('New', style: AppText.caption.copyWith(color: AppColors.greenText)),
                  backgroundColor: AppColors.greenBg,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: AppDecor.bottomPadding,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.videoCallDoctor),
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Start call'),
            ),
          ),
        ),
      ),
    );
  }
}
