import 'dart:async';
import 'package:flutter/material.dart';

class CheckEmailScreen extends StatefulWidget {
  final String email;
  const CheckEmailScreen({super.key, this.email = 'nadeen@email.com'});

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  int secondsLeft = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer?.cancel();
    secondsLeft = 30;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() => secondsLeft--);
      if (secondsLeft <= 0) t.cancel();
    });
  }

  void resend() {
    // TODO: ابعتي الـ reset link تاني بالـ API
    setState(startTimer);
  }

  @override
  Widget build(BuildContext context) {
    final counting = secondsLeft > 0;
    final time = '0:${secondsLeft.toString().padLeft(2, '0')}';

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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 10),

                // Top bar
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        customBorder: const CircleBorder(),
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back, size: 16),
                        ),
                      ),
                    ),
                    const Text(
                      'Reset link sent',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                  ],
                ),

                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Mail icon
                          Center(
                            child: Container(
                              width: 78,
                              height: 78,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD9F2E6),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.mail_outline,
                                size: 32,
                                color: Color(0xFF22A06B),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Check your email',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0B0B14),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'We sent a password reset link to ${widget.email}.\nIt expires in 30 minutes.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 11, color: Color(0xFF8A8A99), height: 1.4),
                          ),
                          const SizedBox(height: 14),

                          // Open email app
                          InkWell(
                            onTap: () {
                              // TODO: افتحي تطبيق الإيميل (محتاجة package زي url_launcher)
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
                                      'Open email app',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
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
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      size: 15,
                                      color: Color(0xFF0B0B14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Resend link (with countdown)
                          InkWell(
                            onTap: counting ? null : resend,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              height: 48,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                counting ? 'Resend in $time' : 'Resend link',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: counting ? const Color(0xFF8A8A99) : const Color(0xFF0B0B14),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Spam hint + Change email
                          const Text(
                            "Can't find it? Check your Spam folder.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10, color: Color(0xFF8A8A99)),
                          ),
                          const SizedBox(height: 6),
                          Center(
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Text(
                                'Change email',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF2F5BD3),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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