import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class ConnectionLostScreen extends StatelessWidget {
  /// `failed: false` = reconnecting (attempt 2 of 5).
  /// `failed: true`  = after 5 failed attempts (Try again / Reschedule / Contact support).
  const ConnectionLostScreen({super.key, this.failed = false});

  final bool failed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.darkBackground,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.yellowBg,
                        child: Icon(Icons.wifi_off, size: 30, color: AppColors.yellow),
                      ),
                      const SizedBox(height: 14),
                      const Text('Connection lost', style: AppText.h2),
                      const SizedBox(height: 6),
                      Text(
                        failed
                            ? "We couldn't reconnect after 5 attempts."
                            : 'Reconnecting… your visit is still active.',
                        textAlign: TextAlign.center,
                        style: AppText.caption,
                      ),
                      const SizedBox(height: 14),
                      if (!failed) ...[
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                            SizedBox(width: 8),
                            Text('Attempt 2 of 5', style: AppText.caption),
                          ],
                        ),
                        const SizedBox(height: 18),
                        OutlinedButton(
                          onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.audioCall),
                          child: const Text('Switch to audio only'),
                        ),
                      ] else ...[
                        ElevatedButton(
                          onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.connectionLost),
                          child: const Text('Try again'),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: () => Navigator.pushNamed(context, AppRoutes.bookVisit),
                          child: const Text('Reschedule'),
                        ),
                        TextButton(onPressed: () {}, child: const Text('Contact support')),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
