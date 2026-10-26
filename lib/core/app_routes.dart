import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/sign_up_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/welcome_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const signUp = '/sign-up';
  static const forgotPassword = '/forgot-password';
  static const welcome = '/welcome';

  static Map<String, WidgetBuilder> get routes => {
        login: (_) => const LoginScreen(),
        signUp: (_) => const SignUpScreen(),
        forgotPassword: (_) => const ForgotPasswordScreen(),
        welcome: (_) => const WelcomeScreen(),
      };
}
