part of 'auth_bloc.dart';

abstract class AuthState {}

// Initial
final class AuthInitial extends AuthState {}

// Login
final class AuthLoginLoading extends AuthState {}

final class AuthLoginLoaded extends AuthState {
  // Response
  final User user;
  AuthLoginLoaded({
    required this.user,
  });
}

// Regitser
final class AuthRegisterLoading extends AuthState {}

final class AuthRegisterLoaded extends AuthState {
  // Response
  final User user;
  AuthRegisterLoaded({
    required this.user,
  });
}

// Logout
final class AuthLogoutLoading extends AuthState {}

final class AuthLogoutLoaded extends AuthState {}

// Error
final class AuthError extends AuthState {
  final String message;
  AuthError({
    required this.message,
  });
}
