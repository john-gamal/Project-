import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../theme.dart';

class VideoCallScreen extends StatefulWidget {
  /// Used for both sides: patient sees the doctor, doctor sees the patient.
  const VideoCallScreen({
    super.key,
    this.remoteName = 'Dr. Cecily Welsh',
    this.remoteInitials = 'CW',
    this.localInitials = 'NA',
    this.isDoctor = false,
  });

  final String remoteName;
  final String remoteInitials;
  final String localInitials;
  final bool isDoctor;

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool _micOn = true;
  bool _camOn = true;

  static const _controlStyleOff = AppColors.onDarkSoft;

  Future<void> _confirmEnd() {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('End the call?', style: AppText.h2),
        content: const Text('This ends the visit for everyone.', style: AppText.body),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Stay')),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppColors.red),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushReplacementNamed(
                context,
                widget.isDoctor ? AppRoutes.visitSummary : AppRoutes.visitEnded,
              );
            },
            child: const Text('End call'),
          ),
        ],
      ),
    );
  }

  void _openMore() {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(leading: const Icon(Icons.chat_bubble_outline), title: const Text('Chat'), onTap: () => Navigator.pop(ctx)),
            ListTile(leading: const Icon(Icons.attach_file), title: const Text('Share document'), onTap: () => Navigator.pop(ctx)),
            ListTile(
              leading: const Icon(Icons.call_outlined),
              title: const Text('Switch to audio only'),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.pushReplacementNamed(context, AppRoutes.audioCall);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.darkBackground,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: AppColors.avatarBg,
                  child: Text(widget.remoteInitials, style: const TextStyle(fontSize: 44, fontWeight: FontWeight.w700, color: AppColors.navy)),
                ),
              ),
              PositionedDirectional(
                top: 12,
                start: 16,
                child: Chip(
                  avatar: const Icon(Icons.lock_outline, size: 16, color: AppColors.white),
                  label: Text('${widget.remoteName} · 12:04', style: AppText.onDark),
                  backgroundColor: AppColors.onDarkSoft,
                ),
              ),
              PositionedDirectional(
                top: 60,
                start: 16,
                child: Chip(
                  avatar: const Icon(Icons.signal_cellular_alt, size: 16, color: AppColors.green),
                  label: const Text('Good connection', style: AppText.onDark),
                  backgroundColor: AppColors.onDarkSoft,
                ),
              ),
              PositionedDirectional(
                top: 12,
                end: 16,
                child: Container(
                  width: 96,
                  height: 128,
                  decoration: BoxDecoration(color: AppColors.dark, borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child: _camOn
                        ? CircleAvatar(
                            backgroundColor: AppColors.avatarBg,
                            child: Text(widget.localInitials, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.navy)),
                          )
                        : const Icon(Icons.videocam_off_outlined, color: AppColors.placeholder),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton.filled(
                        onPressed: () => setState(() => _micOn = !_micOn),
                        style: IconButton.styleFrom(
                          backgroundColor: _micOn ? _controlStyleOff : AppColors.white,
                          foregroundColor: _micOn ? AppColors.white : AppColors.textPrimary,
                          fixedSize: const Size(56, 56),
                        ),
                        icon: Icon(_micOn ? Icons.mic_none : Icons.mic_off_outlined),
                      ),
                      const SizedBox(width: 14),
                      IconButton.filled(
                        onPressed: () => setState(() => _camOn = !_camOn),
                        style: IconButton.styleFrom(
                          backgroundColor: _camOn ? _controlStyleOff : AppColors.white,
                          foregroundColor: _camOn ? AppColors.white : AppColors.textPrimary,
                          fixedSize: const Size(56, 56),
                        ),
                        icon: Icon(_camOn ? Icons.videocam_outlined : Icons.videocam_off_outlined),
                      ),
                      const SizedBox(width: 14),
                      IconButton.filled(
                        onPressed: _confirmEnd,
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.red,
                          foregroundColor: AppColors.white,
                          fixedSize: const Size(64, 64),
                        ),
                        icon: const Icon(Icons.call_end),
                      ),
                      const SizedBox(width: 14),
                      IconButton.filled(
                        onPressed: _openMore,
                        style: IconButton.styleFrom(
                          backgroundColor: _controlStyleOff,
                          foregroundColor: AppColors.white,
                          fixedSize: const Size(56, 56),
                        ),
                        icon: const Icon(Icons.more_horiz),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
