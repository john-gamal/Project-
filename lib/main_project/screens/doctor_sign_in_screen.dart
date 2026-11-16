import 'package:flutter/material.dart';

import 'doctor_registration_screen.dart';
import 'enable_face_id_screen.dart';
import 'forgot_password_screen.dart';
import 'sign_in_screen.dart';

class DoctorSignInScreen extends StatefulWidget {
  const DoctorSignInScreen({super.key});

  @override
  State<DoctorSignInScreen> createState() => _DoctorSignInScreenState();
}

class _DoctorSignInScreenState extends State<DoctorSignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? error;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signIn() {
    // TODO: اربطي هنا بالـ API الحقيقي (والتأكد إن حساب الدكتور اتفعّل)
    final ok =
        emailController.text.trim().isNotEmpty &&
        passwordController.text == 'correct';
    if (ok) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const EnableFaceIdScreen()),
      );
      return;
    }
    setState(() => error = 'Wrong email or password.');
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Doctor sign in',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Role chip (Change يرجّعك لدور تاني)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDDE8FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Signing in as Doctor · ',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Color(0xFF1B2554),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SignInScreen(),
                                  ),
                                ),
                                child: const Text(
                                  'Change',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Color(0xFF1B2554),
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          'Welcome, Doctor',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0B0B14),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Sign in to your verified doctor account',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF8A8A99),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Work email
                        const Text(
                          'Work email',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF8A8A99),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF7FA0F0),
                              width: 1.2,
                            ),
                          ),
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(fontSize: 12),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'dr.sara@clinic.com',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF8A8A99),
                              ),
                              prefixIcon: Icon(
                                Icons.mail_outline,
                                size: 15,
                                color: Color(0xFF8A8A99),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 11,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Password
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF8A8A99),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: error != null
                                  ? const Color(0xFFD62839)
                                  : Colors.transparent,
                              width: 1.2,
                            ),
                          ),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            style: const TextStyle(fontSize: 12),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '••••••••',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF8A8A99),
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                size: 15,
                                color: Color(0xFF8A8A99),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 11,
                              ),
                            ),
                          ),
                        ),
                        if (error != null) ...[
                          const SizedBox(height: 6),
                          Text(
                            error!,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFFD62839),
                            ),
                          ),
                        ],
                        const SizedBox(height: 6),

                        // Forgot password
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ForgotPasswordScreen(),
                              ),
                            ),
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF2F5BD3),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Sign in button (navy)
                        InkWell(
                          onTap: signIn,
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 46,
                            padding: const EdgeInsets.only(left: 22, right: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1B2554),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
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

                        // Verification hint (تلميح عادي تحت الحقول)
                        const Row(
                          children: [
                            Icon(
                              Icons.shield_outlined,
                              size: 11,
                              color: Color(0xFF8A8A99),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Doctor accounts are verified before activation',
                              style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFF8A8A99),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),

                // Apply for an account
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const DoctorRegistrationScreen(startStep: 3),
                      ),
                    ),
                    child: const Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF55556A),
                        ),
                        children: [
                          TextSpan(text: 'New doctor? '),
                          TextSpan(
                            text: 'Apply for an account',
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
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
