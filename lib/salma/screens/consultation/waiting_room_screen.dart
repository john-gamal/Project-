import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen({super.key});

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  bool _micOn = true;
  bool _camOn = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.background,
      child: Scaffold(
        appBar: AppBar(title: const Text('Waiting room')),
        body: ListView(
          padding: AppDecor.pagePadding,
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: AppColors.dark,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_camOn ? Icons.person_outline : Icons.videocam_off_outlined, size: 56, color: AppColors.placeholder),
                    const SizedBox(height: 8),
                    Text(_camOn ? 'Camera preview' : 'Camera off', style: AppText.onDarkSoft),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filled(
                  onPressed: () => setState(() => _micOn = !_micOn),
                  style: IconButton.styleFrom(
                    backgroundColor: _micOn ? AppColors.white : AppColors.redBg,
                    foregroundColor: _micOn ? AppColors.textPrimary : AppColors.red,
                  ),
                  icon: Icon(_micOn ? Icons.mic_none : Icons.mic_off_outlined),
                ),
                const SizedBox(width: 12),
                IconButton.filled(
                  onPressed: () => setState(() => _camOn = !_camOn),
                  style: IconButton.styleFrom(
                    backgroundColor: _camOn ? AppColors.white : AppColors.redBg,
                    foregroundColor: _camOn ? AppColors.textPrimary : AppColors.red,
                  ),
                  icon: Icon(_camOn ? Icons.videocam_outlined : Icons.videocam_off_outlined),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Card(
              child: Padding(
                padding: AppDecor.cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your visit starts in 04:32', style: AppText.h2),
                    SizedBox(height: 4),
                    Text('Dr. Cecily Welsh will admit you shortly. You are 1st in the queue.', style: AppText.caption),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Card(
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.greenBg,
                      child: Icon(Icons.check, color: AppColors.green),
                    ),
                    title: Text('Camera & microphone ready'),
                  ),
                  Divider(),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.greenBg,
                      child: Icon(Icons.check, color: AppColors.green),
                    ),
                    title: Text('Connection is stable'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Status only (not a button). Tap = demo shortcut for "doctor admitted you".
            Card(
              child: ListTile(
                onTap: () => Navigator.pushNamed(context, AppRoutes.videoCall),
                leading: const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2.5)),
                title: const Text('Waiting for doctor'),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: AppColors.red),
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName(AppRoutes.index)),
              child: const Text('Leave queue'),
            ),
          ],
        ),
      ),
    );
  }
}
