import 'package:get/get.dart';
import 'package:todo_app_with_getx/controller/todo-controller.dart';

class TodoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoController>(() => TodoController());
  }
}
