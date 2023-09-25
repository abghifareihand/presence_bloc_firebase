// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:presence_bloc_firebase/data/datasources/auth_datasource.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthDatasource datasource;
  AuthBloc(
    this.datasource,
  ) : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoginLoading());
      try {
        final result = await datasource.loginUser(event.email, event.password);
        emit(AuthLoginLoaded(user: result));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
    on<AuthRegisterEvent>((event, emit) async {
      emit(AuthRegisterLoading());
      try {
        final result = await datasource.registerUser(
            event.nip, event.name, event.email, event.password);
        emit(AuthRegisterLoaded(user: result));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
    on<AuthLogoutEvent>((event, emit) async {
      emit(AuthLogoutLoading());
      try {
        await datasource.logoutUser();
        emit(AuthLogoutLoaded());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
