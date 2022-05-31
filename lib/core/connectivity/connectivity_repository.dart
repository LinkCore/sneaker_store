import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityRepository {
  static final ConnectivityRepository _connectivityRepository = ConnectivityRepository._internal();

  factory ConnectivityRepository() {
    return _connectivityRepository;
  }

  ConnectivityRepository._internal();

  Stream<ConnectivityResult> connectivityResult = Connectivity().onConnectivityChanged;
}