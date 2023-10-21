import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connectivity_check/backend/cubits/internet_cubit.dart';
import 'package:internet_connectivity_check/frontend/routes/routes.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;
  const MyApp({super.key, required this.appRouter, required this.connectivity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InternetCubit>(
        create: (internetCubitContext) =>
            InternetCubit(connectivity: connectivity),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Internet Connectivity check",
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: appRouter.onGenerateRoute,
        ));
  }
}
