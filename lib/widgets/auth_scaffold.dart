import 'package:flutter/material.dart';
import '../core/app_theme.dart';

/// Purple header on top + white rounded sheet below.
class AuthScaffold extends StatelessWidget {
  final Widget header;
  final Widget child;

  const AuthScaffold({super.key, required this.header, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            header,
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: LayoutBuilder(
                  builder: (context, c) => SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: c.maxHeight - 40),
                      child: IntrinsicHeight(child: child),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
