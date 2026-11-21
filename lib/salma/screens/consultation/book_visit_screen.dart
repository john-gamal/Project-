import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class BookVisitScreen extends StatefulWidget {
  const BookVisitScreen({super.key});

  @override
  State<BookVisitScreen> createState() => _BookVisitScreenState();
}

class _BookVisitScreenState extends State<BookVisitScreen> {
  static const _days = [
    (label: 'Mon', n: 26),
    (label: 'Tue', n: 27),
    (label: 'Wed', n: 28),
    (label: 'Thu', n: 29),
    (label: 'Fri', n: 30),
  ];
  static const _times = ['9:00', '10:00', '10:30', '12:00', '1:30', '3:00'];

  String _type = 'video';
  int _day = 27;
  String _time = '10:30';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.background,
      child: Scaffold(
        appBar: AppBar(title: const Text('Book visit')),
        body: ListView(
          padding: AppDecor.pagePadding,
          children: [
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.avatarBg,
                  child: Text('CW', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.navy)),
                ),
                title: const Text('Dr. Cecily Welsh'),
                subtitle: const Text('Endocrinologist · \$45'),
                trailing: TextButton(onPressed: () => Navigator.pop(context), child: const Text('Change')),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Visit type', style: AppText.section),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(value: 'video', icon: Icon(Icons.videocam_outlined), label: Text('Video call')),
                ButtonSegment(value: 'audio', icon: Icon(Icons.call_outlined), label: Text('Audio call')),
              ],
              selected: {_type},
              onSelectionChanged: (s) => setState(() => _type = s.first),
            ),
            const SizedBox(height: 20),
            const Text('October 2026', style: AppText.section),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final d in _days)
                  ChoiceChip(
                    selected: _day == d.n,
                    onSelected: (_) => setState(() => _day = d.n),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    backgroundColor: AppColors.white,
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
            const Text('Available times', style: AppText.section),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final t in _times)
                  ChoiceChip(
                    selected: _time == t,
                    onSelected: (_) => setState(() => _time = t),
                    backgroundColor: AppColors.white,
                    label: Text(t, style: AppText.label.copyWith(color: _time == t ? AppColors.white : AppColors.textPrimary)),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Reason for visit', style: AppText.section),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Follow-up on blood sugar levels',
                prefixIcon: Icon(Icons.edit_outlined, color: AppColors.placeholder),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: AppDecor.cardPadding,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Date & time', style: AppText.caption),
                        Text('Tue $_day Oct · $_time', style: AppText.label),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Consultation fee', style: AppText.caption),
                        const Text('\$45', style: AppText.h2),
                      ],
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
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.bookingConfirmed),
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Confirm booking'),
            ),
          ),
        ),
      ),
    );
  }
}
