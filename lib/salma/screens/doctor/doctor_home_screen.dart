import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.background,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: AppDecor.pagePadding,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: AppColors.avatarBg,
                  child: Text('SH', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.navy)),
                ),
                title: const Text('Dr. Sara Hassan'),
                subtitle: const Text('Endocrinologist'),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Badge(smallSize: 9, child: Icon(Icons.notifications_none)),
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Today', style: AppText.h2),
                  Text('Oct 26', style: AppText.caption),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: AppDecor.cardPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.calendar_today_outlined, color: AppColors.blue),
                            SizedBox(height: 8),
                            Text('Visits', style: AppText.caption),
                            Text('8', style: AppText.h1),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: AppDecor.cardPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.schedule, color: AppColors.yellow),
                            SizedBox(height: 8),
                            Text('Waiting', style: AppText.caption),
                            Text('2', style: AppText.h1),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: AppDecor.cardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Next consultation', style: AppText.caption),
                      const ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: AppColors.lavenderBg,
                          child: Text('NA', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.lavender)),
                        ),
                        title: Text('Nadeen Ayman'),
                        subtitle: Text('Video call · 10:30 AM'),
                      ),
                      const SizedBox(height: 4),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.patientFile),
                        iconAlignment: IconAlignment.end,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('View patient file'),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.videoCallDoctor),
                        child: const Text('Start call'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Schedule', style: AppText.h2),
                  Text('View all', style: AppText.caption),
                ],
              ),
              const SizedBox(height: 10),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: AppColors.blueBg,
                        child: Icon(Icons.videocam_outlined, color: AppColors.blue),
                      ),
                      title: const Text('Omar Said'),
                      subtitle: const Text('11:30 AM · Follow-up'),
                      trailing: Chip(
                        avatar: const Icon(Icons.schedule, size: 14, color: AppColors.yellowText),
                        label: Text('Waiting', style: AppText.caption.copyWith(color: AppColors.yellowText)),
                        backgroundColor: AppColors.yellowBg,
                      ),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.greenBg,
                        child: Icon(Icons.videocam_outlined, color: AppColors.green),
                      ),
                      title: Text('Layla Fathy'),
                      subtitle: Text('1:00 PM · New visit'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: AppDecor.bottomPadding,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(34),
              child: const NavigationBar(
                selectedIndex: 0,
                destinations: [
                  NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
                  NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: 'Patients'),
                  NavigationDestination(icon: Icon(Icons.calendar_today_outlined), selectedIcon: Icon(Icons.calendar_today), label: 'Schedule'),
                  NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
