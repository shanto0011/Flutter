import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_with_getx/controller/todo-controller.dart';

class TodoPage extends GetView<TodoController> {
  final TextEditingController newTodoController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: newTodoController,
              decoration: InputDecoration(
                hintText: 'Enter a new todo...',
              ),
              onSubmitted: (value) {
                controller.addTodo(value);
                newTodoController.clear();
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _buildFilterDropdown(),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.filteredTodos.length,
                itemBuilder: (context, index) {
                  final todo = controller.filteredTodos[index];
                  return Obx(() => ListTile(
                        title: Text(todo.desc),
                        leading: //Obx(() =>
                            Checkbox(
                          value: todo.completed.value,
                          onChanged: (value) {
                            controller.toggleTodo(todo.id);
                          },
                        ), //),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            controller.removeTodo(todo.id);
                          },
                        ),
                        onTap: () {
                          _editTodoDialog(context, todo);
                        },
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          controller.setSearchTerm(value);
        },
        decoration: InputDecoration(
          hintText: 'Search todos...',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Filter:'),
        SizedBox(width: 10),
        Obx(
          () => DropdownButton<Filter>(
            value: controller.selectedFilter.value,
            items: [
              DropdownMenuItem(
                value: Filter.all,
                child: Text('All'),
              ),
              DropdownMenuItem(
                value: Filter.active,
                child: Text('Active'),
              ),
              DropdownMenuItem(
                value: Filter.completed,
                child: Text('Completed'),
              ),
            ],
            onChanged: (value) {
              controller.changeFilter(value!);
            },
          ),
        ),
      ],
    );
  }

  Future<void> _editTodoDialog(BuildContext context, Todo todo) async {
    editController.text = todo.desc;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Todo'),
          content: TextField(
            controller: editController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Todo Description',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                final todoDesc = editController.text.trim();
                if (todoDesc.isNotEmpty) {
                  controller.editTodo(todo.id, todoDesc);
                  Navigator.pop(context);
                }
              },
              child: Text('EDIT'),
            ),
          ],
        );
      },
    );
  }
}
