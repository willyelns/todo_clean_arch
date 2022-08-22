import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import '../../../../../commons/extensions/mobx/mobx_extensions.dart';

import '../../../../../injection_container.dart';
import '../../../../../routes/app_pages.dart';
import '../../../domain/entities/todo_task.dart';
import '../../page_states/todo_state.dart';
import '../stores/todo_store.dart';

class HomePageMobx extends StatefulWidget {
  const HomePageMobx({Key? key}) : super(key: key);

  @override
  _HomePageMobxState createState() => _HomePageMobxState();
}

class _HomePageMobxState extends State<HomePageMobx> {
  final todoStore = serviceLocator<TodoStore>();

  List<ReactionDisposer> disposers = [];

  Future<void> _addTask() async {
    await context.push(AppPages.addTaskMobx);
  }

  @override
  void initState() {
    super.initState();
    todoStore.retrieveAllTasks();
    debugPrint('list: ${todoStore.todoTasks}');

    disposers.add(reaction((_) => todoStore.todoState, (state) {
      if (state == TodoState.deleted) {
        _showDeletedSnackBar(context);
      }
    }));

    disposers.add(reaction((_) => todoStore.todoState, (state) {
      if (state == TodoState.added) {
        todoStore.todoState = TodoState.loaded;
      }
    }, delay: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do list with - MobX'),
      ),
      body: Observer(
        builder: (context) {
          final state = todoStore.currentState;

          switch (state) {
            case TodoState.initial:
              return const _InitialStateWidget();
            case TodoState.loading:
              return const _LoadingStateWidget();
            case TodoState.loaded:
            case TodoState.added:
            case TodoState.deleted:
              return const _LoadedStateWidget();
            case TodoState.error:
              return _ErrorStateWidget(
                errorMessage: todoStore.errorMessage,
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add new Task',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeletedSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Task removed with success!'),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          // do something
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    disposers.disposeAll();
    super.dispose();
  }
}

class _LoadedStateWidget extends StatelessWidget {
  const _LoadedStateWidget({Key? key}) : super(key: key);

  TodoStore get todoStore => serviceLocator<TodoStore>();
  List<TodoTask> get todoTasks => todoStore.todoTasks;

  @override
  Widget build(BuildContext context) {
    if (todoTasks.isEmpty) {
      return const Center(child: Text('No tasks'));
    }
    return RefreshIndicator(
      onRefresh: todoStore.retrieveAllTasks,
      child: ListView.builder(
        itemCount: todoTasks.length,
        itemBuilder: (context, index) {
          final todoTask = todoTasks[index];
          return ListTile(
            leading: Checkbox(
              value: todoTask.completed,
              onChanged: (value) {
                final task = todoTask.copyWith(completed: value);
                todoStore.updateTodoTask(task);
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
        title: const Text('Delete'),
        content: Text('Delete this task: ${todoTask.name}'),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              todoStore.deleteTodoTask(todoTask);
              context.pop();
            },
            child: const Text('Confirm'),
          )
        ],
      ),
    );
  }
}

class _ErrorStateWidget extends StatelessWidget {
  const _ErrorStateWidget({
    required this.errorMessage,
    Key? key,
  }) : super(key: key);

  final String errorMessage;

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
    return const Center(child: CircularProgressIndicator());
  }
}

class _InitialStateWidget extends StatelessWidget {
  const _InitialStateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Initial State'));
  }
}
