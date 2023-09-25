// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:presence_bloc_firebase/data/datasources/user_datasource.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserDatasource datasource;
  UserBloc(
    this.datasource,
  ) : super(UserInitial()) {
    on<GetUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        datasource.streamUser();
        datasource.streamLastPresence();
        datasource.streamTodayPresence();
        emit(UserLoaded());
      } catch (e) {
        emit(UserError(message: 'Error Get User'));
      }
    });
  }
}
