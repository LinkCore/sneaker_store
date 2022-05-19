part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class StartupEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}

class SignInEvent extends AuthEvent {
  final String login;
  final String password;

  SignInEvent({required this.login, required this.password});
}

class RegisterUserEvent extends AuthEvent {
  final String login;
  final String password;
  final Roles roles;

  RegisterUserEvent(
      {required this.login, required this.password, required this.roles});
}
