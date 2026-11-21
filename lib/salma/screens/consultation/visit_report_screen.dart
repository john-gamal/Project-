import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class VisitReportScreen extends StatelessWidget {
  const VisitReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.background,
      child: Scaffold(
        appBar: AppBar(title: const Text('Visit report')),
        body: ListView(
          padding: AppDecor.pagePadding,
          children: [
            const Card(
              child: Padding(
                padding: AppDecor.cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Diagnosis', style: AppText.caption),
                    SizedBox(height: 4),
                    Text('Type 2 diabetes, well controlled', style: AppText.h2),
                    SizedBox(height: 6),
                    Text('Continue current plan. Re-check HbA1c in 3 months.', style: AppText.body),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.lavenderBg,
                      child: Icon(Icons.medication_outlined, color: AppColors.lavender),
                    ),
                    title: const Text('Prescription Rx #2211'),
                    subtitle: const Text('2 medicines · Metformin, Vitamin D'),
                    trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.download_outlined)),
                  ),
                  const Divider(),
                  const ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.yellowBg,
                      child: Icon(Icons.event_repeat, color: AppColors.yellow),
                    ),
                    title: Text('Follow-up'),
                    subtitle: Text('In 2 weeks · Wed 11 Nov, 10:30'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  const Divider(),
                  const ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.blueBg,
                      child: Icon(Icons.folder_outlined, color: AppColors.blue),
                    ),
                    title: Text('Documents from this visit'),
                    subtitle: Text('1 file'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: AppDecor.bottomPadding,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.bookVisit),
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Book follow-up'),
            ),
          ),
        ),
      ),
    );
  }
}
