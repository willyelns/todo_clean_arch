import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../../commons/extensions/mobx/mobx_extensions.dart';
import '../../../../../commons/extensions/theme/theme_context.dart';
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
  final List<ReactionDisposer> _disposers = [];

  TodoStore get _todoStore => serviceLocator<TodoStore>();

  @override
  void initState() {
    super.initState();
    _todoStore.retrieveAllTasks();
    debugPrint('list: ${_todoStore.todoTasks}');

    _setUpDisposers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do list with - MobX'),
      ),
      body: Observer(
        builder: (context) {
          final state = _todoStore.currentState;

          switch (state) {
            case TodoState.initial:
              return const _InitialStateWidget();
            case TodoState.loading:
              return const _LoadingStateWidget();
            case TodoState.loaded:
            case TodoState.added:
            case TodoState.deleted:
              return const _LoadedStateWidget();
            case TodoState.empty:
              return const _EmptyStateWidget();
            case TodoState.error:
              return _ErrorStateWidget(
                errorMessage: _todoStore.errorMessage,
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

  @override
  void dispose() {
    _disposers.disposeAll();
    super.dispose();
  }

  Future<void> _addTask() async {
    await context.push(AppPages.addTaskMobx);
  }

  void _showDeletedSnackBar(BuildContext context) {
    context.showSnackBar(title: 'Task removed with success!');
  }

  void _setUpDisposers() {
    _disposers.add(reaction((_) => _todoStore.todoState, (state) {
      if (state == TodoState.deleted) {
        _showDeletedSnackBar(context);
      }
    }));

    _disposers.add(reaction((_) => _todoStore.todoState, (state) {
      if (state == TodoState.added) {
        _todoStore.todoState = TodoState.loaded;
      }
    }, delay: 500));
  }
}

class _EmptyStateWidget extends StatelessWidget {
  const _EmptyStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No tasks',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _LoadedStateWidget extends StatelessWidget {
  const _LoadedStateWidget({Key? key}) : super(key: key);

  TodoStore get _todoStore => serviceLocator<TodoStore>();
  List<TodoTask> get _todoTasks => _todoStore.todoTasks;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _todoStore.retrieveAllTasks,
      child: Builder(builder: (context) {
        return ListView.builder(
          itemCount: _todoTasks.length,
          itemBuilder: (context, index) {
            final todoTask = _todoTasks[index];
            return ListTile(
              leading: Checkbox(
                value: todoTask.completed,
                onChanged: (value) => _updateItem(todoTask, value),
              ),
              title: Text(todoTask.name),
              onLongPress: () => _deleteItem(context, todoTask),
            );
          },
        );
      }),
    );
  }

  void _updateItem(TodoTask todoTask, bool? value) {
    final task = todoTask.copyWith(completed: value);
    _todoStore.updateTodoTask(task);
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
              _todoStore.deleteTodoTask(todoTask);
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
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              title: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey[400],
                ),
              ),
            );
          }),
    );
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
