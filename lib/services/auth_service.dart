import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/supabase_config.dart';

class AuthService {
  const AuthService();

  SupabaseClient get _client => SupabaseConfig.client;

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  Future<AuthResponse> signIn(
      {required String email, required String password}) {
    return _client.auth
        .signInWithPassword(email: email.trim(), password: password);
  }

  Future<AuthResponse> signUp(
      {required String email,
      required String password,
      required String fullName}) {
    return _client.auth.signUp(
        email: email.trim(),
        password: password,
        data: {'full_name': fullName.trim()});
  }

  Future<void> sendPasswordReset(String email) =>
      _client.auth.resetPasswordForEmail(email.trim());

  Future<void> signOut() => _client.auth.signOut();
}

String authErrorMessage(Object error) {
  if (error is AuthException) {
    if (error.statusCode == '400' &&
        error.message.toLowerCase().contains('invalid login')) {
      return 'The email or password is incorrect.';
    }
    if (error.statusCode == '422')
      return 'Please use a valid email and a stronger password.';
    return error.message;
  }
  return 'Authentication failed. Check your connection and try again.';
}
