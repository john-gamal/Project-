import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class ChooseDoctorScreen extends StatefulWidget {
  const ChooseDoctorScreen({super.key});

  @override
  State<ChooseDoctorScreen> createState() => _ChooseDoctorScreenState();
}

class _ChooseDoctorScreenState extends State<ChooseDoctorScreen> {
  static const _filters = ['All', 'Endocrinology', 'Cardiology', 'GP'];
  static const _doctors = [
    (initials: 'CW', name: 'Dr. Cecily Welsh', info: 'Endocrinologist · 4.9 rating', field: 'Endocrinology', price: '\$45', slots: ['9:00', '10:00', '10:30']),
    (initials: 'TW', name: 'Dr. Tony Ware', info: 'Cardiologist · 4.8 rating', field: 'Cardiology', price: '\$52', slots: ['12:00', '1:30', '3:00']),
    (initials: 'RJ', name: 'Dr. Richie Jimenez', info: 'Immunologist · 4.7 rating', field: 'GP', price: '\$40', slots: ['2:00', '4:30']),
  ];

  String _filter = 'All';

  @override
  Widget build(BuildContext context) {
    final visible = _filter == 'All' ? _doctors : _doctors.where((d) => d.field == _filter).toList();

    return Container(
      decoration: AppDecor.background,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Find a doctor'),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.tune))],
        ),
        body: ListView(
          padding: AppDecor.pagePadding,
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'Search doctor or speciality',
                prefixIcon: Icon(Icons.search, color: AppColors.placeholder),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final f in _filters)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8),
                      child: ChoiceChip(
                        label: Text(
                          f,
                          style: AppText.label.copyWith(
                            color: _filter == f ? AppColors.white : AppColors.textPrimary,
                          ),
                        ),
                        selected: _filter == f,
                        onSelected: (_) => setState(() => _filter = f),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (visible.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: Text('No doctors found', style: AppText.caption)),
              ),
            for (final d in visible)
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 12),
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () => Navigator.pushNamed(context, AppRoutes.doctorProfile),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.avatarBg,
                          child: Text(d.initials, style: AppText.label.copyWith(color: AppColors.navy)),
                        ),
                        title: Text(d.name),
                        subtitle: Text(d.info),
                        trailing: Chip(
                          label: Text(d.price, style: AppText.label.copyWith(color: AppColors.white)),
                          backgroundColor: AppColors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 14),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final s in d.slots)
                                ActionChip(
                                  label: Text(s),
                                  onPressed: () => Navigator.pushNamed(context, AppRoutes.bookVisit),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: AppDecor.bottomPadding,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(34),
              child: const NavigationBar(
                selectedIndex: 2,
                destinations: [
                  NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
                  NavigationDestination(icon: Icon(Icons.folder_outlined), selectedIcon: Icon(Icons.folder), label: 'Records'),
                  NavigationDestination(icon: Icon(Icons.calendar_today_outlined), selectedIcon: Icon(Icons.calendar_today), label: 'Visits'),
                  NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome), label: 'Assistant'),
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
