// lib/blocs/auth_state.dart
abstract class AuthState {}

class Unauthenticated extends AuthState {} // Initial state
class Authenticated extends AuthState {}
class AuthLoading extends AuthState {}
class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}
