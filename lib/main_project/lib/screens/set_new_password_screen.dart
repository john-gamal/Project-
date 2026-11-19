import 'package:flutter/material.dart';
import 'password_updated_screen.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  bool get hasLength => newController.text.length >= 8;
  bool get hasNumber => RegExp(r'\d').hasMatch(newController.text);
  bool get hasUpper => RegExp(r'[A-Z]').hasMatch(newController.text);
  bool get matches =>
      confirmController.text.isNotEmpty &&
      confirmController.text == newController.text;
  bool get canSubmit => hasLength && hasNumber && hasUpper && matches;

  @override
  void dispose() {
    newController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void updatePassword() {
    // TODO: ابعتي الباسورد الجديد بالـ API (مع الـ token اللي جاي من لينك الإيميل)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const PasswordUpdatedScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF16A34A);
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
                      'New password',
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
                        const Text(
                          'Create a new password',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                            color: Color(0xFF0B0B14),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Choose something you haven't used before.",
                          style: TextStyle(fontSize: 11, color: grey),
                        ),
                        const SizedBox(height: 18),

                        // New password
                        const Text('New password', style: TextStyle(fontSize: 10, color: grey)),
                        const SizedBox(height: 6),
                        Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFF7FA0F0), width: 1.2),
                          ),
                          child: TextField(
                            controller: newController,
                            obscureText: true,
                            onChanged: (_) => setState(() {}),
                            style: const TextStyle(fontSize: 12),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '••••••••••',
                              hintStyle: TextStyle(fontSize: 12, color: grey),
                              prefixIcon: Icon(Icons.lock_outline, size: 16, color: Color(0xFF55556A)),
                              contentPadding: EdgeInsets.symmetric(vertical: 13),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Confirm password
                        const Text('Confirm password', style: TextStyle(fontSize: 10, color: grey)),
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
                            onChanged: (_) => setState(() {}),
                            style: const TextStyle(fontSize: 12),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Repeat password',
                              hintStyle: TextStyle(fontSize: 12, color: grey),
                              prefixIcon: Icon(Icons.lock_outline, size: 16, color: Color(0xFF55556A)),
                              contentPadding: EdgeInsets.symmetric(vertical: 13),
                            ),
                          ),
                        ),
                        if (confirmController.text.isNotEmpty && !matches) ...[
                          const SizedBox(height: 6),
                          const Text(
                            'Passwords do not match.',
                            style: TextStyle(fontSize: 10, color: Color(0xFFD62839)),
                          ),
                        ],
                        const SizedBox(height: 14),

                        // Rules checklist
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text(hasLength ? '✓' : '○',
                                    style: TextStyle(fontSize: 10, color: hasLength ? green : grey)),
                                const SizedBox(width: 8),
                                const Text('At least 8 characters',
                                    style: TextStyle(fontSize: 11, color: Color(0xFF33334A))),
                              ]),
                              const SizedBox(height: 8),
                              Row(children: [
                                Text(hasNumber ? '✓' : '○',
                                    style: TextStyle(fontSize: 10, color: hasNumber ? green : grey)),
                                const SizedBox(width: 8),
                                const Text('One number',
                                    style: TextStyle(fontSize: 11, color: Color(0xFF33334A))),
                              ]),
                              const SizedBox(height: 8),
                              Row(children: [
                                Text(hasUpper ? '✓' : '○',
                                    style: TextStyle(fontSize: 10, color: hasUpper ? green : grey)),
                                const SizedBox(width: 8),
                                const Text('One uppercase letter',
                                    style: TextStyle(fontSize: 11, color: Color(0xFF33334A))),
                              ]),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),

                // Update password button
                Opacity(
                  opacity: canSubmit ? 1 : 0.4,
                  child: InkWell(
                    onTap: canSubmit ? updatePassword : null,
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
                              'Update password',
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