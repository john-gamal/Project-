import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.background,
      child: Scaffold(
        appBar: AppBar(title: const Text('Doctor')),
        body: ListView(
          padding: AppDecor.pagePadding,
          children: [
            const SizedBox(height: 8),
            const Center(
              child: CircleAvatar(
                radius: 44,
                backgroundColor: AppColors.avatarBg,
                child: Text('CW', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.navy)),
              ),
            ),
            const SizedBox(height: 14),
            const Text('Dr. Cecily Welsh', textAlign: TextAlign.center, style: AppText.h1),
            const SizedBox(height: 4),
            const Text('Endocrinologist · 12 years', textAlign: TextAlign.center, style: AppText.caption),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  avatar: const Icon(Icons.star, size: 16, color: AppColors.yellow),
                  label: Text('4.9', style: AppText.label.copyWith(color: AppColors.yellowText)),
                  backgroundColor: AppColors.yellowBg,
                ),
                const Chip(label: Text('Arabic · English'), backgroundColor: AppColors.white),
                Chip(
                  label: Text('\$45', style: AppText.label.copyWith(color: AppColors.blue)),
                  backgroundColor: AppColors.blueBg,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Card(
              child: Padding(
                padding: AppDecor.cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('About', style: AppText.label),
                    SizedBox(height: 6),
                    Text(
                      'Diabetes, thyroid and hormonal disorders. Follow-ups and remote monitoring.',
                      style: AppText.body,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Next available', style: AppText.section),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final s in const ['Today 10:30', 'Tue 12:00', 'Wed 9:00'])
                  ActionChip(
                    label: Text(s),
                    backgroundColor: AppColors.white,
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.bookVisit),
                  ),
              ],
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
              label: const Text('Book visit'),
            ),
          ),
        ),
      ),
    );
  }
}
