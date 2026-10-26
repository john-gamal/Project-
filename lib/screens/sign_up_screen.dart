import 'package:flutter/material.dart';
import '../core/app_routes.dart';
import '../core/app_theme.dart';
import '../core/validators.dart';
import '../widgets/app_buttons.dart';
import '../widgets/app_text_field.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_scaffold.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _agreed = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _createAccount() {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the Terms & Privacy Policy')),
      );
      return;
    }
    // TODO: call your sign-up service here.
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.welcome,
      (route) => false,
      arguments: _email.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      header: const AuthHeader(
        title: 'Create account',
        subtitle: 'Join in less than a minute',
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              label: 'Full name',
              hint: 'Your name',
              icon: Icons.person_outline,
              controller: _name,
              textInputAction: TextInputAction.next,
              validator: (v) => Validators.required(v, 'Name'),
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Email',
              hint: 'you@example.com',
              icon: Icons.mail_outline,
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: Validators.email,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Password',
              hint: 'At least 8 characters',
              icon: Icons.lock_outline,
              controller: _password,
              isPassword: true,
              textInputAction: TextInputAction.next,
              validator: Validators.password,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Confirm password',
              hint: 'Repeat password',
              icon: Icons.lock_outline,
              controller: _confirm,
              isPassword: true,
              textInputAction: TextInputAction.done,
              validator: (v) =>
                  v != _password.text ? 'Passwords do not match' : null,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: _agreed,
                    activeColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    onChanged: (v) => setState(() => _agreed = v ?? false),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text('I agree to the Terms & Privacy Policy',
                      style: TextStyle(fontSize: 11, color: AppColors.muted)),
                ),
              ],
            ),
            const Spacer(),
            const SizedBox(height: 20),
            PrimaryButton(label: 'Create account', onPressed: _createAccount),
            const SizedBox(height: 14),
            BottomLink(
              text: 'Already registered?',
              action: 'Sign in',
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
