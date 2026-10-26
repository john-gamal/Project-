import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
    this.textInputAction,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _hidden = true;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword && _hidden,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(color: AppColors.muted, fontSize: 13),
            filled: true,
            fillColor: AppColors.fill,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            prefixIcon: Icon(widget.icon, size: 20, color: AppColors.muted),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _hidden
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20,
                      color: AppColors.muted,
                    ),
                    onPressed: () => setState(() => _hidden = !_hidden),
                  )
                : null,
            enabledBorder: _border(AppColors.border),
            focusedBorder: _border(AppColors.primary),
            errorBorder: _border(Colors.redAccent),
            focusedErrorBorder: _border(Colors.redAccent),
          ),
        ),
      ],
    );
  }
}
