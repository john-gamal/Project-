import 'package:flutter/material.dart';
import 'package:project/core/app_routes.dart';

import '../widgets/app_buttons.dart';
import '../widgets/app_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 48),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Color(0xFF5235EA),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 25),

                              Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),

                              const SizedBox(height: 6),
                              Text(
                                'Enter your email and we will send you a reset link',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.75),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(34),
                                topRight: Radius.circular(34),
                              ),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      width: 54,
                                      height: 54,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                          255,
                                          239,
                                          237,
                                          248,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.email_outlined,
                                          size: 28,
                                          color: Color(0xFF5235EA),
                                        ),
                                      ),
                                    ),
                                  ),

                                  AppTextField(
                                    label: 'Email',
                                    hint: 'you@example.com',
                                    icon: Icons.mail_outline,
                                    controller: _email,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email or username';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(height: 15),
                                  PrimaryButton(
                                    label: 'Send reset link',
                                    onPressed: () {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Reset link sent to ${_email.text.trim()}',
                                          ),
                                        ),
                                      );
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const SizedBox(height: 20),

                                  Center(
                                    child: BottomLink(
                                      text: 'Remembered it?',
                                      action: 'Back to sign in',
                                      onTap: () => Navigator.pushNamed(
                                        context,
                                        AppRoutes.signUp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
