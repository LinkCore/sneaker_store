import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/user/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<StartupEvent>(_onStartupEvent);
  }

  Future<FutureOr<void>> _onStartupEvent(StartupEvent event,
      Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (await UserRepository().isUserExistLocal()) {
      emit(AutoLoginState());
    } else {
      emit(NeedToAuthState());
    }
  }



}
