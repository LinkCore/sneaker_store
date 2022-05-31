part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityEvent {}

class HasConnectionEvent extends ConnectivityEvent {}

class NoConnectionEvent extends ConnectivityEvent {}

class StartupConnectionCheck extends ConnectivityEvent {}

class ConnectionChange extends ConnectivityEvent {
  final ConnectivityResult connectivityResult;

  ConnectionChange({required this.connectivityResult});
}
