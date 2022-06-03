import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_sneaker_store/core/connectivity/connectivity_repository.dart';
import 'package:meta/meta.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<ConnectionChange>(_onConnectionChange);
    on<StartupConnectionCheck>(_onStartupConnectionCheck);
    connectivitySubscription = ConnectivityRepository()
        .connectivityResult
        .listen((connectivityResult) {
      add(ConnectionChange(connectivityResult: connectivityResult));
    });
  }

  bool isStart = false;
  late StreamSubscription connectivitySubscription;

  void _onConnectionChange(
      ConnectionChange event, Emitter<ConnectivityState> emit) {
    HasConnectionState hasConnectionState = HasConnectionState(
        needToBlock: isStart);

    switch (event.connectivityResult) {
      case ConnectivityResult.bluetooth:
        break;
      case ConnectivityResult.wifi:
        emit(hasConnectionState);
        break;
      case ConnectivityResult.ethernet:
        emit(hasConnectionState);

        break;
      case ConnectivityResult.mobile:
        emit(hasConnectionState);
        break;
      case ConnectivityResult.none:
        emit(NoConnectionState());
        break;
    }
    isStart = true;
  }

  Future<void> _onStartupConnectionCheck(
      StartupConnectionCheck event, Emitter<ConnectivityState> emit) async {
    connectivitySubscription.pause();
    ConnectivityResult result = await Connectivity().checkConnectivity();

    HasConnectionState hasConnectionState = HasConnectionState(
        needToBlock: result == ConnectivityResult.none);

    switch (result) {
      case ConnectivityResult.bluetooth:
        break;
      case ConnectivityResult.wifi:
        emit(hasConnectionState);
        break;
      case ConnectivityResult.ethernet:
        emit(hasConnectionState);

        break;
      case ConnectivityResult.mobile:
        emit(hasConnectionState);
        break;
      case ConnectivityResult.none:
        emit(NoConnectionState());
        break;
    }
    connectivitySubscription.resume();
  }
}