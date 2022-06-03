part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class NeedToAuthState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AutoLoginState extends AuthState {
  final Roles? userRole;

  AutoLoginState({required this.userRole});
}

class AuthErrorState extends AuthState {
  final String errorText;

  AuthErrorState({required this.errorText});
}