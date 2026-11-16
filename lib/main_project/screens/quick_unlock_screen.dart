import 'package:flutter/material.dart';
import 'sign_in_screen.dart';

// شاشة قفل: من غير زرار رجوع
class QuickUnlockScreen extends StatefulWidget {
  const QuickUnlockScreen({super.key});

  @override
  State<QuickUnlockScreen> createState() => _QuickUnlockScreenState();
}

class _QuickUnlockScreenState extends State<QuickUnlockScreen> {
  bool useFace = true; // Face ID / Fingerprint
  bool failed = false; // حالة الفشل (Try again)

  void authenticate() {
    // TODO: استخدمي package local_auth هنا وحطي النتيجة في success
    const success = false;

    setState(() => failed = !success);
    if (success) {
      // TODO: روحي للـ Home
    }
  }

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
            colors: [Color(0xFFF6F6FD), Color(0xFFE6DDF8), Color(0xFFDCCFF7)],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 22),
                const Text(
                  'Quick unlock',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),

                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Container(
                              width: 112,
                              height: 112,
                              decoration: const BoxDecoration(
                                color: Color(0xFFDDE6FF),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                useFace ? Icons.face_unlock_outlined : Icons.fingerprint,
                                size: 48,
                                color: const Color(0xFF2563EB),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            useFace ? 'Unlock with Face ID' : 'Unlock with Fingerprint',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0B0B14),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            useFace
                                ? 'Use your face or fingerprint to open MediCore. Your credentials stay encrypted on this device.'
                                : 'Use your fingerprint to open MediCore. Your credentials stay encrypted on this device.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 11, color: Color(0xFF55556A), height: 1.5),
                          ),

                          // Failure message
                          if (failed) ...[
                            const SizedBox(height: 10),
                            const Text(
                              "We couldn't verify it's you. Please try again.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11, color: Color(0xFFD62839)),
                            ),
                          ],
                          const SizedBox(height: 16),

                          // Face ID / Fingerprint toggle
                          Container(
                            height: 46,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() {
                                      useFace = true;
                                      failed = false;
                                    }),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: useFace ? const Color(0xFF07070F) : Colors.transparent,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(
                                        'Face ID',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: useFace ? Colors.white : grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() {
                                      useFace = false;
                                      failed = false;
                                    }),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: !useFace ? const Color(0xFF07070F) : Colors.transparent,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(
                                        'Fingerprint',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: !useFace ? Colors.white : grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Use Face ID / Try again button
                          InkWell(
                            onTap: authenticate,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                color: const Color(0xFF07070F),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (!failed) ...[
                                    Icon(
                                      useFace ? Icons.face_unlock_outlined : Icons.fingerprint,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                  Text(
                                    failed ? 'Try again' : (useFace ? 'Use Face ID' : 'Use Fingerprint'),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Use password instead
                          Center(
                            child: GestureDetector(
                              onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const SignInScreen()),
                              ),
                              child: const Text(
                                'Use password instead',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF2F5BD3),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Secure note
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline, size: 12, color: grey),
                    SizedBox(width: 6),
                    Text(
                      'Secured with encrypted local storage',
                      style: TextStyle(fontSize: 10, color: grey),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}