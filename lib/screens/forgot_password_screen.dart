import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/validators.dart';
import '../widgets/app_buttons.dart';
import '../widgets/app_text_field.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_scaffold.dart';

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

  void _send() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reset link sent to ${_email.text.trim()}')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      header: const AuthHeader(
        title: 'Forgot password?',
        subtitle: 'Enter your email and we will send you a reset link',
        showBack: true,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.fill,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.mail_outline,
                    size: 30, color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 24),
            AppTextField(
              label: 'Email',
              hint: 'you@example.com',
              icon: Icons.mail_outline,
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: Validators.email,
            ),
            const SizedBox(height: 20),
            PrimaryButton(label: 'Send reset link', onPressed: _send),
            const SizedBox(height: 16),
            BottomLink(
              text: 'Remembered it?',
              action: 'Back to sign in',
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
