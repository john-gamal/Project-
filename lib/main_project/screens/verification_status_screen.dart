import 'package:flutter/material.dart';
import 'doctor_registration_screen.dart';
import 'welcome_screen.dart';

// حالتين: قيد المراجعة (pending) أو مرفوض (rejected) مع السبب
class VerificationStatusScreen extends StatelessWidget {
  final bool rejected;
  final String rejectionReason;

  const VerificationStatusScreen({
    super.key,
    this.rejected = false, // TODO: خديها من الـ API
    this.rejectionReason =
        'The license image is unclear. Please upload a clear photo or PDF.',
  });

  @override
  Widget build(BuildContext context) {
    const grey = Color(0xFF8A8A99);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEEF0F7), Color(0xFFE6DDF8), Color(0xFFDCCFF7)],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 18),
                const Text(
                  'Verification',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Status icon
                        Center(
                          child: Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                              color: rejected ? const Color(0xFFFDE2E4) : const Color(0xFFFFF1D6),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              rejected ? Icons.error_outline : Icons.access_time,
                              size: 32,
                              color: rejected ? const Color(0xFFD62839) : const Color(0xFFF59E0B),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          rejected ? 'Verification needs attention' : 'Verification in progress',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0B0B14),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          rejected
                              ? "We couldn't approve your documents. Please fix the issue below and submit them again."
                              : 'We are reviewing your license and credentials. You will be notified once your account is active.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 10.5, color: grey, height: 1.5),
                        ),
                        const SizedBox(height: 16),

                        // Rejection reason
                        if (rejected) ...[
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDECEE),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFFF5B5BB)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Reason',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFD62839),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  rejectionReason,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF33334A),
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],

                        // Timeline card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              // 1) Application submitted
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFD9F2E6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.check, size: 15, color: Color(0xFF16A34A)),
                                  ),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Application submitted',
                                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          'Today, 10:42 AM',
                                          style: TextStyle(fontSize: 9, color: grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // 2) Documents review
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: rejected ? const Color(0xFFFDE2E4) : const Color(0xFFFFF1D6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      rejected ? Icons.close : Icons.access_time,
                                      size: 15,
                                      color: rejected ? const Color(0xFFD62839) : const Color(0xFFF59E0B),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          rejected ? 'Documents rejected' : 'Documents under review',
                                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          rejected ? 'Please upload them again' : 'Usually 24 to 48 hours',
                                          style: const TextStyle(fontSize: 9, color: grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: rejected ? const Color(0xFFFDE2E4) : const Color(0xFFFFF1D6),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      rejected ? 'Rejected' : 'Pending',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w700,
                                        color: rejected ? const Color(0xFFD62839) : const Color(0xFFD97706),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // 3) Account activation
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFEFEFF5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.shield_outlined, size: 15, color: grey),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Account activation',
                                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          rejected ? 'On hold' : 'After approval',
                                          style: const TextStyle(fontSize: 9, color: grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),

                // Edit documents
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DoctorRegistrationScreen(startStep: 3),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: rejected ? const Color(0xFF07070F) : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Edit documents',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: rejected ? Colors.white : const Color(0xFF0B0B14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Contact support
                InkWell(
                  onTap: () {
                   
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'Contact support',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Log out
                GestureDetector(
                  onTap: () {
                   
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFFD62839),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}