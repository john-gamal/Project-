import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class VisitSummaryScreen extends StatelessWidget {
  const VisitSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.background,
      child: Scaffold(
        appBar: AppBar(title: const Text('Visit summary')),
        body: ListView(
          padding: AppDecor.pagePadding,
          children: [
            const Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.lavenderBg,
                  child: Text('NA', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.lavender)),
                ),
                title: Text('Nadeen Ayman'),
                subtitle: Text('22 y · Video visit · 12:04'),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: 'Fatigue and increased thirst',
              decoration: const InputDecoration(labelText: 'Chief complaint'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: 'Type 2 diabetes, well controlled',
              decoration: const InputDecoration(labelText: 'Diagnosis'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Clinical notes',
                alignLabelWithHint: true,
                hintText: 'Add observations and plan',
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: AppDecor.bottomPadding,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.newPrescription),
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Continue to prescription'),
            ),
          ),
        ),
      ),
    );
  }
}
