import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_with_getx/global.dart';
import 'package:todo_app_with_getx/routes/app-route.dart';
import 'package:todo_app_with_getx/routes/route-name.dart';

Future<void> main() async {
  await Global.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TODO-APP-WITH-GETX",
      initialRoute: RouteName.INITIAL,
      getPages: AppRoutes.routes,
    );
  }
}
