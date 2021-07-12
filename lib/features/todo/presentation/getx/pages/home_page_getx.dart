import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/features/todo/presentation/getx/controllers/todo_controller.dart';
import 'package:to_do/features/todo/presentation/page_states/todo_state.dart';

class HomePageGetx extends StatelessWidget {
  HomePageGetx({Key? key}) : super(key: key);

  final todoController = Get.find<TodoController>();

  void _addTask() async {
    todoController.retrieveAllTasks();
    print('list: ${todoController.todoTasks}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To do list with - GetX"),
      ),
      body: GetX<TodoController>(
        initState: (state) {
          Get.find<TodoController>().retrieveAllTasks();
        },
        builder: (controller) {
          final state = controller.todoState;
          print(controller.todoState);
          if (state == TodoState.initial) {
            return _InitialStateWidget();
          }
          if (state == TodoState.loading) {
            return _LoadingStateWidget();
          }
          if (state == TodoState.loaded || state == TodoState.deleted) {
            return _LoadedStateWidget();
          }
          if (state == TodoState.error) {
            return _ErrorStateWidget(
              errorMessage: controller.errorMessage,
            );
          }
          return Text('Not Recognized');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add new Task',
        child: Icon(Icons.add),
      ),
    );
  }

  void _showDeletedSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Task removed with success!'),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          // do something
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class _LoadedStateWidget extends StatelessWidget {
  _LoadedStateWidget({Key? key}) : super(key: key);
  final todoController = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    final List<TodoTask> todoTasks = todoController.todoTasks;

    if (todoTasks.isEmpty) {
      return Center(
          child: Container(
        child: Text('No tasks'),
      ));
    }
    return RefreshIndicator(
      onRefresh: todoController.retrieveAllTasks,
      child: ListView.builder(
        itemCount: todoTasks.length,
        itemBuilder: (context, index) {
          final todoTask = todoTasks[index];
          return ListTile(
            leading: Checkbox(
              value: todoTask.completed,
              onChanged: (value) {
                final task = todoTask.copyWith(completed: value);
                todoController.updateTodoTask(task);
              },
            ),
            title: Text(todoTask.name),
            onLongPress: () => _deleteItem(context, todoTask),
          );
        },
      ),
    );
  }

  void _deleteItem(BuildContext context, TodoTask todoTask) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete"),
        content: Text("Delete this task: ${todoTask.name}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              todoController.deleteTodoTask(todoTask);
              Navigator.of(context).pop();
            },
            child: Text('Confirm'),
          )
        ],
      ),
    );
  }
}

class _ErrorStateWidget extends StatelessWidget {
  final String errorMessage;

  const _ErrorStateWidget({
    required this.errorMessage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMessage),
    );
  }
}

class _LoadingStateWidget extends StatelessWidget {
  const _LoadingStateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class _InitialStateWidget extends StatelessWidget {
  const _InitialStateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Initial State'));
  }
}
