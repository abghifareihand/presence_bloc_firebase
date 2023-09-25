part of 'user_bloc.dart';

abstract class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {}

final class UserError extends UserState {
  final String message;

  UserError({
    required this.message,
  });
}
