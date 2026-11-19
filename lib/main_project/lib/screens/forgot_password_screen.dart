import 'package:project/screens/chek_email_screen.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  String? error;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void sendResetLink() {
    final email = emailController.text.trim();
    if (!email.contains('@') || !email.contains('.')) {
      setState(() => error = 'Please enter a valid email.');
      return;
    }
    setState(() => error = null);

    // TODO: ابعتي request الـ reset link بالـ API
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CheckEmailScreen(email: email)),
    );
  }

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
                      'Forgot password',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
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
                          // Lock icon
                          Center(
                            child: Container(
                              width: 78,
                              height: 78,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE2D8FA),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.lock_outline,
                                size: 32,
                                color: Color(0xFF8B5CF6),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Reset your password',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0B0B14),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Enter the email linked to your account and we'll send you a reset link.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF8A8A99),
                                height: 1.4),
                          ),
                          const SizedBox(height: 14),

                          // Email
                          const Text('Email',
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xFF8A8A99))),
                          const SizedBox(height: 6),
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: error != null
                                    ? const Color(0xFFD62839)
                                    : const Color(0xFF7FA0F0),
                                width: 1.2,
                              ),
                            ),
                            child: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(fontSize: 12),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'nadeen@email.com',
                                hintStyle: TextStyle(
                                    fontSize: 12, color: Color(0xFF8A8A99)),
                                prefixIcon: Icon(Icons.mail_outline,
                                    size: 16, color: Color(0xFF55556A)),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 13),
                              ),
                            ),
                          ),
                          if (error != null) ...[
                            const SizedBox(height: 6),
                            Text(
                              error!,
                              style: const TextStyle(
                                  fontSize: 10, color: Color(0xFFD62839)),
                            ),
                          ],
                          const SizedBox(height: 12),

                          // Send reset link button
                          InkWell(
                            onTap: sendResetLink,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              height: 48,
                              padding:
                                  const EdgeInsets.only(left: 22, right: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF07070F),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Send reset link',
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
                        ],
                      ),
                    ),
                  ),
                ),

                // Back to sign in
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 10, color: Color(0xFF8A8A99)),
                      children: [
                        TextSpan(text: 'Remember it? '),
                        TextSpan(
                          text: 'Back to sign in',
                          style: TextStyle(
                            color: Color(0xFF2F5BD3),
                            fontWeight: FontWeight.w700,
                          ),
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
