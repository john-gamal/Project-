import 'package:flutter/material.dart';

class VerifiedScreen extends StatelessWidget {
  final String name;
  final String specialty;
  final String license;

  const VerifiedScreen({
    super.key,
    this.name = 'Dr. Sara Hassan', // TODO: خديهم من الـ API
    this.specialty = 'Endocrinologist',
    this.license = 'EG-482910',
  });

  @override
  Widget build(BuildContext context) {
    // الحروف الأولى من الاسم (من غير Dr.)
    final words = name.replaceFirst('Dr.', '').trim().split(' ');
    final initials = words.take(2).map((w) => w.isEmpty ? '' : w[0].toUpperCase()).join();

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
                        Center(
                          child: Container(
                            width: 76,
                            height: 76,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD9F2E6),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.verified_outlined,
                              size: 34,
                              color: Color(0xFF16A34A),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          "You're verified",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0B0B14),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Your doctor account is now active. Patients can find and book you.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10.5, color: Color(0xFF8A8A99), height: 1.5),
                        ),
                        const SizedBox(height: 16),

                        // Doctor card
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFC9D6FF),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      initials,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF1B2554),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '$specialty · License $license',
                                          style: const TextStyle(fontSize: 9, color: Color(0xFF8A8A99)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD9F2E6),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'Verified',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF16A34A),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDDE8FF),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'Approved today',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF2F5BD3),
                                      ),
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

                // Go to dashboard (الطريق الوحيد)
                InkWell(
                  onTap: () {
                    // TODO: روحي للـ Doctor Dashboard
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.only(left: 22, right: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF07070F),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Go to dashboard',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_forward, size: 15, color: Color(0xFF0B0B14)),
                        ),
                      ],
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