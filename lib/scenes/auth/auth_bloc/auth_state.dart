part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState{}

class AutoLoginState extends AuthState{}

class NeedToAuthState extends AuthState{}
