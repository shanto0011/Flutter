import 'package:flutter/material.dart';
import 'package:internet_connectivity_check/frontend/screen/home_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => HomeScreen());
      default:
        return null;
    }
  }
}
