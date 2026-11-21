import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class VisitDetailsScreen extends StatelessWidget {
  /// Join becomes active 10 minutes before the visit.
  /// Use `VisitDetailsScreen(canJoin: false)` to see the disabled state.
  const VisitDetailsScreen({super.key, this.canJoin = true});

  final bool canJoin;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.background,
      child: Scaffold(
        appBar: AppBar(title: const Text('Visit details')),
        body: ListView(
          padding: AppDecor.pagePadding,
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Chip(
                avatar: const Icon(Icons.schedule, size: 16, color: AppColors.blue),
                label: Text('Upcoming · in 1h 20m', style: AppText.label.copyWith(color: AppColors.blue)),
                backgroundColor: AppColors.blueBg,
              ),
            ),
            const SizedBox(height: 12),
            const Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.avatarBg,
                  child: Text('CW', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.navy)),
                ),
                title: Text('Dr. Cecily Welsh'),
                subtitle: Text('Endocrinologist'),
              ),
            ),
            const SizedBox(height: 12),
            const Card(
              child: Column(
                children: [
                  ListTile(title: Text('Date'), trailing: Text('Tue 27 Oct · 10:30', style: AppText.label)),
                  Divider(),
                  ListTile(title: Text('Type'), trailing: Text('Video call', style: AppText.label)),
                  Divider(),
                  ListTile(title: Text('Reason'), trailing: Text('Blood sugar follow-up', style: AppText.label)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.lavenderBg,
                  child: Icon(Icons.folder_outlined, color: AppColors.lavender),
                ),
                title: const Text('Shared documents'),
                subtitle: const Text('2 files · Chest X-ray, Lipid panel'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: AppDecor.bottomPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: canJoin ? () => Navigator.pushNamed(context, AppRoutes.secureRoom) : null,
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.play_arrow),
                  label: Text(canJoin ? 'Join visit' : 'Join · opens at 10:20'),
                ),
                const SizedBox(height: 10),
                OutlinedButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.bookVisit), child: const Text('Reschedule')),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: AppColors.red),
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Cancel this visit?', style: AppText.h2),
                      content: const Text('You can book another time later.', style: AppText.body),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Keep visit')),
                        TextButton(
                          style: TextButton.styleFrom(foregroundColor: AppColors.red),
                          onPressed: () {
                            Navigator.pop(ctx);
                            Navigator.popUntil(context, ModalRoute.withName(AppRoutes.index));
                          },
                          child: const Text('Cancel visit'),
                        ),
                      ],
                    ),
                  ),
                  child: const Text('Cancel visit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
