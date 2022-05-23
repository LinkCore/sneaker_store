import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:random_string_generator/random_string_generator.dart';

import '../../../core/user/roles.dart';
import '../../../core/user/user.dart';
import '../../../core/user/user_repository.dart';
import '../../../generated/l10n.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<StartupEvent>(_onStartupEvent);
    on<RegisterUserEvent>(_onRegisterUserEvent);
    on<SignInEvent>(_onSignInEvent);
    on<SignOutEvent>(_onSignOutEvent);
  }

  Future<FutureOr<void>> _onStartupEvent(
      StartupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (await UserRepository().isUserExistLocal()) {
      emit(AutoLoginState(userRole: event.roles));
    } else {
      emit(NeedToAuthState());
    }
  }

  Future<void> _onRegisterUserEvent(
      RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    User newUser = User(
      id: RandomStringGenerator(fixedLength: 10, hasSymbols: false).generate(),
      roles: event.roles,
      login: event.login,
      password: event.password,
    );

    try {
      UserRepository().addUserLocal(
          newUser.login, newUser.password, newUser.roles, newUser.id);
      UserRepository().addUserRemote(newUser);
      emit(AutoLoginState(userRole: event.roles));
    } catch (e) {
      emit(AuthErrorState(errorText: e.toString()));
    }
  }

  Future<void> _onSignInEvent(
      SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      if (await UserRepository()
          .isUserExistRemote(event.login, event.password)) {
        UserRepository().addUserLocal(
          UserRepository().currentUser.login,
          UserRepository().currentUser.password,
          UserRepository().currentUser.roles,
          UserRepository().currentUser.id,
        );

        emit(AutoLoginState(userRole: UserRepository().currentUser.roles));
      } else {
        emit(AuthErrorState(errorText: S.current.userIsNotExist));
      }
    } catch (e) {
      (AuthErrorState(errorText: e.toString()));
    }
  }

  Future<void> _onSignOutEvent(SignOutEvent event, Emitter<AuthState> emit) async {
    UserRepository().removeUserLocal();
    emit(NeedToAuthState());
  }
}
