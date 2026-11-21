import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class FollowUpScreen extends StatefulWidget {
  const FollowUpScreen({super.key});

  @override
  State<FollowUpScreen> createState() => _FollowUpScreenState();
}

class _FollowUpScreenState extends State<FollowUpScreen> {
  static const _ranges = ['In 1 week', 'In 2 weeks', 'In 1 month', 'Custom'];
  static const _days = [
    (label: 'Mon', n: 9),
    (label: 'Tue', n: 10),
    (label: 'Wed', n: 11),
    (label: 'Thu', n: 12),
    (label: 'Fri', n: 13),
  ];
  static const _times = ['9:00', '10:30', '12:00', '1:30'];

  String _range = 'In 2 weeks';
  int _day = 11;
  String _time = '10:30';
  String _mode = 'video';
  bool _remind = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.background,
      child: Scaffold(
        appBar: AppBar(title: const Text('Follow-up')),
        body: ListView(
          padding: AppDecor.pagePadding,
          children: [
            const Text('When should we see Nadeen again?', style: AppText.h2),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final r in _ranges)
                  ChoiceChip(
                    backgroundColor: AppColors.white,
                    label: Text(r, style: AppText.label.copyWith(color: _range == r ? AppColors.white : AppColors.textPrimary)),
                    selected: _range == r,
                    onSelected: (_) => setState(() => _range = r),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('November 2026', style: AppText.section),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final d in _days)
                  ChoiceChip(
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    selected: _day == d.n,
                    onSelected: (_) => setState(() => _day = d.n),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                      child: Column(
                        children: [
                          Text(d.label, style: AppText.caption.copyWith(color: _day == d.n ? AppColors.placeholder : AppColors.textSecondary)),
                          Text('${d.n}', style: AppText.h2.copyWith(color: _day == d.n ? AppColors.white : AppColors.textPrimary)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Time', style: AppText.section),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final t in _times)
                  ChoiceChip(
                    backgroundColor: AppColors.white,
                    label: Text(t, style: AppText.label.copyWith(color: _time == t ? AppColors.white : AppColors.textPrimary)),
                    selected: _time == t,
                    onSelected: (_) => setState(() => _time = t),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            SegmentedButton<String>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(value: 'video', label: Text('Video call')),
                ButtonSegment(value: 'clinic', label: Text('In clinic')),
              ],
              selected: {_mode},
              onSelectionChanged: (s) => setState(() => _mode = s.first),
            ),
            const SizedBox(height: 16),
            Card(
              child: SwitchListTile(
                secondary: const Icon(Icons.notifications_none),
                title: const Text('Remind patient'),
                subtitle: const Text('24 hours before'),
                value: _remind,
                onChanged: (v) => setState(() => _remind = v),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: AppDecor.bottomPadding,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.followUpConfirmed),
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Schedule follow-up'),
            ),
          ),
        ),
      ),
    );
  }
}
