part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  // Request
  final String email;
  final String password;
  AuthLoginEvent({
    required this.email,
    required this.password,
  });
}

class AuthRegisterEvent extends AuthEvent {
  final String nip;
  final String name;
  final String email;
  final String password;

  AuthRegisterEvent({
    required this.nip,
    required this.name,
    required this.email,
    required this.password,
  });
}

class AuthLogoutEvent extends AuthEvent {}
