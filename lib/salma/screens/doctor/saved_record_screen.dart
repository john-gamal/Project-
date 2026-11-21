import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class SavedRecordScreen extends StatelessWidget {
  const SavedRecordScreen({super.key});

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
                  child: Icon(Icons.verified_outlined, size: 44, color: AppColors.green),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Saved to medical record', textAlign: TextAlign.center, style: AppText.h1),
              const SizedBox(height: 6),
              const Text("Nadeen's record was updated and she has been notified.", textAlign: TextAlign.center, style: AppText.caption),
              const SizedBox(height: 24),
              const Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.blueBg,
                        child: Icon(Icons.description_outlined, color: AppColors.blue),
                      ),
                      title: Text('Diagnosis & notes'),
                      subtitle: Text('Added to visit history'),
                      trailing: Icon(Icons.check, color: AppColors.green),
                    ),
                    Divider(),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.lavenderBg,
                        child: Icon(Icons.medication_outlined, color: AppColors.lavender),
                      ),
                      title: Text('Prescription Rx #2211'),
                      subtitle: Text('2 medicines'),
                      trailing: Icon(Icons.check, color: AppColors.green),
                    ),
                    Divider(),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.yellowBg,
                        child: Icon(Icons.event_repeat, color: AppColors.yellow),
                      ),
                      title: Text('Follow-up'),
                      subtitle: Text('Not scheduled yet'),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.followUp),
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Schedule follow-up'),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    // Simple success = Toast on Home.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Prescription issued and saved')),
                    );
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.doctorHome, ModalRoute.withName(AppRoutes.index));
                  },
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
