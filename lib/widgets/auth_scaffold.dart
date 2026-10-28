import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  final Widget header;
  final Widget child;

  const AuthScaffold({super.key, required this.header, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [const SizedBox(height: 48), header, child],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
