import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class ReviewSignScreen extends StatefulWidget {
  const ReviewSignScreen({super.key});

  @override
  State<ReviewSignScreen> createState() => _ReviewSignScreenState();
}

class _ReviewSignScreenState extends State<ReviewSignScreen> {
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.background,
      child: Scaffold(
        appBar: AppBar(title: const Text('Review prescription')),
        body: ListView(
          padding: AppDecor.pagePadding,
          children: [
            Card(
              child: ListTile(
                title: const Text('Patient'),
                subtitle: const Text('Nadeen Ayman', style: AppText.h2),
                trailing: Chip(
                  avatar: const Icon(Icons.warning_amber_rounded, size: 14, color: AppColors.red),
                  label: Text('Penicillin', style: AppText.caption.copyWith(color: AppColors.redText)),
                  backgroundColor: AppColors.redBg,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.medication_outlined),
                    title: Text('Metformin 500 mg'),
                    subtitle: Text('Twice daily · 30 days'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.medication_outlined),
                    title: Text('Vitamin D 1000 IU'),
                    subtitle: Text('Once daily · 60 days'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Card(
              child: ListTile(
                title: Text('Instructions'),
                subtitle: Text('Take after meals with water', style: AppText.body),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: _confirmed,
                onChanged: (v) => setState(() => _confirmed = v ?? false),
                title: const Text('I confirm the details are correct'),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: AppDecor.bottomPadding,
            child: ElevatedButton.icon(
              onPressed: _confirmed ? () => Navigator.pushNamed(context, AppRoutes.savedRecord) : null,
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Sign & issue'),
            ),
          ),
        ),
      ),
    );
  }
}
