import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:random_string_generator/random_string_generator.dart';

import '../../../core/user/auth_repository.dart';
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

  final UserRepository _userRepository = UserRepository();

  Future<void> _onStartupEvent(
      StartupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (await _userRepository.isUserExistLocal()) {
      emit(AutoLoginState(userRole: _userRepository.currentUser.roles));
    } else {
      emit(NeedToAuthState());
    }
  }

  Future<void> _onRegisterUserEvent(
      RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    try {
      await AuthRepository().signUpWithEmail(event.login, event.password);

      LocalUser newUser = LocalUser(
        id: RandomStringGenerator(fixedLength: 10, hasSymbols: false)
            .generate(),
        roles: event.roles,
        login: event.login,
        password: event.password
      );

      try {
        _userRepository.addUserLocal(
            newUser.login, newUser.password, newUser.roles, newUser.id);
        _userRepository.addUserRemote(newUser);
        emit(AutoLoginState(userRole: event.roles));
      } catch (e) {
        emit(AuthErrorState(errorText: e.toString()));
      }
    } on Exception catch (e) {
      emit(AuthErrorState(errorText: e.toString()));
    }
  }

  Future<void> _onSignInEvent(
      SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await AuthRepository().signInWithEmail(event.login, event.password);
      if (await _userRepository.isUserExistRemote(
          event.login, event.password)) {
        _userRepository.addUserLocal(
          _userRepository.currentUser.login,
          _userRepository.currentUser.password,
          _userRepository.currentUser.roles,
          _userRepository.currentUser.id
        );
        emit(AutoLoginState(userRole: _userRepository.currentUser.roles));
      } else {
        emit(AuthErrorState(errorText: S.current.userIsNotExist));
      }
    } catch (e) {
      (AuthErrorState(errorText: e.toString()));
    }
  }

  Future<void> _onSignOutEvent(
      SignOutEvent event, Emitter<AuthState> emit) async {
    _userRepository.removeUserLocal();
    emit(NeedToAuthState());
  }
}
