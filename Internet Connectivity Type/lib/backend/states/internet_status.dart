import 'package:flutter/material.dart';
import '../../constant.dart';

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionTypes connectionTypes;

  InternetConnected({required this.connectionTypes});
}

class InternetDisconnected extends InternetState {}
