import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool hidePassword = true;
  bool agreed = false; // الزر مش شغال غير لما الـ Terms تتفعل
  String? error;

  bool get hasLength => passwordController.text.length >= 8;
  bool get hasNumber => RegExp(r'\d').hasMatch(passwordController.text);
  bool get hasUpper => RegExp(r'[A-Z]').hasMatch(passwordController.text);

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void submit() {
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    String? msg;

    if (nameController.text.trim().isEmpty) {
      msg = 'Please enter your full name.';
    } else if (!email.contains('@') || !email.contains('.')) {
      msg = 'Please enter a valid email.';
    } else if (!RegExp(r'^01[0125]\d{8}$').hasMatch(phone)) {
      msg = 'Please enter a valid mobile number.';
    } else if (!(hasLength && hasNumber && hasUpper)) {
      msg = 'Password does not meet the rules.';
    } else if (passwordController.text != confirmController.text) {
      msg = 'Passwords do not match.';
    }

    setState(() => error = msg);

    if (msg == null) {
      // TODO: اعملي register بالـ API وبعدها روحي لشاشة Verify email / OTP
    }
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
                      'Create account',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Join MediCore',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0B0B14),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Your health records, safely in one place',
                          style: TextStyle(fontSize: 11, color: Color(0xFF8A8A99)),
                        ),
                        const SizedBox(height: 14),

                        // Full name
                        const Text('Full name', style: TextStyle(fontSize: 10, color: Color(0xFF8A8A99))),
                        const SizedBox(height: 6),
                        Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: nameController,
                            style: const TextStyle(fontSize: 12),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nadeen Ayman',
                              hintStyle: TextStyle(fontSize: 12, color: Color(0xFF8A8A99)),
                              prefixIcon: Icon(Icons.person_outline, size: 16, color: Color(0xFF55556A)),
                              contentPadding: EdgeInsets.symmetric(vertical: 13),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Email
                        const Text('Email', style: TextStyle(fontSize: 10, color: Color(0xFF8A8A99))),
                        const SizedBox(height: 6),
                        Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(fontSize: 12),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'nadeen@email.com',
                              hintStyle: TextStyle(fontSize: 12, color: Color(0xFF8A8A99)),
                              prefixIcon: Icon(Icons.mail_outline, size: 16, color: Color(0xFF55556A)),
                              contentPadding: EdgeInsets.symmetric(vertical: 13),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Mobile number
                        const Text('Mobile number', style: TextStyle(fontSize: 10, color: Color(0xFF8A8A99))),
                        const SizedBox(height: 6),
                        Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(fontSize: 12),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '01xxxxxxxxx',
                              hintStyle: TextStyle(fontSize: 12, color: Color(0xFF8A8A99)),
                              prefixIcon: Icon(Icons.phone_outlined, size: 16, color: Color(0xFF55556A)),
                              contentPadding: EdgeInsets.symmetric(vertical: 13),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Password
                        const Text('Password', style: TextStyle(fontSize: 10, color: Color(0xFF8A8A99))),
                        const SizedBox(height: 6),
                        Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: passwordController,
                            obscureText: hidePassword,
                            onChanged: (_) => setState(() {}),
                            style: const TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'At least 8 characters',
                              hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF8A8A99)),
                              prefixIcon: const Icon(Icons.lock_outline, size: 16, color: Color(0xFF55556A)),
                              suffixIcon: IconButton(
                                onPressed: () => setState(() => hidePassword = !hidePassword),
                                icon: Icon(
                                  hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                  size: 16,
                                  color: const Color(0xFF55556A),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 13),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Password rules
                        Wrap(
                          spacing: 12,
                          children: [
                            Text(
                              (hasLength ? '✓ ' : '○ ') + '8+ characters',
                              style: TextStyle(
                                fontSize: 9,
                                color: hasLength ? const Color(0xFF22A06B) : const Color(0xFF8A8A99),
                              ),
                            ),
                            Text(
                              (hasNumber ? '✓ ' : '○ ') + 'A number',
                              style: TextStyle(
                                fontSize: 9,
                                color: hasNumber ? const Color(0xFF22A06B) : const Color(0xFF8A8A99),
                              ),
                            ),
                            Text(
                              (hasUpper ? '✓ ' : '○ ') + 'An uppercase letter',
                              style: TextStyle(
                                fontSize: 9,
                                color: hasUpper ? const Color(0xFF22A06B) : const Color(0xFF8A8A99),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Confirm password
                        const Text('Confirm password', style: TextStyle(fontSize: 10, color: Color(0xFF8A8A99))),
                        const SizedBox(height: 6),
                        Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: confirmController,
                            obscureText: true,
                            style: const TextStyle(fontSize: 12),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Repeat password',
                              hintStyle: TextStyle(fontSize: 12, color: Color(0xFF8A8A99)),
                              prefixIcon: Icon(Icons.lock_outline, size: 16, color: Color(0xFF55556A)),
                              contentPadding: EdgeInsets.symmetric(vertical: 13),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Terms checkbox
                        GestureDetector(
                          onTap: () => setState(() => agreed = !agreed),
                          child: Row(
                            children: [
                              Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: agreed ? const Color(0xFF07070F) : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: agreed ? const Color(0xFF07070F) : const Color(0xFFB5B5C3),
                                  ),
                                ),
                                child: agreed
                                    ? const Icon(Icons.check, size: 11, color: Colors.white)
                                    : null,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'I agree to the Terms & Privacy Policy',
                                style: TextStyle(fontSize: 10, color: Color(0xFF55556A)),
                              ),
                            ],
                          ),
                        ),

                        // Error message
                        if (error != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            error!,
                            style: const TextStyle(fontSize: 10, color: Color(0xFFD62839)),
                          ),
                        ],
                        const SizedBox(height: 14),

                        // Create account button
                        Opacity(
                          opacity: agreed ? 1 : 0.4,
                          child: InkWell(
                            onTap: agreed ? submit : null,
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
                                      'Create account',
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
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),

                // Already have an account
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 10, color: Color(0xFF8A8A99)),
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
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}