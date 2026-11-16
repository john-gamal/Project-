import 'package:flutter/material.dart';
import 'create_account_screen.dart';
import 'forgot_password_screen.dart';

class SignInScreen extends StatefulWidget {
  final bool isPatient;
  const SignInScreen({super.key, this.isPatient = true});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late bool isPatient = widget.isPatient;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  int attemptsLeft = 3;
  bool showError = false;
  bool biometricEnabled = true; // الأيقونات تظهر لو متفعلة

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleRole() => setState(() => isPatient = !isPatient);

  void signIn() {
    // TODO: اربطي هنا بالـ API الحقيقي
    final ok = emailController.text.trim().isNotEmpty &&
        passwordController.text == 'correct';
    if (ok) return;
    setState(() {
      attemptsLeft = (attemptsLeft - 1).clamp(0, 3);
      showError = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final roleName = isPatient ? 'Patient' : 'Doctor';

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
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back, size: 15),
                        ),
                      ),
                    ),
                    const Text(
                      'Sign in',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Role chip
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDDE8FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Signing in as $roleName · ',
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Color(0xFF2F5BD3),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              GestureDetector(
                                onTap: toggleRole,
                                child: const Text(
                                  'Change',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Color(0xFF2F5BD3),
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
                          'Welcome back',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0B0B14),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Sign in to your ${roleName.toLowerCase()} account',
                          style: const TextStyle(fontSize: 11, color: Color(0xFF8A8A99)),
                        ),
                        const SizedBox(height: 18),

                        // Email
                        const Text('Email', style: TextStyle(fontSize: 10, color: Color(0xFF8A8A99))),
                        const SizedBox(height: 6),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFF7FA0F0), width: 1.2),
                          ),
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(fontSize: 12),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'nadeen@email.com',
                              hintStyle: TextStyle(fontSize: 12, color: Color(0xFF8A8A99)),
                              prefixIcon: Icon(Icons.mail_outline, size: 15, color: Color(0xFF8A8A99)),
                              contentPadding: EdgeInsets.symmetric(vertical: 11),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Password
                        const Text('Password', style: TextStyle(fontSize: 10, color: Color(0xFF8A8A99))),
                        const SizedBox(height: 6),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: showError ? const Color(0xFFD62839) : Colors.transparent,
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
                              hintStyle: TextStyle(fontSize: 12, color: Color(0xFF8A8A99)),
                              prefixIcon: Icon(Icons.lock_outline, size: 15, color: Color(0xFF8A8A99)),
                              contentPadding: EdgeInsets.symmetric(vertical: 11),
                            ),
                          ),
                        ),

                        // Error message
                        if (showError) ...[
                          const SizedBox(height: 6),
                          Text(
                            'Wrong email or password. $attemptsLeft attempts left.',
                            style: const TextStyle(fontSize: 10, color: Color(0xFFD62839)),
                          ),
                        ],
                        const SizedBox(height: 6),

                        // Forgot password
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                            ),
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(fontSize: 10, color: Color(0xFF2F5BD3)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Sign in button
                        InkWell(
                          onTap: signIn,
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 46,
                            padding: const EdgeInsets.only(left: 22, right: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF07070F),
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
                        const SizedBox(height: 18),

                        // Biometrics
                        if (biometricEnabled) ...[
                          const Center(
                            child: Text(
                              'or unlock with',
                              style: TextStyle(fontSize: 10, color: Color(0xFF8A8A99)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icons.fingerprint, Icons.face]
                                .map(
                                  (icon) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    child: InkWell(
                                      onTap: () {},
                                      customBorder: const CircleBorder(),
                                      child: Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.05),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Icon(icon, size: 22, color: const Color(0xFF0B0B14)),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),

                // Create account
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CreateAccountScreen()),
                    ),
                    child: const Text.rich(
                      TextSpan(
                        style: TextStyle(fontSize: 10, color: Color(0xFF55556A)),
                        children: [
                          TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: 'Create one',
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