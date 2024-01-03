import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_with_getx/firebase_options.dart';
//import 'package:todo_app_with_getx/pages/todo-pages/controller.dart';
import 'package:todo_app_with_getx/services/storage.dart';
import 'package:todo_app_with_getx/store/user.dart';

import 'pages/testcontroller.dart';

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    //await Get.putAsync<StorageService>(() => StorageService().init());
    //Get.put<UserStore>(UserStore());
    //await Get.put<TodoController>(TodoController());
    //await Get.put<>
  }
}
