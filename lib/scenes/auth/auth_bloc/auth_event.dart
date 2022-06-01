part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class StartupEvent extends AuthEvent {
  final Roles? roles;

  StartupEvent({this.roles});
}

class SignOutEvent extends AuthEvent {}

class SignInEvent extends AuthEvent {
  final Roles? userRole;
  final String login;
  final String password;

  SignInEvent({required this.login, required this.userRole, required this.password});
}

class RegisterUserEvent extends AuthEvent {
  final String login;
  final String password;
  final Roles roles;

  RegisterUserEvent({required this.login, required this.password, required this.roles});
}
