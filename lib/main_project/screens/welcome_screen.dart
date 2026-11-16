import 'package:project/main_project/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Logo
                const Row(
                  children: [
                    Icon(Icons.favorite, size: 16, color: Color(0xFF0B0B14)),
                    SizedBox(width: 6),
                    Text(
                      'MediCore',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 56),

                // Title + subtitle
                const Text(
                  'Smart healthcare\nat your fingertips',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                    color: Color(0xFF0B0B14),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your records, verified doctors and an allergy assistant —\nin one secure place.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF8A8A99), height: 1.4),
                ),
                const SizedBox(height: 20),

                // Checklist
                ...[
                  'All your medical records in one place',
                  'Video visits with verified doctors',
                  'Allergy assistant, always available',
                ].map(
                  (t) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '✓ $t',
                      style: const TextStyle(fontSize: 11, color: Color(0xFF33334A)),
                    ),
                  ),
                ),
                const SizedBox(height: 22),

                const Text(
                  'Continue as',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),

                // Patient card
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SignInScreen(isPatient: true),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDDE6FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.sentiment_satisfied_alt,
                            size: 18,
                            color: Color(0xFF2F5BD3),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "I'm a Patient",
                                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Records, visits & AI assistant',
                                style: TextStyle(fontSize: 10, color: Color(0xFF8A8A99)),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, size: 16, color: Color(0xFF8A8A99)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Doctor card
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SignInScreen(isPatient: false),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6DAFB),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.add, size: 18, color: Color(0xFF7C3AED)),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "I'm a Doctor",
                                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Patients, consultations & prescriptions',
                                style: TextStyle(fontSize: 10, color: Color(0xFF8A8A99)),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, size: 16, color: Color(0xFF8A8A99)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // Already have an account
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SignInScreen(isPatient: true),
                      ),
                    ),
                    child: const Text.rich(
                      TextSpan(
                        style: TextStyle(fontSize: 12, color: Color(0xFF55556A)),
                        children: [
                          TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Sign in',
                            style: TextStyle(
                              color: Color(0xFF2F5BD3),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Emergency info
                const Center(
                  child: Text(
                    '⚠ Emergency info — no login needed',
                    style: TextStyle(fontSize: 11, color: Color(0xFFD62839)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}