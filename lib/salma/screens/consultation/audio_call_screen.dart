import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class AudioCallScreen extends StatefulWidget {
  const AudioCallScreen({super.key});

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  bool _muted = true;
  bool _speaker = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.darkBackground,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),
              const CircleAvatar(
                radius: 64,
                backgroundColor: AppColors.avatarBg,
                child: Text('CW', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, color: AppColors.navy)),
              ),
              const SizedBox(height: 20),
              Text('Dr. Cecily Welsh', style: AppText.h1.copyWith(color: AppColors.white)),
              const SizedBox(height: 6),
              const Text('Audio call · 08:21', style: AppText.onDarkSoft),
              const SizedBox(height: 4),
              if (_muted) const Text('Microphone muted', style: AppText.onDarkSoft),
              const Spacer(flex: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filled(
                    onPressed: () => setState(() => _muted = !_muted),
                    style: IconButton.styleFrom(
                      backgroundColor: _muted ? AppColors.white : AppColors.onDarkSoft,
                      foregroundColor: _muted ? AppColors.textPrimary : AppColors.white,
                      fixedSize: const Size(56, 56),
                    ),
                    icon: Icon(_muted ? Icons.mic_off_outlined : Icons.mic_none),
                  ),
                  const SizedBox(width: 14),
                  IconButton.filled(
                    onPressed: () => setState(() => _speaker = !_speaker),
                    style: IconButton.styleFrom(
                      backgroundColor: _speaker ? AppColors.white : AppColors.onDarkSoft,
                      foregroundColor: _speaker ? AppColors.textPrimary : AppColors.white,
                      fixedSize: const Size(56, 56),
                    ),
                    icon: const Icon(Icons.volume_up_outlined),
                  ),
                  const SizedBox(width: 14),
                  IconButton.filled(
                    onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.videoCall),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.onDarkSoft,
                      foregroundColor: AppColors.white,
                      fixedSize: const Size(56, 56),
                    ),
                    icon: const Icon(Icons.videocam_outlined),
                  ),
                  const SizedBox(width: 14),
                  IconButton.filled(
                    onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.visitEnded),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.red,
                      foregroundColor: AppColors.white,
                      fixedSize: const Size(64, 64),
                    ),
                    icon: const Icon(Icons.call_end),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
