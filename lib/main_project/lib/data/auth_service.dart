import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'medical_store.dart';

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  final FlutterSecureStorage _secure = const FlutterSecureStorage();

  final LocalAuthentication _localAuth = LocalAuthentication();

  String? email;
  String? role;
  String? name;
  Future<Map<String, dynamic>?> _account(
    String email,
  ) async {
    final id = email.trim().toLowerCase();

    final json = await _secure.read(
      key: 'account_$id',
    );

    if (json == null) {
      return null;
    }

    return Map<String, dynamic>.from(
      jsonDecode(json),
    );
  }

  String _hash(
    String password,
    String salt,
  ) {
    return sha256
        .convert(
          utf8.encode('$salt:$password'),
        )
        .toString();
  }

  Future<String?> register({
    required String email,
    required String password,
    required String name,
    required String role,
    String? specialty,
    String? license,
  }) async {
    final id = email.trim().toLowerCase();

    final existingAccount = await _account(id);

    if (existingAccount != null) {
      return 'An account with this email already exists.';
    }

    final random = Random.secure();

    final salt = List.generate(
      24,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
    final accountData = {
      'email': id,
      'name': name,
      'role': role,
      'salt': salt,
      'hash': _hash(password, salt),
      'specialty': specialty,
      'license': license,
    };
    await _secure.write(
      key: 'account_$id',
      value: jsonEncode(accountData),
    );
    await _start(id, role, name);
    return null;
  }

  Future<bool> signIn(
    String email,
    String password,
    String expectedRole,
  ) async {
    final account = await _account(email);

    if (account == null) {
      return false;
    }

    if (account['role'] != expectedRole) {
      return false;
    }

    if (account['hash'] != _hash(password, account['salt'] as String)) {
      return false;
    }

    await _start(
      account['email'] as String,
      account['role'] as String,
      account['name'] as String,
    );

    return true;
  }

  Future<void> _start(
    String email,
    String role,
    String name,
  ) async {
    this.email = email;
    this.role = role;
    this.name = name;

    await _secure.write(
      key: 'active_user',
      value: email,
    );

    if (role == 'patient') {
      await MedicalStore.instance.loadFor(
        email,
        name: name,
      );
    }
  }

  Future<bool> restore() async {
    final id = await _secure.read(
      key: 'active_user',
    );

    if (id == null) {
      return false;
    }

    final account = await _account(id);

    if (account == null) {
      return false;
    }

    await _start(
      id,
      account['role'] as String,
      account['name'] as String,
    );

    return true;
  }

  Future<void> signOut() async {
    email = null;
    role = null;
    name = null;

    await _secure.delete(
      key: 'active_user',
    );
  }

  Future<bool> get biometricEnabled async {
    final value = await _secure.read(
      key: 'biometric_enabled',
    );

    return value == 'true';
  }

  Future<bool> canUseBiometrics() async {
    try {
      final supported = await _localAuth.isDeviceSupported();

      final canCheck = await _localAuth.canCheckBiometrics;

      return supported && canCheck;
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticateBiometric() async {
    try {
      final supported = await canUseBiometrics();

      if (!supported) {
        return false;
      }

      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Unlock your MediCore account',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );

      return authenticated;
    } catch (_) {
      return false;
    }
  }

  Future<bool> enableBiometrics() async {
    final passed = await authenticateBiometric();
    if (passed) {
      await _secure.write(
        key: 'biometric_enabled',
        value: 'true',
      );
    }
    return passed;
  }

  Future<void> disableBiometrics() async {
    await _secure.delete(
      key: 'biometric_enabled',
    );
  }
}
