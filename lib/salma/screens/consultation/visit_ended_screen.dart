import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class VisitEndedScreen extends StatefulWidget {
  const VisitEndedScreen({super.key});

  @override
  State<VisitEndedScreen> createState() => _VisitEndedScreenState();
}

class _VisitEndedScreenState extends State<VisitEndedScreen> {
  int _rating = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.background,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: AppDecor.pagePadding,
            children: [
              const SizedBox(height: 32),
              const Center(
                child: CircleAvatar(
                  radius: 44,
                  backgroundColor: AppColors.greenBg,
                  child: Icon(Icons.check, size: 44, color: AppColors.green),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Visit ended', textAlign: TextAlign.center, style: AppText.h1),
              const SizedBox(height: 6),
              const Text('18:42 with Dr. Cecily Welsh', textAlign: TextAlign.center, style: AppText.caption),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: AppDecor.cardPadding,
                  child: Column(
                    children: [
                      const Text('How was your visit?', style: AppText.label),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var i = 1; i <= 5; i++)
                            IconButton(
                              onPressed: () => setState(() => _rating = i),
                              icon: Icon(
                                i <= _rating ? Icons.star : Icons.star_border,
                                size: 32,
                                color: i <= _rating ? AppColors.yellow : AppColors.toggleOff,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const TextField(
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: 'Add a comment (optional)',
                          fillColor: AppColors.soft,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: AppDecor.bottomPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.visitReport),
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('View visit report'),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () => Navigator.popUntil(context, ModalRoute.withName(AppRoutes.index)),
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
