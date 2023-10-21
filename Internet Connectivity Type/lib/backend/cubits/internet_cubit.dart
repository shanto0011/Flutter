import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connectivity_check/backend/states/internet_status.dart';
import 'package:internet_connectivity_check/constant.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription<ConnectivityResult> connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  void monitorInternetConnection() {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionTypes.Broadband);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionTypes.Operator_data);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionTypes _connectionType) {
    emit(InternetConnected(connectionTypes: _connectionType));
  }

  void emitInternetDisconnected() {
    emit(InternetDisconnected());
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
