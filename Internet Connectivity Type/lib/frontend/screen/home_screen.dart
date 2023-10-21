import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connectivity_check/backend/cubits/internet_cubit.dart';
import 'package:internet_connectivity_check/backend/states/internet_status.dart';
import 'package:internet_connectivity_check/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 91, 64, 141),
          title: Text(
            "Internet Connectivity Type",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 14, 214, 137),
              //backgroundColor: Color.fromARGB(255, 91, 64, 141)
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Using",
                style: TextStyle(
                    color: const Color.fromARGB(255, 104, 78, 150),
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dotted,
                    fontSize: 40),
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<InternetCubit, InternetState>(
                  builder: (internetCubitContext, state) {
                if (state is InternetConnected &&
                    state.connectionTypes == ConnectionTypes.Broadband) {
                  return Text(
                    "Wi-Fi",
                    style: Theme.of(internetCubitContext)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: Colors.green),
                  );
                } else if (state is InternetConnected &&
                    state.connectionTypes == ConnectionTypes.Operator_data) {
                  return Text(
                    'Mobile Data',
                    style: Theme.of(internetCubitContext)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(
                          color: Colors.red,
                        ),
                  );
                } else if (state is InternetDisconnected) {
                  return Text(
                    'Disconnected',
                    style: Theme.of(internetCubitContext)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(
                          color: Colors.grey,
                        ),
                  );
                }
                return CircularProgressIndicator();
              })
            ],
          ),
        ),
      ),
    );
  }
}
