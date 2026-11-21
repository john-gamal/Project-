import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class NewPrescriptionScreen extends StatefulWidget {
  const NewPrescriptionScreen({super.key});

  @override
  State<NewPrescriptionScreen> createState() => _NewPrescriptionScreenState();
}

class _NewPrescriptionScreenState extends State<NewPrescriptionScreen> {
  bool _alternative = false; // user picked "Choose alternative"
  bool _overridden = false; // user overrode with a reason
  String _dose = '1 tab';
  String _frequency = 'Once daily';
  String _duration = '60 d';

  bool get _conflictOpen => !_alternative && !_overridden;

  Future<void> _askOverrideReason() {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Override allergy warning', style: AppText.h2),
        content: const TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Reason (required)',
            fillColor: AppColors.soft,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppColors.red),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => _overridden = true);
            },
            child: const Text('Override'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.background,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('New prescription'),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: Chip(
                avatar: const Icon(Icons.warning_amber_rounded, size: 16, color: AppColors.red),
                label: Text('Penicillin', style: AppText.caption.copyWith(color: AppColors.redText)),
                backgroundColor: AppColors.redBg,
              ),
            ),
          ],
        ),
        body: ListView(
          padding: AppDecor.pagePadding,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: _conflictOpen ? AppColors.red : Colors.transparent, width: 1.5),
              ),
              child: Padding(
                padding: AppDecor.cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const CircleAvatar(
                        backgroundColor: AppColors.lavenderBg,
                        child: Icon(Icons.medication_outlined, color: AppColors.lavender),
                      ),
                      title: Text(_alternative ? 'Azithromycin 500 mg' : 'Amoxicillin 500 mg'),
                      subtitle: Text(_alternative ? 'Macrolide class' : 'Penicillin class'),
                    ),
                    if (_conflictOpen) ...[
                      Container(
                        padding: AppDecor.cardPadding,
                        decoration: BoxDecoration(color: AppColors.redBg, borderRadius: BorderRadius.circular(14)),
                        child: const Text(
                          'Allergy conflict — Nadeen has a recorded Penicillin allergy (moderate).',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.redText),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(46)),
                              onPressed: () => setState(() => _alternative = true),
                              child: const Text('Choose alternative'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(46),
                                backgroundColor: AppColors.red,
                              ),
                              onPressed: _askOverrideReason,
                              child: const Text('Override'),
                            ),
                          ),
                        ],
                      ),
                    ] else if (_overridden)
                      const Chip(
                        avatar: Icon(Icons.edit_note, size: 16, color: AppColors.yellowText),
                        label: Text('Overridden — reason recorded', style: TextStyle(color: AppColors.yellowText)),
                        backgroundColor: AppColors.yellowBg,
                      )
                    else
                      const Chip(
                        avatar: Icon(Icons.check, size: 16, color: AppColors.greenText),
                        label: Text('No conflicts found', style: TextStyle(color: AppColors.greenText)),
                        backgroundColor: AppColors.greenBg,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: AppDecor.cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: AppColors.lavenderBg,
                        child: Icon(Icons.medication_outlined, color: AppColors.lavender),
                      ),
                      title: Text('Vitamin D 1000 IU'),
                      subtitle: Text('No conflicts found ✓'),
                    ),
                    const Text('Dose', style: AppText.section),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final v in const ['1 tab', '2 tabs'])
                          ChoiceChip(
                            label: Text(v, style: AppText.label.copyWith(color: _dose == v ? AppColors.white : AppColors.textPrimary)),
                            selected: _dose == v,
                            onSelected: (_) => setState(() => _dose = v),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('Frequency', style: AppText.section),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final v in const ['Once daily', 'Twice daily'])
                          ChoiceChip(
                            label: Text(v, style: AppText.label.copyWith(color: _frequency == v ? AppColors.white : AppColors.textPrimary)),
                            selected: _frequency == v,
                            onSelected: (_) => setState(() => _frequency = v),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('Duration', style: AppText.section),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final v in const ['30 d', '60 d', '90 d'])
                          ChoiceChip(
                            label: Text(v, style: AppText.label.copyWith(color: _duration == v ? AppColors.white : AppColors.textPrimary)),
                            selected: _duration == v,
                            onSelected: (_) => setState(() => _duration = v),
                          ),
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
              // Cannot continue while the allergy conflict is unresolved.
              onPressed: _conflictOpen ? null : () => Navigator.pushNamed(context, AppRoutes.reviewSign),
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Review & sign'),
            ),
          ),
        ),
      ),
    );
  }
}
