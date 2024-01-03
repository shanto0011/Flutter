//import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

enum Filter { all, active, completed }


class Todo {
  final String id;
  final String desc;
  final RxBool completed;

  Todo({
    required this.id,
    required this.desc,
    bool? completed,
  }) : completed = (completed ?? false).obs;

  Todo copyWith({
    String? id,
    String? desc,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      desc: desc ?? this.desc,
      completed: completed != null ? completed : this.completed.value,
    );
  }
}

class TodoController extends GetxController {
  RxList<Todo> todos = <Todo>[].obs;
  RxList<Todo> filteredTodos = <Todo>[].obs;
  RxString searchTerm = ''.obs;
  Rx<Filter> selectedFilter = Filter.all.obs;

  late final CollectionReference<Map<String, dynamic>> todosCollection;

  @override
  void onInit() {
    super.onInit();
    todosCollection = FirebaseFirestore.instance.collection('todos');
    fetchTodos();
    everAll([todos, searchTerm, selectedFilter], (_) {
      setFilteredTodos();
    });
  }

  void fetchTodos() async {
    final querySnapshot = await todosCollection.get();
    todos.assignAll(querySnapshot.docs.map((doc) {
      final data = doc.data();
      return Todo(
        id: doc.id,
        desc: data['desc'],
        completed: data['completed'] ?? false,
      );
    }).toList());
    setFilteredTodos();
  }

  void setFilteredTodos() {
    List<Todo> _filteredTodos = todos;

    switch (selectedFilter.value) {
      case Filter.active:
        _filteredTodos =
            todos.where((Todo todo) => !todo.completed.value).toList();
        break;
      case Filter.completed:
        _filteredTodos =
            todos.where((Todo todo) => todo.completed.value).toList();
        break;
      case Filter.all:
      default:
        break;
    }

    if (searchTerm.value.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(searchTerm.value.toLowerCase()))
          .toList();
    }

    filteredTodos.assignAll(_filteredTodos);
  }

  Future<void> toggleTodo(String id) async {
    final index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      await todosCollection
          .doc(id)
          .update({'completed': !todos[index].completed.value});
      fetchTodos();
    }
  }

  Future<void> removeTodo(String id) async {
    await todosCollection.doc(id).delete();
    fetchTodos();
  }

  Future<void> addTodo(String desc) async {
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      desc: desc,
    );

    await todosCollection.add({
      'desc': newTodo.desc,
      'completed': newTodo.completed.value,
    });
    fetchTodos();
  }

  Future<void> editTodo(String id, String newDesc) async {
    await todosCollection.doc(id).update({'desc': newDesc});
    fetchTodos();
  }

  void setSearchTerm(String term) {
    searchTerm.value = term;
  }

  void changeFilter(Filter newFilter) {
    selectedFilter.value = newFilter;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

