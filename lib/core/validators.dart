class Validators {
  static String? email(String? v) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return 'Email is required';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
    return ok ? null : 'Enter a valid email';
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 8) return 'At least 8 characters';
    return null;
  }

  static String? required(String? v, String label) =>
      (v == null || v.trim().isEmpty) ? '$label is required' : null;
}
