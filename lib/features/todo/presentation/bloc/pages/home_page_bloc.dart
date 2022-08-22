import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../commons/extensions/theme/theme_context.dart';
import '../../../../../injection_container.dart';
import '../../../../../routes/app_pages.dart';
import '../../../domain/entities/todo_task.dart';
import '../todo_bloc.dart';

class HomePageBloc extends StatefulWidget {
  const HomePageBloc({Key? key}) : super(key: key);

  @override
  _HomePageBlocState createState() => _HomePageBlocState();
}

class _HomePageBlocState extends State<HomePageBloc> {
  TodoBloc get _todoBloc => serviceLocator<TodoBloc>();

  @override
  void initState() {
    super.initState();
    _todoBloc.add(TodoList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (context) => _todoBloc,
      child: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoDeletedState) {
            _showDeletedSnackBar(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('To do list - Bloc'),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                if (state is TodoLoadingState) {
                  return const _LoadingStateWidget();
                }
                if (state is TodoInitialState) {
                  return const Center(child: Text('Initial value'));
                }
                if (state is TodoLoadedState) {
                  return _LoadedStateWidget(
                    todoTasks: state.todoTasks,
                  );
                }
                return const Text('Error to handle');
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _addTask,
              tooltip: 'Add Todo task',
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  void _showDeletedSnackBar(BuildContext context) {
    context.showSnackBar(title: 'Task removed with success!');
  }

  Future<void> _addTask() async {
    await context.push(AppPages.addTaskBloc);
  }
}

class _LoadingStateWidget extends StatelessWidget {
  const _LoadingStateWidget({Key? key}) : super(key: key);

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

class _LoadedStateWidget extends StatelessWidget {
  const _LoadedStateWidget({
    required this.todoTasks,
    Key? key,
  }) : super(key: key);

  TodoBloc get _todoBloc => serviceLocator<TodoBloc>();
  final List<TodoTask> todoTasks;

  @override
  Widget build(BuildContext context) {
    if (todoTasks.isEmpty) {
      return const Center(
        child: Text(
          'No tasks',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () async => _todoBloc.add(TodoList()),
      child: ListView.builder(
        itemCount: todoTasks.length,
        itemBuilder: (context, index) {
          final todoTask = todoTasks[index];
          return ListTile(
            leading: Checkbox(
              value: todoTask.completed,
              onChanged: (value) => _updateItem(todoTask, value),
            ),
            title: Text(todoTask.name),
            onLongPress: () => _deleteItem(context, todoTask),
          );
        },
      ),
    );
  }

  void _updateItem(TodoTask todoTask, bool? value) {
    final task = todoTask.copyWith(completed: value);
    _todoBloc.add(TodoUpdated(task));
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
              _todoBloc.add(TodoDeleted(todoTask));
              context.pop();
            },
            child: const Text('Confirm'),
          )
        ],
      ),
    );
  }
}
