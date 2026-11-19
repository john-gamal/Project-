import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_service.dart';

class AuthState {
  final String? email;
  final String? name;
  final String? role;
  final bool busy;
  final String? error;
  const AuthState({this.email, this.name, this.role, this.busy = false, this.error});
  bool get authenticated => email != null;
}

/// Application session state. Authentication / secure storage remain in
/// AuthService (repository); widgets use AuthCubit for auth-related actions.
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._service) : super(const AuthState());
  final AuthService _service;
  String? get email => state.email;
  String? get role => state.role;
  String? get name => state.name;
  Future<bool> get biometricEnabled => _service.biometricEnabled;

  void _publish() => emit(AuthState(email: _service.email, name: _service.name, role: _service.role));

  Future<bool> restore() async {
    emit(const AuthState(busy: true));
    try { final ok = await _service.restore(); _publish(); return ok; }
    catch (e) { emit(AuthState(error: e.toString())); return false; }
  }
  Future<bool> signIn(String email, String password, String expectedRole) async {
    emit(const AuthState(busy: true));
    try {
      final ok = await _service.signIn(email, password, expectedRole);
      if (ok) { _publish(); } else { emit(const AuthState(error: 'Invalid credentials or account role')); }
      return ok;
    } catch (e) { emit(AuthState(error: e.toString())); return false; }
  }
  Future<String?> register({required String email, required String password, required String name, required String role, String? specialty, String? license}) async {
    emit(const AuthState(busy: true));
    try {
      final error = await _service.register(email: email, password: password, name: name, role: role, specialty: specialty, license: license);
      if (error == null) { _publish(); } else { emit(AuthState(error: error)); }
      return error;
    } catch (e) { emit(AuthState(error: e.toString())); return e.toString(); }
  }
  Future<void> signOut() async { await _service.signOut(); emit(const AuthState()); }
  Future<bool> authenticateBiometric() => _service.authenticateBiometric();
  Future<bool> enableBiometrics() => _service.enableBiometrics();
  Future<void> disableBiometrics() => _service.disableBiometrics();
}
